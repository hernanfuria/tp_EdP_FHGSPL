#!/bin/bash -e


SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"  # directorio del archivo actual, no entiendo del todo como funciona
SOURCE_PATH="$SCRIPT_PATH/../src"  # ruta de directorio src


clear

PS3="Opcion > "
echo "Elija accion:"
select ACTION in "Generar" "Descomprimir" "Procesar" "Comprimir" "Salir"
do
        [[ -e $ACTION ]] && echo "Seleccione opcion valida" && continue
        [[ $REPLY == 5 ]] && clear && break

        case $REPLY in
		1) 	read -p "Ingrese nombre del archivo comprimido a generar: " ARCHCOMP
			read -p "Ingrese nombre del archivo suma a generar: " ARCHSUMA
			/bin/bash "$SOURCE_PATH/generar.sh" "$ARCHCOMP" "$ARCHSUMA"
			;;
                2) 	read -p "Ingrese nombre del archivo comprimido a descomprimir: " ARCHCOMP
                        read -p "Ingrese nombre del archivo suma guardado: " ARCHSUMA
                        /bin/bash "$SOURCE_PATH/descargar.sh" "$ARCHCOMP" "$ARCHSUMA"
                        ;;

                3) /bin/bash "$SOURCE_PATH/procesar.sh";;
		4) /bin/bash "$SOURCE_PATH/comprimir.sh";;
        esac

	clear
        echo "Elija accion:"
	echo "1) Generar"
	echo "2) Descomprimir"
	echo "3) Procesar"
	echo "4) Comprimir"
	echo "5) Salir"
done

exit 0
