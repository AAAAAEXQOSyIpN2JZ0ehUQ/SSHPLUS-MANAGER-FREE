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

💡 Ejemplos de uso

```bash
_lnk=$(echo 't1:e#n.5s0ul&p4hs$s.0729t9p$&8i&&9r7827c032:3s'| sed -e 's/[^a-z.]//ig'| rev)
_Ink=$(echo '/3×u3#s87r/l32o4×c1a×l1/83×l24×i0b×'|sed -e 's/[^a-z/]//ig')
_1nk=$(echo '/3×u3#s×87r/83×l2×4×i0b×'|sed -e 's/[^a-z/]//ig')
krm=$(echo '5:q-3gs2.o7%8:1'|rev)
