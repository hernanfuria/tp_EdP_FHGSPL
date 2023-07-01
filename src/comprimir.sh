#!/bin/bash -e

# Una vez procesadas las imágenes se debe generar un
# archivo con la lista de todas las personas, un total de personas femeninas
# y masculinas; y luego comprimir todo en un solo archivo. Entiéndase por
# persona femenina aquella cuya ultima letra del primer nombre es una letra
# “a”. El archivo generado debe poder accederse fuera del contenedor.

# modificacion de prueba en rama comprimir

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
	
	nombres_todas_img
	nombres_validos_img
	nombres_finalizados_a
	comprimir_todo
}

run

exit 0
