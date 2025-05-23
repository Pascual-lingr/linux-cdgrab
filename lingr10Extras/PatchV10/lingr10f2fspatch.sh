#!/bin/bash

# path de ejecución: /usr/share/linux-cdgrab/parches/lingr10f2fspatch.sh

# lingr10f2fspatch.sh ver 0.1 --> 18/05/2025
# 
#
# Parche para soportar el sistema de ficheros F2FS en LINUX-CDGRAB 1.0
# Sistema de ficheros creado por Samsung para memorias flash NAND.
# Como discos SSD, eMMC o tarjetas SD

# Pascual Martínez Cruz --> pascual89@hotmail.com
# Distribuir bajo la misma licencia que Linux-cdgrab 1.0 (GPL v2)

# presskey
# 
# Pide la pulsación de la tecla INTRO al usuario

presskey(){

echo $presskey_MSG1
read xcxcxcx

}

# coloresIUAPP
# 
# Imprime los colores del interfaz

coloresIUAPP(){

echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"

}

# cabecera_interfaz
#
# Imprime la cabecera del menú en el interfaz de texto

cabecera_interfaz(){

clear

echo -e "${COLOR_DEL_INTERFAZ}$cabecera_interfaz_MSG1${FONDO_INTERFAZ}"
echo -e "${COLOR_DEL_INTERFAZ}$cabecera_interfaz_MSG2${FONDO_INTERFAZ}"
echo -e "${COLOR_DEL_INTERFAZ}$cabecera_interfaz_MSG1${FONDO_INTERFAZ}"

}

creditos(){

creditos_MSG1="SAMSUNG FLASH-FRIENDLY FILE SYSTEM"
creditos_MSG2="$creditos_DESC"
creditos_MSG3="Pascual Martínez Cruz -- pascual89@hotmail.com"
creditos_MSG4="Ver: 0.1 -- Lic: GPL v2 "

case $UD in
	0)
    		dialog --clear --backtitle "$cabecera_interfaz_MSG2" --msgbox " ${creditos_MSG1}
    		 $creditos_MSG2
    		 $creditos_MSG3
    		 $creditos_MSG4" 14 70
	;;

	1)
		cabecera_interfaz
		echo -e "${C_ET}$creditos_MSG1${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo ""
		echo "$creditos_MSG2"
		echo ""
		echo "$creditos_MSG3"
		echo "$creditos_MSG4"
		echo ""
		presskey
	;;

	2)
	zenity --title="$cabecera_interfaz_MSG2" --info --text="
$creditos_MSG1
$creditos_MSG2
$creditos_MSG3
$creditos_MSG4" --width=600 --height=200
	;;

	3)
	kdialog --msgbox "$creditos_MSG1
$creditos_MSG2
$creditos_MSG3
$creditos_MSG4" --title="$cabecera_interfaz_MSG2" --geometry=600x500
	;;
esac

clear

}

# dialog_aviso_formatounidades
# Portado de linux-cdgrab 1.0
#
# Cuadro de dialogo de aviso para el menú
# de formateo en el IU con ncurses

dialog_aviso_formatounidades(){

	UNIDAVF="$UIFormatearUnidad_linuxfs_MSG1
		$UIFormatearUnidad_linuxfs_MSG2
		$UIFormatearUnidad_linuxfs_MSG2B
		$UIFormatearUnidad_linuxfs_MSG3
		$UIFormatearUnidad_linuxfs_MSG4
		$UIFormatearUnidad_linuxfs_MSG5
		$UIFormatearUnidad_linuxfs_MSG6
		$UIFormatearUnidad_linuxfs_MSG7"

clear

dialog --clear --backtitle "-++ $PROGRAMA ++-" --title "$PROGRAMA FLASHDRIVE MENU" --yesno "$UNIDAVF" 15 83 

if test $? -eq 0;then
	export opcionformatdisco="C"
else
	export opcionformatdisco="A"
fi

}

# UIFormatearUnidad_linuxfs
# Portado de linux-cdgrab 1.0
#
# Interfaz para el formatear discos duros.

UIFormatearUnidad_linuxfs(){

clear

while $verdadero;do

  case $UD in
	0)
		dialog_aviso_formatounidades
		
	;;

	1)
	cabecera_interfaz
	echo -e "${C_AV} "
	echo $UIFormatearUnidad_linuxfs_MSG1
	echo $UIFormatearUnidad_linuxfs_MSG2
	echo $UIFormatearUnidad_linuxfs_MSG3
	echo $UIFormatearUnidad_linuxfs_MSG4
	echo $UIFormatearUnidad_linuxfs_MSG5
	echo $UIFormatearUnidad_linuxfs_MSG6
	echo $UIFormatearUnidad_linuxfs_MSG7
	echo -e "${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	echo $UIFormatearUnidad_linuxfs_MSG8
	
	read opcionformatdisco
	;;

	2)
	opcionformatdisco=$(zenity --width=400 --height=250 --title="$PROGRAMA" --entry --text="
$UIFormatearUnidad_linuxfs_MSG1
$UIFormatearUnidad_linuxfs_MSG2
$UIFormatearUnidad_linuxfs_MSG3
$UIFormatearUnidad_linuxfs_MSG4
$UIFormatearUnidad_linuxfs_MSG5
$UIFormatearUnidad_linuxfs_MSG6
$UIFormatearUnidad_linuxfs_MSG8")
	;;

	3)
		KDIAMSGFORM="$UIFormatearUnidad_linuxfs_MSG1
$UIFormatearUnidad_linuxfs_MSG2
$UIFormatearUnidad_linuxfs_MSG3
$UIFormatearUnidad_linuxfs_MSG4
$UIFormatearUnidad_linuxfs_MSG5
$UIFormatearUnidad_linuxfs_MSG6
$UIFormatearUnidad_linuxfs_MSG7"

		kdialog --warningyesno "$KDIAMSGFORM" --geometry=400x400 --title "$PROGRAMA"

		if test $? -eq 0;then
			opcionformatdisco="C"
		else
			opcionformatdisco="A"
		fi
	;;

   esac

	case $opcionformatdisco in

		"C" | "c")

			coloresIUAPP
			formatear_disco_F2FS

		;;

		*)

			break
		;;

	esac
done

}

# formatear_disco_F2FS
#
# Formatea un dispositivo con F2FS

formatear_disco_F2FS(){

local vollabel=""

cabecera_interfaz

echo ""
if test -x $D_BIN/lsblk;then
	lsblk
elif test -x /bin/lsblk;then
	lsblk
else
	echo -e "${C_ET} $formatear_disco_F2FS_MSG1 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	mount | grep -v "none"
	echo ""
fi
echo ""
echo "$formatear_disco_F2FS_MSG2"
read discofmt

# Formatea la unidad en F2FS

if test -z $vollabel;then
	vollabel="F2FS-DISK"
fi

cabecera_interfaz

echo "$formatear_disco_F2FS_MSG6"
umount $discofmt

echo "$formatear_disco_F2FS_MSG7"
echo "$formatear_disco_F2FS_MSG8: mkfs.f2fs -f -l $vollabel $discofmt"

if mkfs.f2fs -f -l $vollabel $discofmt;then
	echo -e "${C_OK}$formatear_disco_F2FS_MSG3${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
else
	echo -e "${C_FA}$formatear_disco_F2FS_MSG4 $discofmt${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
fi 

echo ""
echo "$formatear_disco_F2FS_MSG5"
echo ""

presskey
clear

}

# formatear_img_F2FS
#
# Formatea un archivo vacío en F2FS

formatear_img_F2FS(){

imagendd=$D_TMP/lcdgrabimg.f2fs
tambloque=4096

		# Tamaño personalizado
		# Adaptado de linux-cdgrab 1.0

		cabecera_interfaz
		echo -e "${C_ET}$formatear_img_F2FS_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo ""

		echo "$formatear_img_F2FS_MSG7"
		read tamarch
		echo -e "${C_AV}$formatear_img_F2FS_MSG8${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "${C_AV}# M -> MegaBytes # G -> GigaBytes # T -> Terabytes #${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -n "$formatear_img_F2FS_MSG9"
		read medidatam

		# Se calcula en tamaño de bytes el valor especificado por el usuario

		case $medidatam in 
		'M')
			tambytes=$(expr $tamarch \* 1024 \* 1024)
		;;

		'G')
			tambytes=$(expr $tamarch \* 1024 \* 1024 \* 1024)
		;;

		'T')
			tambytes=$(expr $tamarch \* 1024 \* 1024 \* 1024 \* 1024)
		;;
				
		*)

			echo -e "${C_FA} $formatear_img_F2FS_MSG10 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			tambytes=""
		;;
	
		esac
				
		if ! test -z $tambytes;then
		
			v_count=$(expr $tambytes / 4096)
			echo -e "${C_AV}$formatear_img_F2FS_MSG11 $tambloque ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo -e "${C_AV}$formatear_img_F2FS_MSG12 $tamarch$medidatam ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo -e "${C_AV}$formatear_img_F2FS_MSG13 $tambytes ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo -e "${C_AV}$formatear_img_F2FS_MSG14 $v_count ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			presskey
			
			cabecera_interfaz
			echo "$formatear_img_F2FS_MSG3"
			echo "$formatear_img_F2FS_MSG4: dd if=/dev/zero of=$imagendd  bs=4096 count=$v_count"

			dd if=/dev/zero of=$imagendd  bs=4096 count=$v_count

			# Formatea archivo vacio en F2FS
			echo "$formatear_img_F2FS_MSG5"
			echo "$formatear_img_F2FS_MSG4: mkfs.f2fs -f $imagendd"

			if mkfs.f2fs -f $imagendd;then
				echo -e "${C_OK} $formatear_img_F2FS_MSG1 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			else
				echo ""
				echo -e "${C_FA} $formatear_img_F2FS_MSG2 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			fi
			
		else
			echo -e "${C_FA}$formatear_img_F2FS_MSG15${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		fi
		
		presskey
		clear

}

# imgr_tmp
#
# Diversas operaciones sobre imágenes F2FS

imgr_tmp(){

INPUT=${D_TMP}/menu.sh.$$

coloresIUAPP

		while $verdadero;do

			cabecera_interfaz
			echo ""
			echo "1.- $imgr_tmp_MSG1"
			echo "2.- $imgr_tmp_MSG2"
			echo "0.- $imgr_tmp_MSG0"
			echo ""
			echo -e "${C_ET}$imgr_tmp_MSG3 $D_TMP ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo "======================================"
			ls -l $D_TMP/*.f2fs

			echo -n "$imgr_tmp_MSG4: "
			read imgrop

			case $imgrop in

				1)

					rm -rf $D_TMP/*.f2fs

					echo $imgr_tmp_MSG5
					presskey
				;;


				2)

					case $UD in
					0)
						dialog --title "MOUNT MENU" --backtitle "$PROGRAMA" --no-cancel --ok-label "OK" --inputbox "$imgr_tmp_MSG11" 						8 60 2> $D_LINUXCDGRAB/lcdgrabimgf2fs.$$
    						imagenf2fs=`cat $D_LINUXCDGRAB/lcdgrabimgf2fs.$$`
						rm -f $D_LINUXCDGRAB/lcdgrabimgf2fs.$$ &> /dev/null
						coloresIUAPP
					;;

					1)
						cabecera_interfaz
    						echo "$imgr_tmp_MSG11"
    						read imagenf2fs
					;;

					2)
						imagenf2fs=$(zenity --width=300 --height=100 --title="$PROGRAMA" --entry --text="$imgr_tmp_MSG11")
						coloresIUAPP
					;;

					3)
						imagenf2fs=$(kdialog --inputbox "$imgr_tmp_MSG11" --title="$PROGRAMA")
					;;

					esac

					case $UD in
					0)
						dialog --clear --no-cancel --ok-label "OK" --backtitle "-++ $PROGRAMA ++-" \
						--title "$PROGRAMA MOUNT MENU" \
						--menu "" 10 60 21 \
						M "$imgr_tmp_MSG6" \
						D "$imgr_tmp_MSG7" 2>"${INPUT}"
						op_monta_img="$(<${INPUT})"
						coloresIUAPP
					;;

					1)
						cabecera_interfaz
						echo "M.- $imgr_tmp_MSG6"
						echo "D.- $imgr_tmp_MSG7"

						read op_monta_img
					;;

					2)
						op_monta_img=$(zenity --width=300 --height=200 --title="$PROGRAMA" --entry --text="
MOUNT MENU
M) $imgr_tmp_MSG6
D) $imgr_tmp_MSG7")

						coloresIUAPP
					;;

					3)
						op_monta_img=$(kdialog --menu "MOUNT MENU" \
M "M- $imgr_tmp_MSG6" \
D "D- $imgr_tmp_MSG7" --title "$PROGRAMA")

						coloresIUAPP
					;;
					
					esac

					case $op_monta_img in

						"m" | "M" )
						
							cabecera_interfaz

							if mount -o loop -t f2fs $imagenf2fs $D_MNT;then
								echo -e "${C_OK}$imgr_tmp_MSG8${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
								ls -l $D_MNT
							else
								echo -e "${C_FA}$imgr_tmp_MSG12${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
							fi

							presskey
						;;

						"d" | "D" )

							cabecera_interfaz

							if umount $imagenf2fs;then
								echo -e "${C_OK}$imgr_tmp_MSG9${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
							else
								echo -e "${C_FA}$imgr_tmp_MSG13${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
							fi

							presskey
						;;

						*)

                        				echo -e "${C_FA}$imgr_tmp_MSG10${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
							sleep 1
						;;
					esac
				
				;;


				0)
					break
				;;

				*)
                    
                    			echo -e "${C_FA}$imgr_tmp_MSG10${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
					sleep 1
				;;

				esac

			done

[ -f $INPUT ] && rm -rf $INPUT &> /dev/null

}

#	#################### PROGRAMA PRINCIPAL ####################
#	Menú , Soporte para el sistema de ficheros F2FS

if test -z $D_LINUXCDGRAB;then
	export D_LINUXCDGRAB="/usr/share/linux-cdgrab"
fi

if test -z $IDIOM;then
	export IDIOM=".defecidiom"
fi

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabparches_idiom/lingr10f2fspatch.idiom || exit $?
# Portado de linux-cdgrab 1.0
source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUIUnidadesDisco.idiom || exit $?

if test -z $UD;then
	export UD=1
fi

while $verdadero;do

	INPUT=${D_TMP}/menu.sh.$$

	case $UD in
	0)
		dialog --clear --no-cancel --ok-label "OK" --backtitle "-++ $cabecera_interfaz_MSG2 ++-" \
		--title "$cabecera_interfaz_MSG2" \
		--menu " " 13 60 21 \
		1 "$lingr10F2FSpatch_MSG1" \
		2 "$lingr10F2FSpatch_MSG2" \
		3 "$lingr10F2FSpatch_MSG3" \
		4 "$lingr10F2FSpatch_MSG4" \
		0 "$lingr10F2FSpatch_MSG0" 2>"${INPUT}"
		menuop="$(<${INPUT})"
	;;
	
	1)
		echo -e ${COLOR_DEL_INTERFAZ}
		echo -e ${FONDO_INTERFAZ}
	
		cabecera_interfaz

		echo ""
		echo "1.- $lingr10F2FSpatch_MSG1"
		echo "2.- $lingr10F2FSpatch_MSG2"
		echo "3.- $lingr10F2FSpatch_MSG3"
		echo "4.- $lingr10F2FSpatch_MSG4"
		echo ""
		echo "0.- $lingr10F2FSpatch_MSG0"
		echo ""
		read menuop
	;;

	2)
		menuop=$(zenity --width=400 --height=150 --title="$cabecera_interfaz_MSG2" --entry --text="
1) $lingr10F2FSpatch_MSG1
2) $lingr10F2FSpatch_MSG2
3) $lingr10F2FSpatch_MSG3
4) $lingr10F2FSpatch_MSG4
0) $lingr10F2FSpatch_MSG0")

	;;

	3)
		menuop=$(kdialog --menu "SAMSUNG F2FS" \
1 "1- $lingr10F2FSpatch_MSG1" \
2 "2- $lingr10F2FSpatch_MSG2" \
3 "3- $lingr10F2FSpatch_MSG3" \
4 "4- $lingr10F2FSpatch_MSG4" \
0 "0- $lingr10F2FSpatch_MSG0" --geometry=500x230  --title "$cabecera_interfaz_MSG2")

	;;

	esac

	case $menuop in

		1)
			UIFormatearUnidad_linuxfs
		;;

		2)
			formatear_img_F2FS
		;;

		3)
			imgr_tmp
		;;

		4)
			creditos
		;;
		
		0)
			break
		;;

		*)
			echo -e "${C_FA}$lingr10F2FSpatch_MSG5${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			sleep 1
			continue
		;;
	esac

done

[ -f $INPUT ] && rm -rf $INPUT &> /dev/null

