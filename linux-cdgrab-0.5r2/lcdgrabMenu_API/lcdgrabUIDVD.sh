#########################################################
# lcgdrabMenu_API/lcdgrabUIDVD.sh
# Menu de Interfaz para la grabacion de DVD.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

#########################  GRABACIONES EN DVD ############################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUIDVD.idiom

# Selecciona el interaz de de usuario que sera usado en grabaciones DVD
# SeleccionaIUDVD

SeleccionaIUDVD(){

while $ver;do

	cabecera
	echo ""
	echo $SeleccionaIUDVD_MSG1
	echo ""
	echo "1.- $SeleccionaIUDVD_MSG2"
	echo "2.- $SeleccionaIUDVD_MSG3"
	echo ""
	echo "0.- $SeleccionaIUDVD_MSG4"

	read IUMOP

	case $IUMOP in
		1)
			clear
			menugrabar_dvd
		;;

		2)
			menugrabar_DVD
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

}

############# Grabaciones usando el IU para dvd+-rw-tools ################

# menugrabar_dvd

menugrabar_dvd(){

MEDIO="DVD"

buscar_grabadora
	
while $verdadero;do

if test -f $HOME/rutas_lcdgrab.txt;then
	rm -f $HOME/rutas_lcdgrab.txt
fi

clear

cabecera

printf "\t\t$menugrabar_dvd_MSG1\n"
printf "=================================================\n\n"
echo -e "${C_ET} $menugrabar_dvd_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "1.- $menugrabar_dvd_MSG3"
echo -e "    ${C_AV} $menugrabar_dvd_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "2.- $menugrabar_dvd_MSG5"
echo "3.- $menugrabar_dvd_MSG6"
echo -e "    ${C_AV} $menugrabar_dvd_MSG7 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "4.- $menugrabar_dvd_MSG8"
echo "5.- $menugrabar_dvd_MSG9"
echo -e "${C_ET} $menugrabar_dvd_MSG10 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "6.- $menugrabar_dvd_MSG11"
echo -e "${C_ET} $menugrabar_dvd_MSG12 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "7.- $menugrabar_dvd_MSG13"
echo "8.- $menugrabar_dvd_MSG14"
echo ""
echo "0.- $menugrabar_dvd_MSG0"
echo ""
echo ""
echo -n "$menugrabar_dvd_MSGPRINCIPAL : "
read gdvdop
	
	case $gdvdop in

		1)
			clear
			cabecera
			copia_bin_dvd
		;;

		2)
			MSG=$menugrabar_dvd_MSG15
			echo $menugrabar_dvd_MSG16
			sleep 1
			gestor_de_archivos $MSG

			if test $UD -eq 0;then
				rutas_dir
			else
				text_rutas_dir
			fi

			clear
			datos_dvd
		;;

		3)
			MSG=$menugrabar_dvd_MSG15			
			echo $menugrabar_dvd_MSG16
			sleep 1
			gestor_de_archivos

			if test $UD -eq 0;then
				rutas_dir
			else
				text_rutas_dir
			fi

			clear
			datos_dvd_multi
		;;


		4)
			MSG=$menugrabar_dvd_MSG17
			echo $menugrabar_dvd_MSG16
			sleep 1
			gestor_de_archivos
			echo ""
			echo $menugrabar_dvd_MSG18
			read imagen
			grabimg-dvd $imagen
		;;

		5)
			#requiere cdrecord con soporte para DVD.
			clear
			cabecera
			echo -e "${C_AV}"
			echo $menugrabar_dvd_MSG19
			echo $menugrabar_dvd_MSG20
			echo $menugrabar_dvd_MSG21
			echo $menugrabar_dvd_MSG22
			echo -e "${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
			grabimg $MEDIO
		;;
		
		6)
			clear
			cabecera
			dvd_video
		;;

		7)

			clear
			formatear_dvd
		;;

		8)
			clear
			cabecera
			dvd+rw-mediainfo $grabadora_dvd
			echo ""
			teclash
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

############# Grabaciones usando el IU para Cdrecord-ProDVD ################

# dvd_clonar
# submenu, copias directas de DVDs de datos

dvd_clonar(){

while $verdadero;do
clear
cabecera
printf "\t\t$dvd_clonar_MSG1\n"
printf "=================================================\n\n"
echo -e "${C_ET} $dvd_clonar_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "1.- $dvd_clonar_MSG3"
echo -e "${C_AV}    $dvd_clonar_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo -e "${C_ET} $dvd_clonar_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "2.- $dvd_clonar_MSG6 **"
echo "3.- $dvd_clonar_MSG7 **"
echo -e "${C_AV}"
echo "**"
echo $dvd_clonar_MSG8
echo $dvd_clonar_MSG9
echo $dvd_clonar_MSG10
echo $dvd_clonar_MSG11
echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
echo "0.- $dvd_clonar_MSG0"

read modoclonar

case $modoclonar in

1)
clear
dvd_copia_bin $LECTOR_CDROM
colores_interfaz
;;

2)
clear
dvd_datos_al_vuelo $LECTOR_CDROM
;;

3)
clear
dvd_clonar_cd $LECTOR_CDROM
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

# menugrabar_DVD

menugrabar_DVD(){

while $verdadero;do

	if test -f $HOME/rutas_lcdgrab.txt;then
		rm -f $HOME/rutas_lcdgrab.txt
	fi

	clear
	cabecera
	printf "\t\t$menugrabar_DVD_MSG1\n"
	printf "=================================================\n"
	printf "\n"
	echo -e "${C_ET}$menugrabar_DVD_MSG2${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	echo "1.- $menugrabar_DVD_MSG3"
	echo "2.- $menugrabar_DVD_MSG4"
	echo "3.- $menugrabar_DVD_MSG5"
	echo "4.- $menugrabar_DVD_MSG6"
	echo "5.- $menugrabar_DVD_MSG7"
	echo ""
	echo "0.- $menugrabar_DVD_MSG0"
	echo ""
	echo -n "$menugrabar_DVD_MSGPRINCIPAL : "
	read opcion
	
	case $opcion in

		1)
		clear
		dvd_clonar $LECTOR_CDROM
		;;

		2)
		clear
		cabecera
		datos
		;;

		3)
		clear
		cabecera
		dvd_grabimg
		;;

		4)
		clear
		dvd_borra
		;;

		5)
		dvd_discoinfo
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


