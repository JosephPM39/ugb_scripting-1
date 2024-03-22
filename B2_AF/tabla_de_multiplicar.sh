#!/bin/bash

function obtener_tabla () {
	num=$1
	limite=$2
	for I in $(seq $limite)
	do
		echo "$num X $I = $(($num * $I))"
	done
}

read -p "Ingrese el numero entero: " num
read -p "Ingrese el limite de la tabla: " limite

if [[ ! $num =~ ^[0-9]+$ ]] && [[ ! $limite =~ ^[0-9]+$ ]]; then
    echo "Entrada no válida. Por favor, ingrese números enteros."
    exit 1
fi

obtener_tabla $num $limite
