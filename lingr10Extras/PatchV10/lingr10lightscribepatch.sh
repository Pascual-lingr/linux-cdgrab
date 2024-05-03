#!/bin/bash

# path de ejecución: /usr/share/linux-cdgrab/parches/lingr10lightscribepatch.sh

# lingr10lightscribepatch.sh ver 0.4 --> 21/09/2023 - Actualización a version 1.0
# 
#
# Parche para soportar etiquetado LightScribe en LINUX-CDGRAB 1.0
# Pascual Martínez Cruz --> pascual89@hotmail.com
# Distribuir bajo la misma licencia que Linux-cdgrab 1.0 (GPL v2)

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

case $UD in
0)
    dialog --title "$imprimir_disco_lightscribe_MSG1" --backtitle "$cabecera_lightscribe_MSG2" --no-cancel --ok-label "OK" --inputbox "$imprimir_disco_lightscribe_MSG2" 8 60 2> $D_LINUXCDGRAB/fotocd.$$
    foto=`cat $D_LINUXCDGRAB/fotocd.$$`   

;;

1)
	clear
	cabecera_lightscribe
	echo ""

	printf "$imprimir_disco_lightscribe_MSG1:\n"
	printf "$imprimir_disco_lightscribe_MSG2 .bmp"
	printf "\n"
	read foto
;;

2)
    foto=$(zenity --width=400 --height=300 --title="$cabecera_lightscribe_MSG2" --entry --text="$imprimir_disco_lightscribe_MSG1")
;;

3)
    foto=$(kdialog --title "$cabecera_lightscribe_MSG2" --inputbox "$imprimir_disco_lightscribe_MSG1" " " --geometry=400x250)
;;
esac
	clear
	echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	cabecera_lightscribe

	echo "$imprimir_disco_lightscribe_MSG3:4L-cli print $IDE $foto"
	printf "\n"

	if 4L-cli print $IDE $foto;then

		case $UD in
		0)
			dialog --backtitle "$cabecera_lightscribe_MSG2" --msgbox "$imprimir_disco_lightscribe_MSG4" 9 50
		;;

		1)
			echo $imprimir_disco_lightscribe_MSG4
			presskey

		;;

		2)
			zenity --title="$cabecera_lightscribe_MSG2" --info --text="$imprimir_disco_lightscribe_MSG4" --width=500 --height=150
		;;

		3)
			kdialog --msgbox "$imprimir_disco_lightscribe_MSG4" --title "$cabecera_lightscribe_MSG2"
		;;

		esac

	else

		case $UD in
		0)
			dialog --backtitle "$cabecera_lightscribe_MSG2" --msgbox "$imprimir_disco_lightscribe_MSG5" 9 50
		;;

		1)
			echo $imprimir_disco_lightscribe_MSG5
			presskey

		;;

		2)
			zenity --title="$cabecera_lightscribe_MSG2" --info --text="$imprimir_disco_lightscribe_MSG5" --width=500 --height=150
		;;

		3)
			kdialog --error "$imprimir_disco_lightscribe_MSG5" --title="$cabecera_lightscribe_MSG2"
		;;

		esac
		

	fi

rm -rf $D_LINUXCDGRAB/fotocd.$$ &> /den/null

}

#	#################### PROGRAMA PRINCIPAL ####################
#	Menú , Impresión de etiquetas en discos LightScribe CD o DVD

if test -z $D_LINUXCDGRAB;then
	export D_LINUXCDGRAB="/usr/share/linux-cdgrab"
fi

if test -z $IDIOM;then
	export IDIOM=".defecidiom"
fi

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabparches_idiom/lingr10lightscribepatch.idiom || exit $?

# Inicia mensajes de cuadro de dialogo

LightScribe_MSG01="$lingr10lightscribepatch_MSG1 $lingr10lightscribepatch_MSG2 $lingr10lightscribepatch_MSG3"

if test -z $UD;then
	export UD=1
fi

while $verdadero;do

INPUT=${D_TMP}/menu.sh.$$

case $UD in
0)
			dialog --clear --no-cancel --ok-label "OK" --backtitle "-++ $cabecera_lightscribe_MSG2 ++-" \
			--title "$cabecera_lightscribe_MSG2" \
			--menu " " 10 60 21 \
			1 "$lingr10lightscribepatch_MSG4" \
			0 "$lingr10lightscribepatch_MSG5" 2>"${INPUT}"
			lsdiscop="$(<${INPUT})"
;;
1)


	echo -e ${COLOR_DEL_INTERFAZ}
	echo -e ${FONDO_INTERFAZ}

	clear
	cabecera_lightscribe
	echo -e "${C_AV}"
	echo $lingr10lightscribepatch_MSG1
	echo $lingr10lightscribepatch_MSG2
	echo $lingr10lightscribepatch_MSG3
	echo -e "${COLOR_DEL_INTERFAZ}"
	echo ""
	echo "1.- $lingr10lightscribepatch_MSG4"
	echo ""
	echo "0.- $lingr10lightscribepatch_MSG5"
	echo ""
	read lsdiscop

;;

2)
			zenity --width=300 --height=150 --title="$cabecera_lightscribe_MSG2" --notification "$LightScribe_MSG01"

			lsdiscop=$(zenity --width=350 --height=150 --title="$cabecera_lightscribe_MSG2" --entry --text="
1) $lingr10lightscribepatch_MSG4
0) $lingr10lightscribepatch_MSG5")

;;

3)
			kdialog --msgbox "$LightScribe_MSG01" --title "$cabecera_lightscribe_MSG2" --geometry=700x300

			lsdiscop=$(kdialog --menu "$cabecera_lightscribe_MSG2" \
1 "1- $lingr10lightscribepatch_MSG4" \
0 "0- $lingr10lightscribepatch_MSG5" --geometry=400x200)

;;

esac

	case $lsdiscop in

		1)
			
			imprimir_disco_lightscribe

		;;

		0)
			break
		;;

		*)
			echo $lingr10lightscribepatch_MSG6
			sleep 1
			continue
		;;
	esac

done

[ -f $INPUT ] && rm -rf $INPUT &> /dev/null

