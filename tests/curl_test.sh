#!/bin/bash -e

[$# -ne 1] && echo cantidad de argumentos invalida && exit 1

CANT=$1
for I in $(seq $CANT)
do
	curl -L 'https://source.unsplash.com/random/900%C3%97700/?person' -o ./$I.jpeg
	sleep 1
done















# curl 'https://images.unsplash.com/photo-1539698103494-a76dd0436fbc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8cGVyc29ufHx8fHx8MTY4Njk1OTE1OQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080' -o $P

exit 0
