#!/bin/bash

function validarNumero () {
	if [[ ! $1 =~ ^[0-9]+$ ]]; then
    		echo "Entrada no válida. Por favor, ingrese números enteros."
    		exit 1
	fi
}

read -p "Ingrese el primer numero: " n1
validarNumero $n1
read -p "Ingrese el segundo numero: " n2
validarNumero $n2
read -p "Ingrese el tercer numero: " n3
validarNumero $n3
read -p "Ingrese el cuarto numero: " n4
validarNumero $n4
read -p "Ingrese el quinto numero: " n5
validarNumero $n5

if [[ ! $n1 =~ ^[0-9]+$ ]] && [[ ! $n1 =~ ^[0-9]+$ ]]; then
    echo "Entrada no válida. Por favor, ingrese números enteros."
    exit 1
fi


CACHE=$n1
for I in $n1 $n2 $n3 $n4 $n5
do 
	if [ $I -gt $CACHE ]; then
		CACHE=$I
	fi
done

echo "El numero mayor es: " $CACHE
