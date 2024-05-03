#!/bin/bash

# path de ejecución: /usr/share/linux-cdgrab/parches/lingr10reiserfspatch.sh

# lingr10reiserfs.sh ver 0.2 --> 21/01/2024
# 
#
# Parche para soportar el sistema de ficheros ReiserFS en LINUX-CDGRAB 1.0
# Sistema de ficheros pŕoximamente excluido del kernel linux (futuro 2025).
# Se extrae el soporte de la aplicación principal y queda implementado
# como un parche, por retrocompatibilidad en distribuciones donde se use.

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
echo -e "${COLOR_DEL_INTERFAZ}$cabecera_interfaz_MSG3${FONDO_INTERFAZ}"

}

# formatear_disco_reiserfs
#
# Formatea un dispositivo con ReiserFS

formatear_disco_reiserfs(){

local vollabel=""
local lingrblksize="4096"

cabecera_interfaz

echo ""
if test -x $D_BIN/lsblk;then
	lsblk
elif test -x /bin/lsblk;then
	lsblk
else
	echo -e "${C_ET} $formatear_disco_reiserfs_MSG1 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	mount | grep -v "none"
	echo ""
fi
echo ""
echo $formatear_disco_reiserfs_MSG2
read discofmt

# Formatea la unidad en reiserfs

if test -z $vollabel;then
	vollabel="REISERFS-DISK"
fi

echo "$formatear_disco_reiserfs_MSG6"
umount $discofmt

echo "$formatear_disco_reiserfs_MSG7"
echo "$formatear_disco_reiserfs_MSG8: mkreiserfs -b 4096 -f -l $vollabel --format 3.6 $discofmt"

if mkreiserfs -b 4096 -f -l $vollabel --format 3.6 $discofmt;then
	echo $formatear_disco_reiserfs_MSG3
else
	echo "$formatear_disco_reiserfs_MSG4 $discofmt"
fi 

echo ""
echo $formatear_disco_reiserfs_MSG5
echo ""

presskey

}

# formatear_img_reiserfs
#
# Formatea un archivo vacío en ReiserFS

formatear_img_reiserfs(){

disco=$1
imagendd=$D_TMP/lcdgrabimg.reiserfs
tambloque=4096

case $disco in
	1)
		# CD
		v_count=179912
	;;

	2)
		# DVD
		v_count=1048576

	;;

	3)
		# DVD DL
		v_count=2097152
	;;

	4)
		# BD-R/RE
		v_count=6250000
	;;

	5)
		# Tamaño personalizado
		# Adaptado de linux-cdgrab 1.0

		cabecera_interfaz
		echo -e "${C_ET}$formatear_img_reiserfs_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo ""

		echo "$formatear_img_reiserfs_MSG7"
		read tamarch
		echo -e "${C_AV}$formatear_img_reiserfs_MSG8${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "${C_AV}# M -> MegaBytes # G -> GigaBytes # T -> Terabytes #${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -n "$formatear_img_reiserfs_MSG9"
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

			echo -e "${C_FA} $formatear_img_reiserfs_MSG10 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			tambytes=""
		;;
	
		esac
				
		if ! test -z $tambytes;then
			v_count=$(expr $tambytes / 4096)
			echo -e "${C_AV}$formatear_img_reiserfs_MSG11 $tambloque ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo -e "${C_AV}$formatear_img_reiserfs_MSG12 $tamarch$medidatam ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo -e "${C_AV}$formatear_img_reiserfs_MSG13 $tambytes ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo -e "${C_AV}$formatear_img_reiserfs_MSG14 $v_count ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			presskey
			
		else
			# Toma como valor por defecto el de DVD
			v_count=1048576
		fi

	;;
esac

# Genera archivo vacio

cabecera_interfaz
echo "$formatear_img_reiserfs_MSG3"
echo "$formatear_img_reiserfs_MSG4: dd if=/dev/zero of=$imagendd  bs=4096 count=$v_count"

dd if=/dev/zero of=$imagendd  bs=4096 count=$v_count

# Formatea archivo vacio en ReiserFS
echo "$formatear_img_reiserfs_MSG5"
echo "$formatear_img_reiserfs_MSG4: mkreiserfs -b 4096 -f --format 3.6 $imagendd"

if mkreiserfs -b 4096 -f --format 3.6 $imagendd;then
	echo -e "${C_OK} $formatear_img_reiserfs_MSG1 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
else
	echo ""
	echo -e "${C_FA} $formatear_img_reiserfs_MSG2 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
fi

presskey

}

# m_img_CDDVDBD_reiserfs
# 
# Submenú para elegir el tamaño de la imagen

m_img_CDDVDBD_reiserfs(){

case $UD in
0)
	dialog --clear --no-cancel --ok-label "OK" --backtitle "-++ $cabecera_interfaz_MSG2 ++-" \
	--title "IMG MENU" \
	--menu "IMG CD/DVD/BD" 13 55 13 \
	1 "$m_img_CDDVDBD_reiserfs_MSG1" \
	2 "$m_img_CDDVDBD_reiserfs_MSG2" \
	3 "$m_img_CDDVDBD_reiserfs_MSG3" \
	4 "$m_img_CDDVDBD_reiserfs_MSG4" \
	5 "$m_img_CDDVDBD_reiserfs_MSG5" 2>"${INPUT}"
	tipodisco="$(<${INPUT})"

	coloresIUAPP

;;

1)
	cabecera_interfaz
	printf "1.- $m_img_CDDVDBD_reiserfs_MSG1\n"
	printf "2.- $m_img_CDDVDBD_reiserfs_MSG2\n"
	printf "3.- $m_img_CDDVDBD_reiserfs_MSG3\n"
	printf "4.- $m_img_CDDVDBD_reiserfs_MSG4\n"
	printf "5.- $m_img_CDDVDBD_reiserfs_MSG5\n"	
	printf "\n"

	read tipodisco
;;

2)
	tipodisco=$(zenity --width=500 --height=300 --title="$cabecera_interfaz_MSG2" --entry --text="
	IMG CD/DVD/BD
	1.- $m_img_CDDVDBD_reiserfs_MSG1
	2.- $m_img_CDDVDBD_reiserfs_MSG2
	3.- $m_img_CDDVDBD_reiserfs_MSG3
	4.- $m_img_CDDVDBD_reiserfs_MSG4
	5.- $m_img_CDDVDBD_reiserfs_MSG5")

	coloresIUAPP

;;

3)
	tipodisco=$(kdialog --menu "IMG CD/DVD/BD" \
	1 "1- $m_img_CDDVDBD_reiserfs_MSG1" \
	2 "2- $m_img_CDDVDBD_reiserfs_MSG2" \
	3 "3- $m_img_CDDVDBD_reiserfs_MSG3" \
	4 "4- $m_img_CDDVDBD_reiserfs_MSG4" \
	5 "5- $m_img_CDDVDBD_reiserfs_MSG5" --geometry=500x200 --title "$cabecera_interfaz_MSG2")

	coloresIUAPP

;;

esac

formatear_img_reiserfs $tipodisco

}

# imgr_tmp
#
# Diversas operaciones sobre imágenes reiserfs

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
			ls -l $D_TMP/*.reiserfs

			echo -n "$imgr_tmp_MSG4: "
			read imgrop

			case $imgrop in

				1)

					rm -rf $D_TMP/*.reiserfs

					echo $imgr_tmp_MSG5
					presskey
				;;


				2)

					case $UD in
					0)
						dialog --title "MOUNT MENU" --backtitle "$PROGRAMA" --no-cancel --ok-label "OK" --inputbox "$imgr_tmp_MSG11" 						8 60 2> $D_LINUXCDGRAB/lcdgrabimgrei.$$
    						imagenreiser=`cat $D_LINUXCDGRAB/lcdgrabimgrei.$$`
						rm -f $D_LINUXCDGRAB/lcdgrabimgrei.$$ &> /dev/null
						coloresIUAPP
					;;

					1)
						cabecera_interfaz
    						echo "$imgr_tmp_MSG11"
    						read imagenreiser
					;;

					2)
						imagenreiser=$(zenity --width=300 --height=100 --title="$PROGRAMA" --entry --text="$imgr_tmp_MSG11")
						coloresIUAPP
					;;

					3)
						imagenreiser=$(kdialog --inputbox "$imgr_tmp_MSG11" --title="$PROGRAMA")
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
						clear
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

							if mount -o loop -t reiserfs $imagenreiser $D_MNT;then
								echo -e "${C_OK}$imgr_tmp_MSG8${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
								ls -l $D_MNT
							else
								echo -e "${C_FA}$imgr_tmp_MSG12${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
							fi

							presskey
						;;

						"d" | "D" )

							cabecera_interfaz

							if umount $imagenreiser;then
								echo -e "${C_OK}$imgr_tmp_MSG9${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
							else
								echo -e "${C_FA}$imgr_tmp_MSG13${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
							fi

							presskey
						;;

						*)

                        				echo $imgr_tmp_MSG10
							sleep 1
						;;
					esac
				
				;;


				0)
					break
				;;

				*)
                    
                    			echo $imgr_tmp_MSG10
					sleep 1
				;;

				esac

			done

[ -f $INPUT ] && rm -rf $INPUT &> /dev/null

}

#	#################### PROGRAMA PRINCIPAL ####################
#	Menú , Soporte para el sistema de ficheros ReiserFS

if test -z $D_LINUXCDGRAB;then
	export D_LINUXCDGRAB="/usr/share/linux-cdgrab"
fi

if test -z $IDIOM;then
	export IDIOM=".defecidiom"
fi

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabparches_idiom/lingr10reiserfspatch.idiom || exit $?

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
		1 "$lingr10reiserfspatch_MSG1" \
		2 "$lingr10reiserfspatch_MSG2" \
		3 "$lingr10reiserfspatch_MSG3" \
		0 "$lingr10reiserfspatch_MSG0" 2>"${INPUT}"
		menuop="$(<${INPUT})"
	;;
	
	1)


		echo -e ${COLOR_DEL_INTERFAZ}
		echo -e ${FONDO_INTERFAZ}
	
		cabecera_interfaz

		echo ""
		echo "1.- $lingr10reiserfspatch_MSG1"
		echo "2.- $lingr10reiserfspatch_MSG2"
		echo "3.- $lingr10reiserfspatch_MSG3"
		echo ""
		echo "0.- $lingr10reiserfspatch_MSG0"
		echo ""
		read menuop

	;;

	2)
		menuop=$(zenity --width=350 --height=150 --title="$cabecera_interfaz_MSG2" --entry --text="
1) $lingr10reiserfspatch_MSG1
2) $lingr10reiserfspatch_MSG2
3) $lingr10reiserfspatch_MSG3
0) $lingr10reiserfspatch_MSG0")

	;;

	3)
		menuop=$(kdialog --menu "$cabecera_interfaz_MSG2" \
1 "1- $lingr10reiserfspatch_MSG1" \
2 "2- $lingr10reiserfspatch_MSG2" \
3 "3- $lingr10reiserfspatch_MSG3" \
0 "0- $lingr10reiserfspatch_MSG0" --geometry=500x200  --title "$cabecera_interfaz_MSG2")

	;;

	esac

	case $menuop in

		1)
			coloresIUAPP
			formatear_disco_reiserfs

		;;

		2)
			
			m_img_CDDVDBD_reiserfs

		;;

		3)
			imgr_tmp
		;;

		0)
			break
		;;

		*)
			echo $lingr10reiserfspatch_MSG4
			sleep 1
			continue
		;;
	esac

done

[ -f $INPUT ] && rm -rf $INPUT &> /dev/null

