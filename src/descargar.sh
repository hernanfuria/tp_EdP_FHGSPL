#!/bin/bash -e

# escarga un archivo comprimido de imágenes. De debe
# poder indicar por argumento dos archivos (uno con las imágenes y otro
# con una suma de verificación). Si ocurrió algún error se debe informar al
# usuario de lo contrario se procede a descomprimir

# cambio en rama descargar

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

function desc_arch {
	#funcion para descomprimir archivos de imagen que esten en el directorio assets/dataset/.
	#los archivos descomprimidos seran guardados en el directorio assets/dataset/raw
	cd "ASSETS_PATH/dataset/raw"
	local ARCHCOMP=$1
	tar -xzvf "$ARCHCOMP"
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
	#VER

	#mostrar informacion

	echo "Archivos descomprimidos: "
	echo " "
	ls -la "$ASSETS_PATH/dataset/raw"
}	
