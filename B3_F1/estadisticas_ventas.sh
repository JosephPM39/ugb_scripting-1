#!/bin/bash

# Declaración de meses para fines representativos en el reporte
months=("" "Enero" "Febrero" "Marzo" "Abril" "Mayo" "Junio"
       	"Julio" "Agosto" "Septiembre" "Octubre" "Noviembre" "Diciembre")

# Declaramos un arreglo para registrar los totales por cada mes
month_totals=()
# Declaramos mapas (key-value) para registrar cuantas veces se ha vendido un produco,
# y cuantas veces ha comprado un cliente
declare -A customers_frecuency
declare -A products_frecuency

# Iteramos en el archivo ventas.csv
while IFS="," read -r date seller customer product total
do 
	# Hacemos una condicional para solo operar con filas con un total numérico
	t=$(echo $total | tr -d '\r')
	if [[ $t =~ ^[0-9]+$ ]]; then
		# Extraemos el mes de la fecha, obteniendo nada más el número de mes
		# en formato sin cero a la izquierda
		month=$(echo $date | cut -d"-" -f2 | sed -E "s/([0])([1-9])/\2/")

		# En cada iteración vamos registrando en el arreglo, la posicion del
		# mes, y su suma acumulativa del total
		month_totals[$month]=$((month_totals[$month] + $total))

		# De igual forma, en cada iteracion sumamos acumulativamente
		# la frecuencia con la que aparecen en el csv, del producto y el cliente
		customers_frecuency["$customer"]=$((customers_frecuency["$customer"] + 1))
		products_frecuency["$product"]=$((products_frecuency["$product"] + 1))
	fi
done < ventas.csv

# Se crearon funciones para simplificar la legibilidad del script en el reporte

# Con esta función se extrae el total por cada mes, iterando el arreglo con los totales
get_months_report() {
	echo "Total por meses"
	anual_total=0
	for index in "${!month_totals[@]}"; do
		echo "${months[index]}: \$${month_totals[index]}"
		anual_total=$((anual_total + month_totals[index]))
	done
	echo "Total en el año: \$$anual_total"
}

# Iteramos el mapa de las frecuencias de productos
# y almacenamos en una variable el que tenga el mayor número de frecuencias
# para luego mostrar el producto más vendido
get_best_product() {
	most=0
	most_index=""
	for index in "${!products_frecuency[@]}"; do
		if [[ ${products_frecuency[$index]} -gt most ]]; then
			most=${products_frecuency[$index]}
			most_index=$index
		fi
	done
	echo "Producto más vendido: $most_index, total: $most veces"
}

# Iteramos el mapa de las frecuencias de clientes
# y almacenamos en una variable el que tenga el mayor número de frecuencias
# para luego mostrar el cliente más frecuente
get_best_customer() {
	most=0
	most_index=""
	for index in "${!customers_frecuency[@]}"; do
		if [[ ${customers_frecuency[$index]} -gt most ]]; then
			most=${customers_frecuency[$index]}
			most_index=$index
		fi
	done
	echo "Cliente más frecuente: $most_index, total: $most veces"
}

REPORT=reporte_ventas.txt

get_months_report > $REPORT
echo "" >> $REPORT
get_best_product >> $REPORT
get_best_customer >> $REPORT

