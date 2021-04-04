#!/usr/bin/env python

import sys
import httplib
from SocketServer import ThreadingMixIn
from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from threading import Lock, Timer
from cStringIO import StringIO
from urlparse import urlsplit
import socket
import select
import gzip
import zlib
import re
import traceback

if sys.argv[2:]:
 msg1 = sys.argv[2]
else:
 msg1 = "ADM-ULTIMATE"


class ThreadingHTTPServer(ThreadingMixIn, HTTPServer):

    address_family = socket.AF_INET

    def handle_error(self, request, client_address):
        
        print >>sys.stderr, '-'*40
        print >>sys.stderr, 'Exception happened during processing of request from', client_address
        traceback.print_exc()
        print >>sys.stderr, '-'*40
        
     
class ThreadingHTTPServer6(ThreadingHTTPServer):

    address_family = socket.AF_INET6


class SimpleHTTPProxyHandler(BaseHTTPRequestHandler):
    global_lock = Lock()
    conn_table = {}
    timeout = 300               
    upstream_timeout = 300    
    proxy_via = None          

    def log_error(self, format, *args):
        if format == "Request timed out: %r":
            return
        self.log_message(format, *args)

    def do_CONNECT(self):
        

        req = self
        reqbody = None
        req.path = "https://%s/" % req.path.replace(':443', '')

        replaced_reqbody = self.request_handler(req, reqbody)
        if replaced_reqbody is True:
            return

        u = urlsplit(req.path)
        address = (u.hostname, u.port or 443)
        try:
            conn = socket.create_connection(address)
        except socket.error:
            return
        self.send_response(200, msg1)
        self.send_header('Connection', 'close')
        self.end_headers()

        conns = [self.connection, conn] 
        keep_connection = True
        while keep_connection:
            keep_connection = False
            rlist, wlist, xlist = select.select(conns, [], conns, self.timeout)
            if xlist:
                break
            for r in rlist:
                other = conns[1] if r is conns[0] else conns[0]
                data = r.recv(8192)
                if data:
                    other.sendall(data)
                    keep_connection = True
        conn.close()

    def do_HEAD(self):
        self.do_SPAM()

    def do_GET(self):
        self.do_SPAM()

    def do_POST(self):
        self.do_SPAM()

    def do_SPAM(self):
        req = self
        content_length = int(req.headers.get('Content-Length', 0))
        if content_length > 0:
            reqbody = self.rfile.read(content_length)
        else:
            reqbody = None

        replaced_reqbody = self.request_handler(req, reqbody)
        if replaced_reqbody is True:
            return
        elif replaced_reqbody is not None:
            reqbody = replaced_reqbody
            if 'Content-Length' in req.headers:
                req.headers['Content-Length'] = str(len(reqbody))

        
        self.remove_hop_by_hop_headers(req.headers)
        if self.upstream_timeout:
            req.headers['Connection'] = 'Keep-Alive'
        else:
            req.headers['Connection'] = 'close'
        if self.proxy_via:
            self.modify_via_header(req.headers)

        try:
            res, resdata = self.request_to_upstream_server(req, reqbody)
        except socket.error:
            return

        content_encoding = res.headers.get('Content-Encoding', 'identity')
        resbody = self.decode_content_body(resdata, content_encoding)

        replaced_resbody = self.response_handler(req, reqbody, res, resbody)
        if replaced_resbody is True:
            return
        elif replaced_resbody is not None:
            resdata = self.encode_content_body(replaced_resbody, content_encoding)
            if 'Content-Length' in res.headers:
                res.headers['Content-Length'] = str(len(resdata))
            resbody = replaced_resbody

        self.remove_hop_by_hop_headers(res.headers)
        if self.timeout:
            res.headers['Connection'] = 'Keep-Alive'
        else:
            res.headers['Connection'] = 'close'
        if self.proxy_via:
            self.modify_via_header(res.headers)

        self.send_response(res.status, res.reason)
        for k, v in res.headers.items():
            if k == 'set-cookie':
                
                for value in self.split_set_cookie_header(v):
                    self.send_header(k, value)
            else:
                self.send_header(k, v)
        self.end_headers()

        if self.command != 'HEAD':
            self.wfile.write(resdata)
            with self.global_lock:
                self.save_handler(req, reqbody, res, resbody)

    def request_to_upstream_server(self, req, reqbody):
        u = urlsplit(req.path)
        origin = (u.scheme, u.netloc)

        
        req.headers['Host'] = u.netloc
        selector = "%s?%s" % (u.path, u.query) if u.query else u.path

        while True:
            with self.lock_origin(origin):
                conn = self.open_origin(origin)
                try:
                    conn.request(req.command, selector, reqbody, headers=dict(req.headers))
                except socket.error:
                    
                    self.close_origin(origin)
                    raise
                try:
                    res = conn.getresponse(buffering=True)
                except httplib.BadStatusLine as e:
                    if e.line == "''":
                        
                        self.close_origin(origin)
                        continue
                    else:
                        raise
                resdata = res.read()
                res.headers = res.msg    
                if not self.upstream_timeout or 'close' in res.headers.get('Connection', ''):
                    self.close_origin(origin)
                else:
                    self.reset_timer(origin)
            return res, resdata

    def lock_origin(self, origin):
        d = self.conn_table.setdefault(origin, {})
        if not 'lock' in d:
            d['lock'] = Lock()
        return d['lock']

    def open_origin(self, origin):
        conn = self.conn_table[origin].get('connection')
        if not conn:
            scheme, netloc = origin
            if scheme == 'https':
                conn = httplib.HTTPSConnection(netloc)
            else:
                conn = httplib.HTTPConnection(netloc)
            self.reset_timer(origin)
            self.conn_table[origin]['connection'] = conn
        return conn

    def reset_timer(self, origin):
        timer = self.conn_table[origin].get('timer')
        if timer:
            timer.cancel()
        if self.upstream_timeout:
            timer = Timer(self.upstream_timeout, self.close_origin, args=[origin])
            timer.daemon = True
            timer.start()
        else:
            timer = None
        self.conn_table[origin]['timer'] = timer

    def close_origin(self, origin):
        timer = self.conn_table[origin]['timer']
        if timer:
            timer.cancel()
        conn = self.conn_table[origin]['connection']
        conn.close()
        del self.conn_table[origin]['connection']

    def remove_hop_by_hop_headers(self, headers):
        hop_by_hop_headers = ['Connection', 'Keep-Alive', 'Proxy-Authenticate', 'Proxy-Authorization', 'TE', 'Trailers', 'Trailer', 'Transfer-Encoding', 'Upgrade']
        connection = headers.get('Connection')
        if connection:
            keys = re.split(r',\s*', connection)
            hop_by_hop_headers.extend(keys)

        for k in hop_by_hop_headers:
            if k in headers:
                del headers[k]

    def modify_via_header(self, headers):
        via_string = "%s %s" % (self.protocol_version, self.proxy_via)
        via_string = re.sub(r'^HTTP/', '', via_string)

        original = headers.get('Via')
        if original:
            headers['Via'] = original + ', ' + via_string
        else:
            headers['Via'] = via_string

    def decode_content_body(self, data, content_encoding):
        if content_encoding in ('gzip', 'x-gzip'):
            io = StringIO(data)
            with gzip.GzipFile(fileobj=io) as f:
                body = f.read()
        elif content_encoding == 'deflate':
            body = zlib.decompress(data)
        elif content_encoding == 'identity':
            body = data
        else:
            raise Exception("Unknown Content-Encoding: %s" % content_encoding)
        return body

    def encode_content_body(self, body, content_encoding):
        if content_encoding in ('gzip', 'x-gzip'):
            io = StringIO()
            with gzip.GzipFile(fileobj=io, mode='wb') as f:
                f.write(body)
            data = io.getvalue()
        elif content_encoding == 'deflate':
            data = zlib.compress(body)
        elif content_encoding == 'identity':
            data = body
        else:
            raise Exception("Unknown Content-Encoding: %s" % content_encoding)
        return data

    def split_set_cookie_header(self, value):
        re_cookies = r'([^=]+=[^,;]+(?:;\s*Expires=[^,]+,[^,;]+|;[^,;]+)*)(?:,\s*)?'
        return re.findall(re_cookies, value, flags=re.IGNORECASE)

    def request_handler(self, req, reqbody):
        
        pass

    def response_handler(self, req, reqbody, res, resbody):
     
        pass

    def save_handler(self, req, reqbody, res, resbody):
     
        pass




def test(HandlerClass=SimpleHTTPProxyHandler, ServerClass=ThreadingHTTPServer, protocol="HTTP/1.1"):
    if sys.argv[1:]:
        port = int(sys.argv[1])
    else:
        port = 8799
    server_address = ('', port)

    HandlerClass.protocol_version = protocol
    httpd = ServerClass(server_address, HandlerClass)

    sa = httpd.socket.getsockname()
    print "Serving HTTP on", sa[0], "port", sa[1], "..."
    httpd.serve_forever()


if __name__ == '__main__':
    test()

