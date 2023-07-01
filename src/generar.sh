#!/bin/bash -e

# Genera imágenes utilizando algún servicios web. Se debe
# poder indicar por argumento cuantas imagenes generar y se deben asignar
# nombres de archivo al azar de una lista de nombres de personas. Tener
# en cuenta que al descargar de una página conviene usar un sleep entre
# descarga y descarga para no saturar el servicio y evitar problemas. Luego
# se deben comprimir las imágenes, y generar un archivo con su suma de
# verificación.

# modificacion en rama generar

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"  # directorio del archivo actual, no entiendo del todo como funciona
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

function reset_dir_dataset {
	[[ -d "$ASSETS_PATH/dataset" ]] && rm -r "$ASSETS_PATH/dataset"
	mkdir "$ASSETS_PATH/dataset"
}

function limpiar_nombre {
        # esta funcion toma como argumento un string de la forma <nombre>,<numero> y retorna solo <nombre>

	local LINE
	local NOMBRE

        LINE="$1"
        NOMBRE=""
        for (( I=0; I<${#LINE}; I++ ))
        do
                C=${LINE:$I:1}
                [[ $C == "," ]] && break
                NOMBRE="$NOMBRE$C"
        done

        echo $NOMBRE
}

function descargar_imagenes {
	clear
	while :
	do
		read -p "Ingrese la cantidad de imagenes a decargar (numero entero positivo): " CANT
		[[ $CANT =~ ^[1-9]{1}[0-9]*$ ]] || (echo "$CANT no es un numero valido" && continue)
		
		I=1
		shuf --head-count=$CANT $ASSETS_PATH/nombres.csv | while read LINE	
		do
			clear
			echo "Descargando imagen $I de $CANT" && I=$(( $I+1 )) && echo " " && echo " "
			
			NOMBRE_LIMPIO=$(limpiar_nombre "$LINE")
			
			# data de prueba para no descargar imagenes (no tengo internet)
			echo "$ASSETS_PATH/dataset/$NOMBRE_LIMPIO.jpeg"
			echo $NOMBRE_LIMPIO > "$ASSETS_PATH/dataset/$NOMBRE_LIMPIO.txt"

			# curl -L 'https://source.unsplash.com/random/900%C3%97700/?person' -o "$ASSETS_PATH/dataset/$NOMBRE_LIMPIO.jpeg"
			
			echo " " && echo " " &&  echo "Descargada"
			sleep 1
		done
		clear
		break
	done
}

function comprimir_imagenes_descargadas {
	# por el momento comprime .txt, modificar luego para .jpeg
	cd "$ASSETS_PATH/dataset/"
	tar cvzf dataset.tar.gz *.txt
	rm *.txt
	clear
}

descargar_nombres
reset_dir_dataset
descargar_imagenes
comprimir_imagenes_descargadas

exit 0
