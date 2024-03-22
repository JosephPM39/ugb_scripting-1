#!/bin/bash

letras() {
	# Unidades del 0 al 9
	unidades=("" "Uno" "Dos" "Tres" "Cuatro" "Cinco" "Seis" "Siete" "Ocho" "Nueve")

	# Decenas del 10 al 90
	decenas=("" "Diez" "Veinte" "Treinta" "Cuarenta" "Cincuenta" "Sesenta" "Setenta" "Ochenta" "Noventa")

	# Centenas del 100 al 900
	centenas=("Cien" "Ciento" "Doscientos" "Trescientos" "Cuatrocientos" "Quinientos" "Seiscientos" "Setecientos" "Ochocientos" "Novecientos")

	# Especiales, del 11 al 19 y del 21 al 29
	especiales=("Once" "Doce" "Trece" "Catorce" "Quince" "Dieciséis" "Diecisiete" "Dieciocho" "Diecinueve" "" "Veintiuno" "Veintidós" "Veintitrés" "Veinticuatro" "Veinticinco" "Veintiséis" "Veintisiete" "Veintiocho" "Veintinueve")

	case $1 in
		0) echo "${unidades[$2]}" ;;
		1) echo "${especiales[$2-11]}" ;;
		2) echo "${decenas[$2]}" ;;
		3) echo "${centenas[$2]}" ;;
	esac
}

obtener_unidades() {
	letras 0 "$1"
}

num_letras() {
	echo -n "Numero a convertir: "
	read -r num
	unidades=""
	especiales=""
	decenas=""
	centenas=""
	enlace=""

	if [ ${#num} -eq 1 ]; then
		unidades=$(obtener_unidades "$num")
	fi

	if [ "$num" -gt 10 ] && [ "$num" -lt 20 ] || [ "$num" -gt 20 ] && [ "$num" -le 29 ]; then
		especiales=$(letras 1 "$num")
	elif [ ${#num} -eq 2 ]; then
		decenas=$(letras 2 "${num:0:1}")
		unidades=$(obtener_unidades "${num:1:1}")
		enlace=$([ ${#unidades} -gt 1 ] && echo " y " || echo "")
	fi

	if [ ${#num} -eq 3 ]; then
		especial=${num:1:2}
		centenas=$(letras 3 "${num:0:1}")

		if [ "$especial" -gt 10 ] && [ "$especial" -lt 20 ] || [ "$especial" -gt 20 ] && [ "$especial" -le 29 ]; then
			decenas=$(letras 1 "$especial")
        else
			decenas=$(letras 2 "${num:1:1}")
			unidades=$(obtener_unidades "${num:2:1}")
			enlace=$([ ${#unidades} -gt 1 ] && echo " y " || echo "")
		fi
	fi
	echo "$centenas $decenas$enlace$especiales$unidades"
}

num_letras
