#!/bin/bash -e


PS3="Opcion > "
echo "Elija accion:"
select ACTION in "Generar" "Descomprimir" "Procesar" "Comprimir" "Salir"
do
        [[ -e $ACTION ]] && echo "Seleccione opcion valida" && continue
        [[ $REPLY == 5 ]] && clear && break

        case $REPLY in
		1) 	read -p "Ingrese nombre del archivo comprimido a generar: " ARCHCOMP
			read -p "Ingrese nombre del archivo suma a generar: " ARCHSUMA
			bash generar.sh "$ARCHCOMP" "$ARCHSUMA"
			;;
                2) 	read -p "Ingrese nombre del archivo comprimido a descomprimir: " ARCHCOMP
                        read -p "Ingrese nombre del archivo suma guardado: " ARCHSUMA
                        bash descargar.sh "$ARCHCOMP" "$ARCHSUMA"
                        ;;

                3) bash procesar.sh;;
		4) bash comprimir.sh;;
        esac

exit 0
