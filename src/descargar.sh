#!/bin/bash -e

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"  # directorio del archivo actual, no entiendo del todo como funciona
ASSETS_PATH="$SCRIPT_PATH/../assets"  # ruta de directorio de assets


function verificar_arch {
	#esta funcion verifica si existen el archivo.
	#caso contrario se notifica al usuario.
	
	cd "$SCRIPT_PATH"
	local ARCH=$1
	if [ ! -f "$ARCH" ]; then
		echo "el archivo"
		echo " "
		echo "$ARCH"
		echo " "
		echo "no existe"
		exit 1
	fi
}


function reset_dir_raw {
	# Esta funcion elimina la carpeta assets/raw si esta existe y luego la crea vacia

	[[ -d "$ASSETS_PATH/raw" ]] && rm -r "$ASSETS_PATH/raw"
	mkdir "$ASSETS_PATH/raw"
}


function desc_arch {
	#funcion para descomprimir archivos de imagen que esten en el directorio assets/dataset/.
	#los archivos descomprimidos seran guardados en el directorio assets/dataset/raw
	
	cd "$ASSETS_PATH/dataset"
	cp "$1" "$ASSETS_PATH/raw/"
	cd "$ASSETS_PATH/raw"
	tar xzvf "$1"
	rm "$1"
}

function descomprimir {
	#funcion principal.
	#Primero verifica que se hallan pasado 2 argumentos.
	if [ $# -ne 2 ]; then
		echo "Se deben pasar 2 argumentos"
		exit 1
	fi

	#asignacion de argumentos a variables.

	local ARCHCOMP="$ASSETS_PATH/dataset/$1"
	local ARCHSUM="$ASSETS_PATH/dataset/$2"

	#verificamos que los archivos existan con la funcion verificar_arch.

	verificar_arch "$ARCHCOMP"
	verificar_arch "$ARCHSUM"

	#verificar que coincidan la suma de los archivos comprimidos con la de los descomprimidos.
	SUM=($(md5sum $ARCHCOMP))
	REALSUM=${SUM[0]}

	SAVEDSUM=$(cat $ARCHSUM)

	if [[ "$REALSUM" == "$SAVEDSUM" ]]
	then
		desc_arch "$1"
	fi

	#mostrar informacion

	echo "Archivos descomprimidos: "
	echo " "
	ls -la "$ASSETS_PATH/raw"
}	

function run {
	reset_dir_raw
	descomprimir "$1" "$2"
}

run

exit 0
