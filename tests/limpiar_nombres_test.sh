#!/bin/bash -e

function limpiar_nombre {
        # esta funcion toma como argumento un string de la forma <nombre>,<numero> y retorna solo <nombre>

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

TEST_LINE="$1"
limpiar_nombre "$TEST_LINE"

exit 0
