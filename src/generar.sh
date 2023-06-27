#!/bin/bash -e

# Genera imágenes utilizando algún servicios web. Se debe
# poder indicar por argumento cuantas imagenes generar y se deben asignar
# nombres de archivo al azar de una lista de nombres de personas. Tener
# en cuenta que al descargar de una página conviene usar un sleep entre
# descarga y descarga para no saturar el servicio y evitar problemas. Luego
# se deben comprimir las imágenes, y generar un archivo con su suma de
# verificación.

# modificacion en rama generar

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"  # directorio del archivo actual
ASSETS_PATH="$SCRIPT_PATH/../assets"  # ruta de directorio de assets
# echo $SCRIPT_PATH
# echo $ASSETS_PATH


function descargar_nombres {
	if [[ ! -f "$ASSETS_PATH/nombres.csv" ]]
	then
		clear
		echo "el archivo assets/nombres.csv no existe, se intentara descargarlo..."
		echo "descargando nombres desde https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv"
		echo " "
		echo " "
		sleep 2
		wget "https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv" -O "$ASSETS_PATH/nombres.csv"
		echo nombres descargados!
		sleep 3
	fi
}

function leer_nombres {
	# leer el archivo de nombres
	sleep 1
}

function elegir_nombre {
	# esta funcion deberia
	## elegir un nombre al azar y devolverlo
	echo marta
}

function descargar_imagenes {
	clear
	while :
	do
		read -p "Ingrese la cantidad de imagenes a decargar (numero entero positivo): " CANT
		[[ $CANT =~ ^[1-9]{1}[0-9]*$ ]] || (echo "$CANT no es un numero valido" && continue)
		for I in $(seq 1 $CANT)
		do
			clear
			echo "Descargando imagen $I de $CANT"
			echo " "
			echo " "
			curl -L 'https://source.unsplash.com/random/900%C3%97700/?person' -o "$ASSETS_PATH/$I.jpeg"
			echo " "
			echo " "
			echo "Descargada"
			sleep 1
		done
		clear
		break
	done
}

descargar_nombres
descargar_imagenes

exit 0
