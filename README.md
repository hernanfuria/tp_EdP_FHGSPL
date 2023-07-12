# Trabajo practico de entorno de programacion - Comision 1
## Integrantes
- Furiasse Hernan
- Guzman Santiago
- Perotto Leonel

## Acerca de
Este proyecto permite descargar una cantidad deseada de imagenes de internet en `assets/dataset`, usando nombres aleatorios de personas.
Las imagenes con nombres que comienzan con una mayuscula se procesan para ser de 512x512 px.
Finalmente se crea un archivo comprimido en `assets/comp` que contiene:
- todas las imagenes
- un documento con todos los nombres de las imagenes
- un documento con todos los nombres que comienzan con una mayuscula
- un documento con todos los nombres que terminan en "a"

## Como ejecutar el proyecto
El proyecto se ejecuta dentro de un contenedor usando docker ( https://www.docker.com/ ), y toda la configuracion se hace de forma automatica en un script de bash.
Para ejecutar el proyecto se necesita tener docker instalado ( https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository ) y es recomendable tener git ( https://git-scm.com/ )

Primero se debe hacer una copia local del repositorio de este proyecto usando

```console
$ git clone https://github.com/hernanfuria/tp_EdP_FHGSPL.git
```
o
```console
$ git clone git@github.com:hernanfuria/tp_EdP_FHGSPL.git
```

Luego hacer `cd` al directorio raiz del repositorio, y ejecutar el comando
```console
$ bash run.sh
```

NOTA:
Una vez finalizado el proceso, los archivos manipulados estaran dentro del directorio assets, pero pueden ser propiedad del usuario `root`. Para revertir esto se pueden ejecutar los siguientes comandos:
```console
$ sudo chown -R <nombre_usuario> assets/
$ sudo chgrp -R <nombre_usuario> assets/
```

## Consignas
https://campusv.fceia.unr.edu.ar/pluginfile.php/227147/mod_resource/content/1/Trabajo%20Pr%C3%A1ctico%20Final%20Entornos%202023.pdf

