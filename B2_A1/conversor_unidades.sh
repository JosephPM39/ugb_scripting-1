#!/bin/bash

# Función para convertir unidades de longitud
convertir_longitud() {
    case $unidad_origen in
        1)
            case $unidad_destino in
		        2) resultado="metro(s) equivale a: $(echo "scale=2; $cantidad * 3.281" | bc) pie(s)";;
		        3) resultado="metro(s) equivale a: $(echo "scale=2; $cantidad * 39.37" | bc) pulgada(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        2)
            case $unidad_destino in
		        1) resultado="pie(s) equivale a: $(echo "scale=2; $cantidad / 3.281" | bc) metro(s)";;
		        3) resultado="pie(s) equivale a: $(echo "scale=2; $cantidad * 12" | bc) pulgada(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        3)
            case $unidad_destino in
                1) resultado="pulgada(s) $(echo "scale=2; $cantidad / 39.37" | bc) metro(s)";;
                2) resultado="pulgada(s) $(echo "scale=2; $cantidad / 12" | bc) pie(s) ";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        *) resultado=": no fue posible operar $cantidad";;
    esac

    echo "$cantidad $resultado"
}


# Función para convertir unidades de masa
convertir_masa() {
    case $unidad_origen in
        1)
            case $unidad_destino in
                2) resultado="kilogramo(s) equivale a: $(echo "scale=2; $cantidad * 2.205" | bc) libra(s)";;
                3) resultado="kilogramo(s) equivale a: $(echo "scale=2; $cantidad * 35.274" | bc) onza(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        2)
            case $unidad_destino in
                1) resultado="libra(s) equivale a: $(echo "scale=2; $cantidad / 2.205" | bc) kilogramo(s)";;
                3) resultado="libra(s) equivale a: $(echo "scale=2; $cantidad * 16" | bc) onza(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        3)
            case $unidad_destino in
                1) resultado="onza(s) equivale a: $(echo "scale=2; $cantidad / 35.274" | bc) kilogramo(s)";;
                2) resultado="onza(s) equivale a: $(echo "scale=2; $cantidad / 16" | bc) libra(s) ";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        *) resultado=": no fue posible operar $cantidad";;
    esac

    echo "$cantidad $resultado"
}

# Función para convertir unidades de tiempo
convertir_tiempo() {
    case $unidad_origen in
        1)
            case $unidad_destino in
                2) resultado="segundo(s) equivale a: $(echo "scale=2; $cantidad / 60" | bc) minuto(s)";;
                3) resultado="segundo(s) equivale a: $(echo "scale=2; $cantidad / 3600" | bc) hora(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        2)
            case $unidad_destino in
                1) resultado="minuto(s) equivale a: $(echo "scale=2; $cantidad * 60" | bc) segundo(s)";;
                3) resultado="minuto(s) equivale a: $(echo "scale=2; $cantidad / 60" | bc) hora(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        3)
            case $unidad_destino in
                1) resultado="hora(s) equivale a: $(echo "scale=2; $cantidad * 3600" | bc) segundo(s)";;
                2) resultado="hora(s) equivale a: $(echo "scale=2; $cantidad * 60" | bc) minuto(s) ";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        *) resultado=": no fue posible operar $cantidad";;
    esac

    echo "$cantidad $resultado"
}

# Función para convertir unidades de almacenamiento
convertir_almacenamiento() {
    case $unidad_origen in
        1)
            case $unidad_destino in
                2) resultado="byte(s) equivale a: $(echo "scale=2; $cantidad / 1024" | bc) kilobyte(s)";;
                3) resultado="byte(s) equivale a: $(echo "scale=2; $cantidad / 1048576" | bc) megabyte(s)";;
                4) resultado="byte(s) equivale a: $(echo "scale=2; $cantidad / 1073741824" | bc) gigabyte(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        2)
            case $unidad_destino in
                1) resultado="kilobyte(s) equivale a: $(echo "scale=2; $cantidad * 1024" | bc) byte(s)";;
                3) resultado="kilobyte(s) equivale a: $(echo "scale=2; $cantidad / 1024" | bc) megabyte(s)";;
                4) resultado="kilobyte(s) equivale a: $(echo "scale=2; $cantidad / 1048576" | bc) gigabyte(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        3)
            case $unidad_destino in
                1) resultado="megabyte(s) equivale a: $(echo "scale=2; $cantidad * 1048576" | bc) byte(s)";;
                2) resultado="megabyte(s) equivale a: $(echo "scale=2; $cantidad * 1024" | bc) kilobyte(s) ";;
                4) resultado="megabyte(s) equivale a: $(echo "scale=2; $cantidad / 1024" | bc) gigabyte(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        4)
            case $unidad_destino in
                1) resultado="gigabyte(s) equivale a: $(echo "scale=2; $cantidad * 1073741824" | bc) byte(s)";;
                2) resultado="gigabyte(s) equivale a: $(echo "scale=2; $cantidad * 1048576" | bc) kilobyte(s) ";;
                3) resultado="gigabyte(s) equivale a: $(echo "scale=2; $cantidad * 1024" | bc) megabyte(s)";;
                *) resultado=": no fue posible operar $cantidad";;
            esac;;
        *) resultado=": no fue posible operar $cantidad";;
    esac

    echo "$cantidad $resultado"
}

# Menú principal
echo "Selecciona el tipo de conversión:"
echo "1. Longitud"
echo "2. Masa"
echo "3. Tiempo"
echo "4. Almacenamiento"
read -p "Ingrese el numero de la opción: " opcion

case $opcion in
    1) # Conversión de longitud
        echo "Selecciona la unidad de origen:"
        echo "1. Metros"
        echo "2. Pies"
        echo "3. Pulgadas"
        read -p "Ingrese el numero de la opción: " unidad_origen

        echo "Selecciona la unidad de destino:"
        echo "1. Metros"
        echo "2. Pies"
        echo "3. Pulgadas"
        read -p "Ingrese el numero de la opción: " unidad_destino

        read -p "Ingrese la cantidad a convertir: " cantidad
        convertir_longitud;;
    2) # Conversión de masa
        echo "Seleccione la unidad de masa de origen:"
        echo "1. Kilogramos"
        echo "2. Libras"
        echo "3. Onzas"
        read -p "Ingrese el numero de la opción: " unidad_origen

        echo "Seleccione la unidad de masa de destino:"
        echo "1. Kilogramos"
        echo "2. Libras"
        echo "3. Onzas"
        read -p "Ingrese el numero de la opción: " unidad_destino

        read -p "Ingrese la cantidad a convertir: " cantidad

        convertir_masa;;
    3) # Conversión de tiempo
        echo "Seleccione la unidad de tiempo de origen:"
        echo "1. Segundos"
        echo "2. Minutos"
        echo "3. Horas"
        read -p "Ingrese el numero de la opción: " unidad_origen

        echo "Seleccione la unidad de tiempo de destino:"
        echo "1. Segundos"
        echo "2. Minutos"
        echo "3. Horas"
        read -p "Ingrese el numero de la opción: " unidad_destino

        read -p "Ingrese la cantidad a convertir: " cantidad

        convertir_tiempo;;
    4) # Conversión de almacenamiento
        echo "Seleccione la unidad de almacenamiento de origen:"
        echo "1. Bytes"
        echo "2. Kilobytes"
        echo "3. Megabytes"
        echo "4. Gigabytes"
        read -p "Ingrese el numero de la opción: " unidad_origen

        echo "Seleccione la unidad de almacenamiento de destino:"
        echo "1. Bytes"
        echo "2. Kilobytes"
        echo "3. Megabytes"
        echo "4. Gigabytes"
        read -p "Ingrese el numero de la opción: " unidad_destino

        read -p "Ingrese la cantidad a convertir: " cantidad

        convertir_almacenamiento;;
    *) echo "Opción no válida";;
esac

