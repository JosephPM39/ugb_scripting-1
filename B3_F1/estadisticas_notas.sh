#!/bin/bash

# Leer el archivo csv

while IFS=',' read -r nombre nota
do
	# Convertir la nota a número
	n=$(echo $nota | tr -d '\r')
	# Comprobar si la nota es un número
	if [[ $n =~ ^[0-9]+$ ]]; then
		nombres+=("$nombre")
		notas+=("$n")
	fi
done < notas.csv

aprobados=()
reprobados=()
excelencia=()
nota_maxima=0
for i in "${!notas[@]}"
do 
	if [[ ${notas[$i]} -gt $nota_maxima ]]; then
		nota_maxima=${notas[$i]}
		estudiante_destacado=${nombres[$i]}
	fi
	if [[ ${notas[$i]} -ge 6 ]]; then
		aprobados+=("${nombres[$i]}")
	else
		reprobados+=("${nombres[$i]}")
	fi
	if [[ ${notas[$i]} -gt 9 ]]; then
		excelencia+=("${nombres[$i]}")
	fi
done

REPORT=reporte_notas.txt
echo "Estudiante más sobresaliente" > $REPORT
echo "----------------------------" >> $REPORT 
echo "$estudiante_destacado" >> $REPORT
echo "" >> $REPORT

echo "Estudiantes con excelencia académica (Nota > 9)" >> $REPORT
echo "-----------------------------------------------" >> $REPORT 
for nombre in "${excelencia[@]}"; do
	echo "$nombre" >> $REPORT
done
echo "" >> $REPORT

echo "Estudiantes aprobados (Nota >= 6)" >> $REPORT
echo "---------------------------------" >> $REPORT 
for nombre in "${aprobados[@]}"; do
	echo "$nombre" >> $REPORT
done
echo "" >> $REPORT

echo "Estudiantes reprobados (Nota > 6)" >> $REPORT
echo "---------------------------------" >> $REPORT 
for nombre in "${reprobados[@]}"; do
	echo "$nombre" >> $REPORT
done
