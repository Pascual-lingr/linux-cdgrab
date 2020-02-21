#########################################################
# lcgdrabMenu_API/lcdgrabUIIMAGENESCDDVD.sh
# Menu de Interfaz para la creacion y tratado de imagenes
# de CD y DVD.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

################################ OPCIONES DE CREACION DE  IMAGENES ################################
###################################################################################################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUIIMAGENESCDDVD.idiom

# MenuImagen
# Menu , Creacion de imagenes ISO-9660,ext2 e img

MenuImagen(){

while $verdadero;do
	
	if test -f $HOME/rutas_lcdgrab.txt;then
		rm -f $HOME/rutas_lcdgrab.txt
	fi

clear
cabecera
printf "    $MenuImagen_MSG1\n"
printf "=================================================\n\n"
echo -e "${C_ET} $MenuImagen_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "1.-$MenuImagen_MSG3"
echo "2.-$MenuImagen_MSG4"
echo "3.-$MenuImagen_MSG5"
echo "4.-$MenuImagen_MSG6 $IDE"
echo -e "${C_ET} $MenuImagen_MSG7 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "5.-$MenuImagen_MSG8"
echo "6.-$MenuImagen_MSG9"
echo "7.-$MenuImagen_MSG10"
echo "8.-$MenuImagen_MSG11"

echo ""
echo "--------->> MI: $MenuImagen_MSG12"
echo ""
echo "0.-$MenuImagen_MSG0"

read modoimagen

case $modoimagen in

	1)
	clear
	imagenISO $LECTOR_CDROM
	;;
	
	2)
	clear
	imagen_ext2
	;;

	3)
	imagen_img
	;;

	4)
	ImagenbincueCDDVD
	;;

	5)
	GenerarArchivocue
	;;

	6)
	nrg_a_iso
	;;

	7)
	MSG=$MenuImagen_MSG13
	gestor_de_archivos $MSG
	
	if test $UD -eq 0;then
		dialog --title $MenuImagen_MSG14 --backtitle "LINUX-CDGRAB 05" --inputbox $MenuImagen_MSG15 8 60 2> $D_LINUXCDGRAB/lcdgrabimgcomp.$$
		imagen=`cat $D_LINUXCDGRAB/lcdgrabimgcomp.$$`
		colores_interfaz
	else
		echo "$MenuImagen_MSG16:"
		read imagen
	fi

	comprime $imagen

	rm -f $D_LINUXCDGRAB/lcdgrabimgcomp.$$ &> /dev/null

	;;

	8)
	MSG=$MenuImagen_MSG16
	gestor_de_archivos $MSG
	descomprime
	;;

	0)
	break
	;;

	"MI")

	clear
	cabecera
	echo "$MenuImagen_MSG17 : $NIVEL_ISO"
	echo -e "${C_ET} $MenuImagen_MSG18 1${COLOR_DEL_INTERFAZ}"
	echo "-----------"
	echo $MenuImagen_MSG19
	echo $MenuImagen_MSG20
	echo $MenuImagen_MSG21
	echo $MenuImagen_MSG21b
	echo -e "${C_ET} $MenuImagen_MSG18 2${COLOR_DEL_INTERFAZ}"
	echo "-----------"
	echo $MenuImagen_MSG22
	echo -e "${C_ET} $MenuImagen_MSG18 3${COLOR_DEL_INTERFAZ}"
	echo "-----------"
	echo $MenuImagen_MSG23
	echo $MenuImagen_MSG24
	echo $MenuImagen_MSG25
	echo "-----------"



	echo $MenuImagen_MSG26
	echo $MenuImagen_MSG27
	echo $MenuImagen_MSG28
	echo $MenuImagen_MSG29
	echo -n "$MenuImagen_MSG30 : "
	read op

		case $op in

		1|2|3|4)
	
			if test $op -eq 4;then
		
				echo -e "${C_AV}"
				echo $MenuImagen_MSG31
				echo $MenuImagen_MSG32
				echo -e "${COLOR_DEL_INTERFAZ}"
				sleep 2
			fi
		
			NIVEL_ISO="$op"
		;;

		*)
			echo $MenuImagen_MSG33
			echo $MenuImagen_MSG34
			sleep 0.5
		;;
	
		esac
		
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

