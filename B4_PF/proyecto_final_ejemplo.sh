#!/bin/bash

declare -A deptos marcas
while IFS=";" read -r marca modelo modelo2 year chasis vin motor cilindrada tm combustion depto municipio;
do
	cil=$(echo $cilindrada | tr -d '\r')
	if [[ $cil =~ ^[0-9]+$ ]]; then
		((deptos[$depto]++))
		((marcas[$marca]++))
	fi
done < parque.csv

REPORT=reporte_ejemplo.txt
echo "--------------------------" > $REPORT
echo "Vehículos por departamento" >> $REPORT
echo "--------------------------" >> $REPORT
for depto in "${!deptos[@]}"; do
	echo "$depto: ${deptos[$depto]}" >> $REPORT
done
echo "" >> $REPORT

echo "-------------------" >> $REPORT
echo "Vehículos por marca" >> $REPORT
echo "-------------------" >> $REPORT
for marca in "${!marcas[@]}"; do
	echo "$marca: ${marcas[$marca]}" >> $REPORT
done
echo "" >> $REPORT
