#!/bin/bash -e

# Se deberán recortar las imágenes a una resolución de 512*512
# con alguna utilidad como imagemagick. Solamente deben procesarse aque-
# llas imágenes que tengan nombres de personas. Entiéndase por nombres de
# personas a cualquier combinación de palabras que empiecen con mayúsculas
# y sigan por minúsculas.

# modificacion en rama procesar


SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ASSETS_PATH="$SCRIPT_PATH/../assets"

convert entrada.jpg -gravity center -resize 512x512+0+0 \
-extent 512x512 salida.jpg

exit 0
