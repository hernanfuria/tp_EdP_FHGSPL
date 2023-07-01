#!/bin/bash -e

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"  # directorio del archivo actual, no entiendo del todo como funciona
ASSETS_PATH="$SCRIPT_PATH/../assets"  # ruta de directorio de assets


function descargar_nombres {
	# Esta funcion descarga el .csv de nombres si este no existe

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
	# Esta funcion elimina la carpeta assets/dataset si esta existe y luego la crea vacia

	[[ -d "$ASSETS_PATH/dataset" ]] && rm -r "$ASSETS_PATH/dataset"
	mkdir "$ASSETS_PATH/dataset"
}


function limpiar_nombre {
        # Esta funcion toma como argumento un string de la forma <nombre>,<numero> y retorna solo <nombre>

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
	# Esta funcion descarga imagenes dentro del directorio assets/dataset.
	# Se le pide al usuario la cantidad de imagenes a descargar.
	# Cada imagen recibe un nombre de persona aleatorio obtenido del archivo assets/nombres.csv

	local CANT
	local NOMBRE_LIMPIO

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
			# echo "$ASSETS_PATH/dataset/$NOMBRE_LIMPIO.jpeg"
			# echo $NOMBRE_LIMPIO > "$ASSETS_PATH/dataset/$NOMBRE_LIMPIO.txt"

			curl -L 'https://source.unsplash.com/random/900%C3%97700/?person' -o "$ASSETS_PATH/dataset/$NOMBRE_LIMPIO.jpeg"
			
			echo " " && echo " " &&  echo "Descargada"
			sleep 1
		done
		clear
		break
	done
}


function comprimir_imagenes_descargadas {
	# Esta funcion comprime las imagenes descargadas en un archivo assets/dataset/dataset.tar.gz
	# y elimina las imagenes para dejar solo el archivo comprimido

	cd "$ASSETS_PATH/dataset/"
	tar cvzf dataset.tar.gz *.jpeg
	rm *.jpeg
	clear
}


function generar_arch_suma {
	# Esta funcion genera la suma del archivo assets/dataset/dataset.tar.gz 
	# y la guarda en assets/dataset/dataset_sum

	cd "$ASSETS_PATH/dataset/"
	SUM=($(md5sum dataset.tar.gz))
	echo ${SUM[0]} > dataset_sum
}


descargar_nombres
reset_dir_dataset
descargar_imagenes
comprimir_imagenes_descargadas
generar_arch_suma

exit 0
