#!/bin/bash

# Solicitar el ingreso del primer numero
read -p "Ingrese el primer número: " num1

# Solicitar el segundo numero
read -p "Ingrese el segundo número: " num2

# Calcular suma
suma=$((num1 + num2))

# Mostrar el resultado
echo "La suma de $num1 y $num2 es: $suma"
