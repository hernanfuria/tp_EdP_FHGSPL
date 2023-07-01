#!/bin/bash -e

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"  # directorio del archivo actual, no entiendo del todo como funciona
ASSETS_PATH="$SCRIPT_PATH/../assets"  # ruta de directorio de assets


function reset_dir_comp {
	# Esta funcion elimina la carpeta assets/comp si esta existe y luego la crea vacia

	[[ -d "$ASSETS_PATH/comp" ]] && rm -r "$ASSETS_PATH/comp"
	mkdir "$ASSETS_PATH/comp"
}

function nombres_todas_img {
	# Esta funcion crea un archivo assets/comp/nombres_todos con los nombres de todas las imagenes del dataset
	
	echo nombres_todas_img
}


function nombres_validos_img {
	# Esta funcion crea un archivo assets/comp/nombres_validos con los nombres de las imagenes procesadas
	
	echo nombres_todas_img
}


function nombres_finalizados_a {
	# Esta funcion crea un archivo assets/comp/nombres_a con los nombres validos terminados en "a"

	echo nombres_finalizados_a
}


function comprimir_todo {
	# Esta funcion comprime:
	# - assets/comp/nombres_todos
	# - assets/comp/nombres_validos
	# - assets/comp/nombres_a
	# - assets/proc/*.jpeg
	# en assets/comp/results.tar.gz y elimina el resto del contenido de assets/comp

	echo comprimir_todo
}

function run {
	# Esta funcion ejecuta el proceso en orden
	
	reset_dir_comp
	nombres_todas_img
	nombres_validos_img
	nombres_finalizados_a
	comprimir_todo
}

run

exit 0
