#!/bin/bash

# path de ejecución: /usr/share/linux-cdgrab/parches/lingr10ConversionNRG_2_ISO.sh

# lingr10ConversionNRG_2_ISO.sh ver 0.1 --> 18/10/2024

# Soporte a la conversión de imágenes .nrg en LINUX-CDGRAB 1.0
# Convierte imágenes .nrg de Nero Burning ROM en .iso (iso-9660)
# utilizando la herramienta nrg2iso.
#
# Pascual Martínez Cruz --> pascual89@hotmail.com
# Distribuir bajo la misma licencia que Linux-cdgrab 1.0 (GPL v2)

presskey(){

echo $presskey_MSG1
read xcxcxcx

}

cabeceraNRG(){

clear
echo $cabeceraNRG_MSG1
echo $cabeceraNRG_MSG2
echo $cabeceraNRG_MSG1

}

# Convierte una imagen .nrg de Nero Burning ROM
# en una imagen .iso (iso-9660)
# Se utiliza la herramienta de conversión nrg2iso

convertir_imagen_nrg(){

case $UD in
0)
    dialog --title "NRG2ISO" --backtitle "$cabeceraNRG_MSG2" --no-cancel --ok-label "OK" --inputbox "$convertir_imagen_nrg_MSG1" 8 60 2> $D_LINUXCDGRAB/imgnrg.$$
    imgnrg=`cat $D_LINUXCDGRAB/imgnrg.$$`

    dialog --title "NRG2ISO" --backtitle "$cabeceraNRG_MSG2" --no-cancel --ok-label "OK" --inputbox "$convertir_imagen_nrg_MSG1B" 8 60 2> $D_LINUXCDGRAB/imgiso.$$
    imgiso=`cat $D_LINUXCDGRAB/imgiso.$$`      

;;

1)
	cabeceraNRG
	echo ""

	printf "$convertir_imagen_nrg_MSG1:\n"
	read imgnrg
	echo ""
	printf "$convertir_imagen_nrg_MSG1B:\n"
	read imgiso
;;

2)
    imgnrg=$(zenity --width=400 --height=300 --title="$cabeceraNRG_MSG2" --entry --text="$convertir_imagen_nrg_MSG1")
    imgiso=$(zenity --width=400 --height=300 --title="$cabeceraNRG_MSG2" --entry --text="$convertir_imagen_nrg_MSG1B")
;;

3)
    imgnrg=$(kdialog --title "$cabeceraNRG_MSG2" --inputbox "$convertir_imagen_nrg_MSG1" " " --geometry=400x250)
    imgiso=$(kdialog --title "$cabeceraNRG_MSG2" --inputbox "$convertir_imagen_nrg_MSG1B" " " --geometry=400x250)
;;
esac

	echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	cabeceraNRG

	echo "$convertir_imagen_nrg_MSG2: nrg2iso $imgnrg $imgiso"
	printf "\n"

	if nrg2iso $imgnrg $imgiso;then

		case $UD in
		0)
			dialog --backtitle "$cabeceraNRG_MSG2" --msgbox "$convertir_imagen_nrg_MSG3" 9 50
		;;

		1)
			echo -e "${C_OK}$convertir_imagen_nrg_MSG3 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			presskey

		;;

		2)
			zenity --title="$cabeceraNRG_MSG2" --info --text="$convertir_imagen_nrg_MSG3" --width=500 --height=150
		;;

		3)
			kdialog --msgbox "$convertir_imagen_nrg_MSG3" --title "$cabeceraNRG_MSG2"
		;;

		esac

	else

		case $UD in
		0)
			dialog --backtitle "$cabeceraNRG_MSG2" --msgbox "$convertir_imagen_nrg_MSG4" 9 50
		;;

		1)
			echo -e "${C_FA}$convertir_imagen_nrg_MSG4 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			presskey

		;;

		2)
			zenity --title="$cabeceraNRG_MSG2" --info --text="$convertir_imagen_nrg_MSG4" --width=500 --height=150
		;;

		3)
			kdialog --error "$convertir_imagen_nrg_MSG4" --title="$cabeceraNRG_MSG2"
		;;

		esac
		

	fi

rm -rf $D_LINUXCDGRAB/imgnrg.$$ &> /dev/null
rm -rf $D_LINUXCDGRAB/imgiso.$$ &> /dev/null

}

creditospatchnrgaiso(){

utilver="$(nrg2iso --version)"

case $UD in
	0)
    dialog --clear --backtitle "$cabeceraNRG_MSG2" --msgbox "${PATCHVER} \

                                                                                                             $creditospatchnrgaiso_MSG1 \

                                                                                                             $creditospatchnrgaiso_MSG2 \

                                                                                                             $creditospatchnrgaiso_MSG3 \

                                                                                                             $creditospatchnrgaiso_MSG4 \

                                                                                                             $creditospatchnrgaiso_MSG5 \

                                                                                                             $utilver " 16 57
	;;

	1)
		cabeceraNRG
		echo "$PATCHVER"
		echo ""
		echo "$creditospatchnrgaiso_MSG1"
		echo "$creditospatchnrgaiso_MSG2"
		echo ""
		echo "$creditospatchnrgaiso_MSG3"
		echo "$creditospatchnrgaiso_MSG4"
		echo ""
		echo "$creditospatchnrgaiso_MSG5"
		echo "$utilver"
		echo ""
		presskey
	;;

	2)
	zenity --title="$cabeceraNRG_MSG2" --info --text="
${PATCHVER}
$creditospatchnrgaiso_MSG1
$creditospatchnrgaiso_MSG2
$creditospatchnrgaiso_MSG3
$creditospatchnrgaiso_MSG4
$creditospatchnrgaiso_MSG5
$utilver" --width=600 --height=200
	;;

	3)
	kdialog --msgbox "${PATCHVER}
$creditospatchnrgaiso_MSG1
$creditospatchnrgaiso_MSG2
$creditospatchnrgaiso_MSG3
$creditospatchnrgaiso_MSG4
$creditospatchnrgaiso_MSG5
$utilver" --title="$cabeceraNRG_MSG2" --geometry=500x500
	;;
esac

}

#	########################## PROGRAMA PRINCIPAL ##########################
#	Menú , Conversión de imágenes .nrg (Nero Burning ROM) en .iso (ISO-9660)

PATCHVER="lingr10ConversionNRG_2_ISO -- v_0.1"

if test -z $D_LINUXCDGRAB;then
	export D_LINUXCDGRAB="/usr/share/linux-cdgrab"
fi

if test -z $IDIOM;then
	export IDIOM=".defecidiom"
fi

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabparches_idiom/lingr10ConversionNRG_2_ISO.idiom || exit $?

if test -z $UD;then
	export UD=1
fi

while $verdadero;do

INPUT=${D_TMP}/menu.sh.$$

case $UD in
0)
			dialog --clear --no-cancel --ok-label "OK" --backtitle "-++ $cabeceraNRG_MSG2 ++-" \
			--title "$cabeceraNRG_MSG2" \
			--menu " " 10 60 21 \
			1 "$lingr10ConversionNRG_2_ISO_MSG1" \
			2 "$lingr10ConversionNRG_2_ISO_MSG2" \
			0 "$lingr10ConversionNRG_2_ISO_MSG3" 2>"${INPUT}"
			nrgconvop="$(<${INPUT})"
;;

1)


			echo -e ${COLOR_DEL_INTERFAZ}
			echo -e ${FONDO_INTERFAZ}

			cabeceraNRG
			echo ""
			echo "1.- $lingr10ConversionNRG_2_ISO_MSG1"
			echo "2.- $lingr10ConversionNRG_2_ISO_MSG2"
			echo ""
			echo "0.- $lingr10ConversionNRG_2_ISO_MSG3"
			echo ""
			read nrgconvop

;;

2)

			nrgconvop=$(zenity --width=350 --height=150 --title="$cabeceraNRG_MSG2" --entry --text="
1) $lingr10ConversionNRG_2_ISO_MSG1
2) $lingr10ConversionNRG_2_ISO_MSG2
0) $lingr10ConversionNRG_2_ISO_MSG3")

;;

3)

			nrgconvop=$(kdialog --menu "$cabeceraNRG_MSG2" \
1 "1- $lingr10ConversionNRG_2_ISO_MSG1" \
2 "2- $lingr10ConversionNRG_2_ISO_MSG2" \
0 "0- $lingr10ConversionNRG_2_ISO_MSG3" --geometry=400x200)

;;

esac

	case $nrgconvop in

		1)
			
			convertir_imagen_nrg

		;;

		2)
			
			creditospatchnrgaiso

		;;

		0)
			break
		;;

		*)
			echo -e "${C_FA}$lingr10ConversionNRG_2_ISO_MSG4${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			sleep 1
			continue
		;;
	esac

done

[ -f $INPUT ] && rm -rf $INPUT &> /dev/null

