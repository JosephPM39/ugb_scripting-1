#!/bin/bash

# Declaración de meses para fines representativos en el reporte
textMonths=("" "Enero" "Febrero" "Marzo" "Abril" "Mayo" "Junio"
        "Julio" "Agosto" "Septiembre" "Octubre" "Noviembre" "Diciembre")

# Declaración de los arreglos a utilizar
declare -A departments customers categories months tops

# Mediante esta función, extreamos los datos del csv hacia nuestros arreglos
processStatics() {
	while IFS="," read -r product category date customer department total;
	do
		# Obtenemos el mes de la fecha
		month=$(getMonth $date)
		# Validando que el total en la fila sea un número, para evitar los 
		# encabezados del csv
        	cil=$(echo $total | tr -d '\r')
        	if [[ $cil =~ ^[0-9]+$ ]]; then
			# Hacemos la suma acumulativa de departamentos, clientes,
			# meses, y categorías
               		((departments[$department]=departments[$department] + $total))
                	((customers["$customer"]=customers["$customer"] + $total))
	                ((categories[$category]=categories[$category] + $total))
	       		((months[$month]=months[$month] + $total))
			# Hacemos un conteo de cuantas veces aparece un produto
			# en las ventas
             		((tops["$product"]++))
        	fi
	done < productos.csv
}

getMonth() {
	# Extraemos el mes de la fecha, obteniendo nada más el número de mes
        # en formato sin cero a la izquierda
	date=$1
        echo $date | cut -d"-" -f2 | sed -E "s/([0])([1-9])/\2/"
}

# Dando un formato especial a los datos de categoría
preCategoryTotals() {
	for category in "${!categories[@]}"; do
		echo "$category:\$${categories[$category]}"
	done
}

# Realizamos el formato de reporte para categorías
categoryTotals() {
	echo "============================"
	echo "Total ingresos por Categoría"
	echo "============================"

	echo ""

	# Usando awk y printf, se le da formato al pre-formato de la funcion anterior
	# esta técnica será usada mucho en los siguientes criterios del proyecto final
	preCategoryTotals | awk 'BEGIN{
		FS=":"; OFS=""; printf "%-20s%10s\n", "Categoría", "Total";
		print "-------------------------------";
	} {
		printf "%-20s%10s\n", $1, $2;
	}'

}

# Dando un formato especial a los datos de meses
preMonthTotals() {
	for month in "${!months[@]}"; do
		echo "$month:${textMonths[$month]}:\$${months[$month]}"
	done
}

# Formato final para meses
monthTotals() {
	echo "======================"
	echo "Total ingresos por mes"
	echo "======================"

	echo ""

	# Como bien se indicó anteriormente, acá se da formato final al pre-formato pero para meses
	preMonthTotals | sort -n | sed -E "s/(.+):(.+):(.+)/\2:\3/" \
		| awk 'BEGIN{
		FS=":"; OFS=""; printf "%-20s%10s\n", "Mes", "Total";
		print "-------------------------------";
	} {
		printf "%-20s%10s\n", $1, $2;
	}'

}

# Dando un formato especial a los datos de clientes
preCustomerTotals() {
	for customer in "${!customers[@]}"; do
		echo "$customer: \$${customers[$customer]}"
	done
}

# Formato final para clientes
customerTotals() {
	echo "==========================="
	echo "Total ingresos por clientes"
	echo "==========================="
	
	echo ""

	preCustomerTotals | awk 'BEGIN{
		FS=":"; OFS=""; printf "%-20s%10s\n", "Cliente", "Total";
		print "-------------------------------";
	} {
		printf "%-20s%10s\n", $1, $2;
	}'
}

# Dando un formato especial a los datos de departamentos
preDepartmentTotals() {
	for department in "${!departments[@]}"; do
		echo "$department: \$${departments[$department]}"
	done
}

# Formato final para departamentos
departmentTotals() {
	echo "==============================="
	echo "Total ingresos por departamento"
	echo "==============================="

	echo ""

	preDepartmentTotals | awk 'BEGIN{
		FS=":"; OFS=""; printf "%-20s%10s\n", "Departamento", "Total";
		print "-------------------------------";
	} {
		printf "%-20s%10s\n", $1, $2;
	}'
}

# Funcion para imprimir los datos de los tops con un pre-formato, será usada en la siguiente función
printTop() {
	for top in "${!tops[@]}"; do
		echo "$top:${tops[$top]}"
	done
}

# Con esta función se hacen dos cosas, la primera es ordenar el top según la cantidad de veces que se ha vendido cada producto, y la segunda, es que hace el formato final del top para ser presentado
orderTop() {
	echo "============================="
	echo "Top 10 Productos más vendidos"
	echo "============================="

	echo ""

	# En esta instrucción, se está haciendo uso de la función anterior, y con ayuda de sed y expresiones regulares, hacemos un paso intermedio de re ordenar las columnas, para poder ordenarlas con sort de mayor a menor cantidad, finalmente se usa awk para dar el formato final como una tabla asi como las anteriores, usando la variable NR de awk, damos enumeración al top.
	printTop | sed -E "s/(.+)\:(.+)/\2:\1/" | sort -nr \
	       | awk 'BEGIN{
		FS=":"; OFS=""; printf "%-4s%-20s%5s\n", "No.","Producto","Total";
		print "------------------------------";
	       } { 
	     	printf "%-4d%-20s%5d\n", NR,$2,$1;
	}' | head -n12
}

# Esta función esta diseñada para simplificar la legibilidad del script
makeReport() {
	echo "========================================="
	echo "REPORTE GENERADO EL: $(date +"%d-%m-%Y %H:%M:%S")"
	echo "========================================="
	echo ""
	categoryTotals
	echo ""
	monthTotals
	echo ""
	customerTotals
	echo ""
	departmentTotals
	echo ""
	orderTop
}

# Ejecutamos la función que extrae los datos del csv, y luego los usamos en la función de reporte para obtener los datos finales para finalmente redirigir estos datos a un archivo de texto plano
processStatics; makeReport > reporte.txt
