#!/bin/bash -e

# Se deberán recortar las imágenes a una resolución de 512*512
# con alguna utilidad como imagemagick. Solamente deben procesarse aque-
# llas imágenes que tengan nombres de personas. Entiéndase por nombres de
# personas a cualquier combinación de palabras que empiecen con mayúsculas
# y sigan por minúsculas.

# modificacion en rama procesar


SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ASSETS_PATH="$SCRIPT_PATH/../assets"


function check_raw {
	#Esta funcion checkea que exista de la carpeta raw

	[[ ! -d "$ASSETS_PATH/raw" ]] && echo "Ejecute antes descomprimir" && exit 1
}

function reset_dir_proc {
	# Esta funcion elimina la carpeta assets/proc si esta existe y luego la crea vacia

	[[ -d "$ASSETS_PATH/proc" ]] && rm -r "$ASSETS_PATH/proc"
	mkdir "$ASSETS_PATH/proc"
}	

function procesar_ima {
	
	ls "$ASSETS_PATH/raw" | while read Archs
        do
		echo $Archs
		if [[ "$Archs" =~ ^[A-Z]{1}[a-z]*.*$ ]]
		then
			echo "se esta convirtiendo $Archs"
			convert "$ASSETS_PATH/raw/$Archs" -gravity center -resize 512x512+0+0 -extent 512x512 "$ASSETS_PATH/proc/$Archs"
		else
			cp "$ASSETS_PATH/raw/$Archs" "$ASSETS_PATH/proc/$Archs"
		fi
	done
		}

function run {
	# Esta funcion ejecuta el proceso en orden

	check_raw
	reset_dir_proc
	procesar_ima
}

run

