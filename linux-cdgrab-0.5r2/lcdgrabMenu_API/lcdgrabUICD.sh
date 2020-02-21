#########################################################
# lcgdrabMenu_API/lcdgrabUICD.sh
# Menu de Interfaz para la grabacion de CD.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

#######################  GRABACIONES EN CD ######################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUICD.idiom

# clonar
# submenu, copias directas de CDs de datos

clonar(){

while $verdadero;do
clear
cabecera
printf "\t\t$clonar_MSG1\n"
printf "=================================================\n\n"
echo -e "${C_ET} $clonar_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "1.- $clonar_MSG3"
echo -e "${C_AV}    $clonar_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo -e "${C_ET} $clonar_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "2.- $clonar_MSG6 **"
echo "3.- $clonar_MSG7 **"
echo -e "${C_AV}"
echo "**"
echo $clonar_MSG8
echo $clonar_MSG9
echo $clonar_MSG10
echo $clonar_MSG11
echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
echo "0.- $clonar_MSG0"

read modoclonar

case $modoclonar in

1)
clear
copia_bin $LECTOR_CDROM
colores_interfaz
;;

2)
clear
datos_al_vuelo $LECTOR_CDROM
;;

3)
clear
clonar_cd $LECTOR_CDROM
colores_interfaz
;;

0)
break
;;

*)
if test $UD -eq 0;then
	Opcion_invalida
	colores_interfaz
else
	text_Opcion_invalida
	sleep 1
fi
;;

esac

done
colores_interfaz
}

# menugrabar_cd

menugrabar_cd(){

while $verdadero;do

	if test -f $HOME/rutas_lcdgrab.txt;then
		rm -f $HOME/rutas_lcdgrab.txt
	fi

	clear
	cabecera
	printf "\t\t$menugrabar_cd_MSG1\n"
	printf "=================================================\n"
	echo -e "${C_ET}$menugrabar_cd_MSG2${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	echo "1.- $menugrabar_cd_MSG3"
	echo "2.- $menugrabar_cd_MSG4"
	echo "3.- $menugrabar_cd_MSG5"
	echo "4.- $menugrabar_cd_MSG6"
	echo "5.- $menugrabar_cd_MSG7"
	echo -e "${C_ET}$menugrabar_cd_MSG8${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	echo "6.- $menugrabar_cd_MSG9"
	echo "7.- $menugrabar_cd_MSG10"
	echo "8.- $menugrabar_cd_MSG11"
	echo "9.- $menugrabar_cd_MSG12"
	echo -e "${C_ET}$menugrabar_cd_MSG13${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	echo "10.- $menugrabar_cd_MSG14"
	echo "11.- $menugrabar_cd_MSG15"
	echo "12.- $menugrabar_cd_MSG16"
	echo "13.- $menugrabar_cd_MSG17"
	echo "0.-  $menugrabar_cd_MSG0"
	echo ""
	echo -n "$menugrabar_cd_MSGPRINCIPAL : "
	read opcion
	
	case $opcion in

		1)
		clear
		clonar $LECTOR_CDROM
		;;

		2)
		clear
		cabecera
		datos
		;;

		3)
		cd_multi
		;;

		4)
		clear
		cabecera
		grabimg
		;;
		
		5)
		clear
		cabecera
		grabimg_cue
		;;

		6)
		clear
		cabecera
		copia_cd_audio
		;;

		7)
		clear
		cabecera
		wav_a_cd
		;;

		8)
		clear
		mp3_a_cd
		;;

		9)
		clear
		ogg_a_cd
		;;

		10)
		clear
		cdmixto
		;;

		11)
		clear
		borra
		;;

		12)
		clear
		cabecera
		cerrar_cd
		;;

		13)
		discoinfo
		;;

		0)
		break
		;;

		*)
		if test $UD -eq 0;then
			Opcion_invalida
			colores_interfaz
		else
			text_Opcion_invalida
			sleep 1
		fi
		;;

	esac

done
colores_interfaz
}

