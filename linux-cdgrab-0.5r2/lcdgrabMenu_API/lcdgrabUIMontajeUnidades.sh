#########################################################
# lcgdrabMenu_API/lcdgrabUIMontajeUnidades.sh
# Menu de Interfaz para montar imagenes iso y ext2.
# Menu para montar CD/DVD.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUIMontajeUnidades.idiom

# montar_dispositivos
# Acepta como argumento $LECTOR_CDROM
# MONTA O DESMONTA DISPOSITIVOS DE CARACTER

montar_dispositivos(){

while $verdadero;do

clear
cabecera

echo -e "${C_ET} $montar_dispositivos_MSG1 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo -e "${C_ET}------------------------------------------------- ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
mount
echo -e "${C_ET}----------$montar_dispositivos_MSG2------------- ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo ""
echo "1.- $montar_dispositivos_MSG3"
echo "2.- $montar_dispositivos_MSG4"
echo "3.- $montar_dispositivos_MSG5"
echo "4.- $montar_dispositivos_MSG6"
echo "5.- $montar_dispositivos_MSG7"
echo ""
echo "0.- $montar_dispositivos_MSG0"

read mopc

case $mopc in

	1)

		#expulsa el CD/DVD

		expulsar_medio $LECTOR_CDROM
		
		continue
	;;

	2)

		#expulsa el cd/dvd de la grabadora

		expulsar_medio $IDE
		
		continue
	;;

	3)	# montar CD-ROM

		if mount $LECTOR_CDROM $MNT/cdrom || mount -t iso9660 $LECTOR_CDROM $MNT/cdrom;then

			# se ha montado bien el CD

			echo "$montar_dispositivos_MSG8 $MNT/cdrom"
			sleep 1
			ls -l $MNT/cdrom
			echo "$montar_dispositivos_MSG9"
			read xxxPxxx

		else
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$montar_dispositivos_MSG10 $MNT/cdrom" 9 50
			else
				echo -e "${C_FA} $montar_dispositivos_MSG10 $MNT/cdrom ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
				teclash
			fi

		fi

	;;

	4)	#desmontar CD-ROM

		if umount $MNT/cdrom;then
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$montar_dispositivos_MSG11" 9 50
			else
				echo -e "${C_OK} $montar_dispositivos_MSG11 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
				teclash
			fi


		else
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$montar_dispositivos_MSG12" 9 50
			else
				echo -e "${C_FA} $montar_dispositivos_MSG12 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
				teclash
			fi


		fi
	;;

	5)

		echo $montar_dispositivos_MSG13
		read dispositivo
		echo ""
		echo $montar_dispositivos_MSG14
		read punto_mnt

		if ! test -b $dispositivo;then
			echo -e "${C_FA}"
			echo "ERROR : $dispositivo $montar_dispositivos_MSG15"
			echo -e "${COLOR_DEL_INTERFAZ}"
		fi

		if ! test -d $punto_mnt || test "$punto_mnt" = "";then
			echo -e "${C_FA}ERROR : $montar_dispositivos_MSG16 $punto_mnt ${COLOR_DEL_INTERFAZ}"
			echo "$montar_dispositivos_MSG17 $D_MNT"
			punto_mnt=$D_MNT
		fi

		echo ""

		echo $montar_dispositivos_MSG18
		echo "-------------"
		echo "M o m -- > $montar_dispositivos_MSG19 $dispositivo $montar_dispositivos_MSG20 $punto_mnt"
		echo "D o d -- > $montar_dispositivos_MSG21 $dispoditivo $montar_dispositivos_MSG22 $punto_mnt"
		read op

		case $op in

			"M" | "m" )

			if mount $dispositivo $punto_mnt;then
				echo ""
				echo -e "${C_OK} $dispositivo $montar_dispositivos_MSG23 $punto_mnt${COLOR_DEL_INTERFAZ}"
				ls -l $punto_mnt
			else
				echo ""
				echo -e "${C_FA} $montar_dispositivos_MSG24 $dispositivo $montar_dispositivos_MSG25 $punto_mnt${COLOR_DEL_INTERFAZ}"
			fi

			teclash

			;;

			"D" | "d" )

			if umount $dispositivo || umount $punto_mnt;then
				echo ""
				echo -e "${C_OK} $dispositivo $montar_dispositivos_MSG26 $punto_mnt${COLOR_DEL_INTERFAZ}"
				echo ""
			else
				echo ""
				echo -e "${C_FA}$montar_dispositivos_MSG27 $dispositivo $montar_dispositivos_MSG28 $punto_mnt${COLOR_DEL_INTERFAZ}"
				echo ""

			fi

			teclash
				;;

			esac

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

# Montar_Imagenes
# Monta o desmonta imagenes .iso o .ext2

Montar_Imagenes(){

		clear

		cabecera
		echo -e "${C_ET} $Montar_Imagenes_MSG1 : ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		echo -e "${C_ET} -------------------------- ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		mount
		echo ""
		echo -e "${C_ET} $Montar_Imagenes_MSG2${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		echo -e "${C_ET}-----------------${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		echo "1.- $Montar_Imagenes_MSG3"
		echo "2.- $Montar_Imagenes_MSG4"

		read op_mon

		case $op_mon in

			1)

			monta_img
			;;

			2)

			desmonta_img
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

}

