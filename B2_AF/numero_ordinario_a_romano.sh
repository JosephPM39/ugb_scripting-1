#!/bin/bash

declare -A numeros_romanos
numeros_romanos[1]='I'
numeros_romanos[4]='IV'
numeros_romanos[5]='V'
numeros_romanos[9]='IX'
numeros_romanos[10]='X'
numeros_romanos[40]='XL'
numeros_romanos[50]='L'
numeros_romanos[90]='XC'
numeros_romanos[100]='C'
numeros_romanos[400]='CD'
numeros_romanos[500]='D'
numeros_romanos[900]='CM'
numeros_romanos[1000]='M'

function convertir_a_romano {
    local num=$1
    local res=""

    for entero_romano in 1000 900 500 400 100 90 50 40 10 9 5 4 1; do
        while ((num >= entero_romano)); do
            res+="${numeros_romanos[$entero_romano]}"
            ((num -= entero_romano))
        done
    done

    echo "$res"
}

echo "Ingresa un número entero:"
read num

if [[ $num =~ ^[0-9]+$ ]]; then
    numero_romano=$(convertir_a_romano $num)
    echo "El número $num en números romanos es: $numero_romano"
else
    echo "Entrada no válida. Por favor, ingresa un número entero."
fi
