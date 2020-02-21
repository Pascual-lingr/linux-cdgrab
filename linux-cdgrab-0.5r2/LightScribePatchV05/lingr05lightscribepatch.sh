#!/bin/bash

# path de ejecucion: /usr/share/linux-cdgrab/parches/lingr05lightscribepatch.sh

# lingr05lightscribepatch.sh ver 0.3 --> 19 - Mayo - 2018
#
# Parche para soportar etiquetado LightScribe en LINUX-CDGRAB 0.5
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo la misma licencia que Linux-cdgrab 0.5 (GPL v2)

presskey(){

echo $presskey_MSG1
read xcxcxcx

}

cabecera_lightscribe(){

echo $cabecera_lightscribe_MSG1
echo $cabecera_lightscribe_MSG2
echo $cabecera_lightscribe_MSG3

}

# Imprime un CD o DVD LightScribe
# Necesario 4L-cli --> Herramientas de LAcie para Linux.

imprimir_disco_lightscribe(){

	clear
	cabecera_lightscribe
	echo ""

	printf "$imprimir_disco_lightscribe_MSG1:\n"
	printf "$imprimir_disco_lightscribe_MSG2 .bmp"
	printf "\n"
	read foto
	echo "$imprimir_disco_lightscribe_MSG3:4L-cli print $IDE $foto"
	printf "\n"
		if test $UD -eq 0;then
			CD_error
		else
			text_CD_error
			presskey
		fi
	if 4L-cli print $IDE $foto;then

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$imprimir_disco_lightscribe_MSG4" 9 50
		else
			echo $imprimir_disco_lightscribe_MSG4
			presskey
		fi

		

	else

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$imprimir_disco_lightscribe_MSG5" 9 50
		else
			echo $imprimir_disco_lightscribe_MSG5
			presskey
		fi

		

	fi

}

#	#################### PROGRAMA PRINCIPAL ####################
#	Menu , Impresion de etiquetas en discos LightScribe CD o DVD

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabparches_idiom/lingr05lightscribepatch.idiom

while $verdadero;do

	echo -e ${COLOR_DEL_INTERFAZ}
	echo -e ${FONDO_INTERFAZ}

	clear
	cabecera_lightscribe
	echo -e "${C_AV}"
	echo $lingr05lightscribepatch_MSG1
	echo $lingr05lightscribepatch_MSG2
	echo $lingr05lightscribepatch_MSG3
	echo -e "${COLOR_DEL_INTERFAZ}"
	echo ""
	echo "1.- $lingr05lightscribepatch_MSG4"
	echo ""
	echo "0.- $lingr05lightscribepatch_MSG5"
	echo ""
	read lsdiscop

	case $lsdiscop in

		1)
			
			imprimir_disco_lightscribe

		;;

		0)
			break
		;;

		*)
			echo $lingr05lightscribepatch_MSG6
			sleep 1
			continue
		;;
	esac

done
