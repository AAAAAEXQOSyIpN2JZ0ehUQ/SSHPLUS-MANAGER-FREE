📦 SSHPlus Bash Obfuscador Web

SSHPlus Bash Obfuscador Web es una herramienta en línea diseñada para ofuscar y desofuscar variables 
utilizadas en scripts relacionados con SSHPlus Manager. Su propósito es proteger rutas, claves y 
configuraciones de forma sencilla pero efectiva, directamente desde el navegador.

Este proyecto está dirigido a desarrolladores y usuarios que trabajan con scripts bash en entornos 
VPS/SSH y desean añadir una capa ligera de seguridad u ocultamiento a sus datos sensibles.

✔️ Características principales

- Interfaz web minimalista, sin dependencias externas.
- Métodos de ofuscación:
  - `sed` + `rev` para ocultar rutas y cadenas.
  - `awk` para extracción de claves por campos.
  - Inserción de caracteres aleatorios como ruido.
- Soporte para desofuscación (vista inversa del contenido real).
- Compatible con scripts del entorno SSHPlus Manager.
- Ideal para proteger rutas como `/usr/local/lib` o claves como `usuario:clave`.

-----------------------------------------------------------------------------------

💡 Ejemplos de uso del Ofuscador Bash

🔁 sed a-z. + rev

decoded.public.ran

🔓 Resultado: _lnk=$(echo '2a&1x9r.i×p1×l#u$sb0&n8o&c2#e&d' | sed -e 's/[^a-z.]//ig' | rev)

🔁 sed a-z/

/usr/local/bin/

🔓 Resultado: _Ink=$(echo '/u#s3×r/l×o#c1a×l/b1×i4n/' | sed -e 's/[^a-z/]//ig')

🔁 solo rev

flash-input

🔓 Resultado: krm=$(echo 'tupni-hsalf' | rev)

-----------------------------------------------------------------------------------

💡 Ejemplos de uso del Desofuscador Bash

🔁 Método: sed a-z. + rev

_lnk=$(echo 't1:e#n.5s0ul&p4hs$s.0729t9p$&8i&&9r7827c032:3s' | sed -e 's/[^a-z.]//ig' | rev)

🔓 Resultado: script.sshplus.net

🔁 Método: sed a-z/

_Ink=$(echo '/3×u3#s87r/l32o4×c1a×l1/83×l24×i0b×' | sed -e 's/[^a-z/]//ig')

🔓 Resultado: /usr/local/lib

🔁 Método: sed a-z/ (variante simplificada)

_1nk=$(echo '/3×u3#s×87r/83×l2×4×i0b×' | sed -e 's/[^a-z/]//ig')

🔓 Resultado: /usr/lib

🔁 Método: solo rev

krm=$(echo '5:q-3gs2.o7%8:1' | rev)

🔓 Resultado: 1:8%7o.2sg3-q:5

-----------------------------------------------------------------------------------

🧰 Tip: Cómo crear tus propios strings ofuscados

1. Escribe el texto o ruta en el campo de entrada.
2. Selecciona el método deseado.
3. Copia el resultado generado.
4. Pégalo en tu script o terminal Bash.
