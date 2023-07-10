#!/bin/bash -e

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"  # directorio del archivo actual, no entiendo del todo como funciona
ASSETS_PATH="$SCRIPT_PATH/../assets"  # ruta de directorio de assets


function quitar_ext {
        # Esta funcion toma como argumento un string de la forma <filename>.<ext> y retorna solo <filename>
	# Conserva nombre solo hasta primer "." encontrado.

	local LINE
	local NOMBRE

        LINE="$1"
        NOMBRE=""
        for (( I=0; I<${#LINE}; I++ ))
        do
                C=${LINE:$I:1}
                [[ $C == "." ]] && break
                NOMBRE="$NOMBRE$C"
        done

        echo $NOMBRE
}


function reset_dir_comp {
	# Esta funcion elimina la carpeta assets/comp si esta existe y luego la crea vacia

	[[ -d "$ASSETS_PATH/comp" ]] && rm -r "$ASSETS_PATH/comp"
	mkdir "$ASSETS_PATH/comp"
}


function nombres_todas_img {
	# Esta funcion crea un archivo assets/comp/nombres_todos con los nombres de todas las imagenes del dataset
	
	touch "$ASSETS_PATH/comp/nombres_todos"
	ls "$ASSETS_PATH/proc" | while read LINE
	do
		echo "$(quitar_ext "$LINE")" >> "$ASSETS_PATH/comp/nombres_todos"
	done
}


function nombres_validos_img {
	# Esta funcion crea un archivo assets/comp/nombres_validos con los nombres de las imagenes procesadas
	
	touch "$ASSETS_PATH/comp/nombres_validos"
        ls "$ASSETS_PATH/proc" | while read LINE
        do
		NOMBRE="$(quitar_ext "$LINE")"
		if [[ $NOMBRE =~ ^[A-Z]{1}[a-z]+.*$ ]]
		then
                	echo $NOMBRE >> "$ASSETS_PATH/comp/nombres_validos"
        	fi
	done
}


function nombres_finalizados_a {
	# Esta funcion crea un archivo assets/comp/nombres_a con los nombres validos terminados en "a"

	touch "$ASSETS_PATH/comp/nombres_a"
        ls "$ASSETS_PATH/proc" | while read LINE
        do
                NOMBRE="$(quitar_ext "$LINE")"
		if [[ $NOMBRE =~ ^[A-Z]{1}[a-z]+.*(a){1}$ ]]
                then
                        echo $NOMBRE >> "$ASSETS_PATH/comp/nombres_a"
                fi
        done
}


function comprimir_todo {
	# Esta funcion comprime:
	# - assets/comp/nombres_todos
	# - assets/comp/nombres_validos
	# - assets/comp/nombres_a
	# - assets/proc/*.jpeg
	# en assets/comp/results.tar.gz y elimina el resto del contenido de assets/comp

	cd "$ASSETS_PATH/proc/"
	cp * "$ASSETS_PATH/comp/"
	cd "$ASSETS_PATH/comp/"
	tar cvzf results.tar.gz *
	rm nombres_todos
	rm nombres_validos
	rm nombres_a
	rm *.jpeg
	clear
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
