#########################################################
# lcgdrabCMD_API/lcdgrabIMAGENESCDDVD-API.sh
# Coleccion de funciones para la creacion y tratamiento
# de imagenes de CD y DVD.
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

##################### IMAGENES  #########################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabIMAGENESCDDVD-API.idiom

# imagen_ext2
# crea una imagen ext2

imagen_ext2(){

imagen=$D_TMP/lcdgrabimg.ext2
v_count=""

	clear
	cabecera

	# ------------------------------
	# Tamaño de imagen para CD
	# Obtencion del tamaño de la imagen ext2.
	#
	# cdrecord dev=3,0 -v -atip
	#
	# Linea : ATIP start of lead out : 359849 (79:59/74)
	# Tamaño en Mbytes 359849 * 2048 = 702 Mbytes
	# 
	# Esto nos saca el valor del fichero vacio que se formateara en ext2, 
	# el tamaño del fichero vacio sera el tamaño de un CD de datos virgen
	# de 702 Mbytes (80 Minutos)
	#
	# CD-R/CD-RW
	# ----------
	#
	# se corrige un error de grabacion
	#
	# count = 359849 , capacidad de un CD de 702 Mbytes (80 minutos)
	# count = 359824 , nueva capacidad en la que linux-cdgrab crea la imagen,
	#                  cdrecord no deberia informar de errores al grabar estas imagenes.
	#
	############################################
	# Tamaño de imagen para DVD
	# Obtencion del tamaño de la imagen ext2.
	#
	# dvd+rw-mediainfo
	#
	# Linea: READ CAPACITY: 2295104 * 2048 = 4700372992
	#
	# DVD+RW
	# ------
	#
	# count = 4194304 
	#
	# Tamaño en Mbytes 4096 ,tamaño en Gbytes 4.
	############################################
	# DVD+RW--> Se hace una conversión del tamaño
	#           dado por el comando dvd+rw-mediainfo.
	# 		
	#		count = 4194304 
	#
	# Tamaño en Mbytes 4096 ,tamaño en Gbytes 4.
	# dd hace imagenes de 8 Gbytes
	# count = 2097152 , se le da el nuevo valor a la mitad.
	# ------
	#

	printf "1.- $imagen_ext2_MSG1\n"
	printf "2.- $imagen_ext2_MSG2\n"
	printf "3.- $imagen_ext2_MSG3\n"
	printf "\n"

	read m_opcion

		case $m_opcion in

			1)
				v_count=359824
				echo $imagen_ext2_MSG4
			
			;;

			2)
				v_count=2097152
				echo $imagen_ext2_MSG5
			;;
	
			3)
				v_count=4194304
				echo $imagen_ext2_MSG6
			;;

		esac

if test -z $v_count;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $imagen_ext2_MSG7 9 50
	else
		echo -e "${C_FA} $imagen_ext2_MSG7 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

	break
else

	echo "$imagen_ext2_MSG8:dd if=/dev/zero of=$D_TMP/lcdgrabimg.ext2 bs=2048 count=$v_count"
	if dd if=/dev/zero of=$D_TMP/lcdgrabimg.ext2 bs=2048 count=$v_count;then

		clear
		cabecera
		echo $imagen_ext2_MSG9
		echo $imagen_ext2_MSG10
		echo $imagen_ext2_MSG11
		echo ""

		# se formatea el archivo vacio
		echo "$imagen_ext2_MSG8:mke2fs -m 0 -b 2048 $D_TMP/lcdgrabimg.ext2"
		if mke2fs -m 0 -b 2048 $D_TMP/lcdgrabimg.ext2;then

			echo ""
			cabecera
			echo -e "${C_OK}$D_TMP/lcdgrabimg.ext2 $imagen_ext2_MSG12 ${COLOR_DEL_INTERFAZ}"
			echo $imagen_ext2_MSG12B
			echo ""
			sleep 1
		else
			if $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $imagen_ext2_MSG13 9 50
			else
				echo -e "${C_FA} $imagen_ext2_MSG13 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
				teclash
			fi

		fi

		# monta el archivo en /mnt/lcdgrab

		if mount -o loop $D_TMP/lcdgrabimg.ext2 $D_MNT;then


			clear
			cabecera
			echo ""
			echo "$imagen_ext2_MSG9 $D_MNT"
			echo "$imagen_ext2_MSG15 $D_MNT"
			echo $imagen_ext2_MSG16
			echo "$imagen_ext2_MSG17 : $D_TMP/lcdgrabimg.ext2"
			error=0
		else
			echo -e "${C_FA} $imagen_ext2_MSG18 ${COLOR_DEL_INTERFAZ}"
			error=1
		fi


			teclash


		if expr $error = 0;then

			MSG=$imagen_ext2_MSG19
			echo $imagen_ext2_MSG20
			gestor_de_archivos $MSG
			clear

			echo -e "${C_AV}"
			echo $imagen_ext2_MSG21
			echo $imagen_ext2_MSG22
			echo ""
			echo "$imagen_ext2_MSG23 $D_TMP/lcdgrabimg.ext2 $imagen_ext2_MSG24"
			echo -e "${COLOR_DEL_INTERFAZ}"
			sleep 3

		fi
	else
		echo ""
		echo -e "${C_FA} $imagen_ext2_MSG25 ${COLOR_DEL_INTERFAZ}"
		echo ""
		echo $imagen_ext2_MSG26
		echo ""
		df -h
		teclash
	fi
fi
colores_interfaz

}

# extraer_isoCD_dd
# genera una imagen ISO-9660 del CD mediante el comando dd

extraer_isoCD_dd(){

	# Imagen .iso a generar.

imagen=$D_TMP/lcdgrabimg.iso

	# Crea la imagen .iso desde el dispositivo almacenado en la variable $LECTOR_CDROM

cabecera
echo $extraer_isoCD_dd_MSG1
echo "$extraer_isoCD_dd_MSG2: dd if=${LECTOR_CDROM} of=${imagen} conv=noerror,sync;sync"
sleep 1

dd if=${LECTOR_CDROM} of=${imagen} conv=noerror,sync;sync

if test -f ${imagen};then
	
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$extraer_isoCD_dd_MSG3" 9 50
	else
		echo -e "${C_OK} $extraer_isoCD_dd_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

else 
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$extraer_isoCD_dd_MSG4 $imagen." 9 50
	else
		echo -e "${C_FA} $extraer_isoCD_dd_MSG4 $imagen. ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
	
	break
fi

}

# extraer_isoDVD_dd
# genera una imagen ISO-9660 del CD mediante el comando dd

extraer_isoDVD_dd(){

	# crea la imagen del DVD

imagen=$D_TMP/lcdgrabdvdimg.iso

tes=0
cabecera
echo $extraer_isoDVD_dd_MSG1
sleep 1

echo "$extraer_isoDVD_dd_MSG2:dd if=${LECTOR_CDROM} of=${imagen} bs=2048 conv=noerror,sync;sync"

dd if=${LECTOR_CDROM} of=${imagen} bs=2048 conv=noerror,sync;sync

if test -f ${imagen};then

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$extraer_isoDVD_dd_MSG3 $D_TMP" 9 50
	else
		echo -e "${C_OK} $extraer_isoDVD_dd_MSG3 $D_TMP ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	fi

	sleep 1
else 
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$extraer_isoDVD_dd_MSG4 $imagen." 9 50
	else
		echo -e "${C_FA} $extraer_isoDVD_dd_MSG4 $imagen. ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
	break
fi

}

# extraer_iso_readcd
# genera una imagen ISO-9660 del CD mediante el comando readcd

extraer_iso_readcd(){

imagen=$D_TMP/lcdgrabimg.iso

cabecera

echo "$extraer_iso_readcd_MSG1:readcd dev=$LECTOR_CDROM speed=$Velocidad -v -clone f=$imagen"

if readcd dev=$LECTOR_CDROM speed=$Velocidad -v -clone f=$imagen;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$extraer_iso_readcd_MSG2" 9 50
	else
		echo -e "${C_OK} $extraer_iso_readcd_MSG3 $imagen ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		teclash
	fi
else
	if test $UD -eq 0;then
		img_error
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$extraer_iso_readcd_MSG4" 9 50
	else
		text_img_error
		echo -e "${C_AV} $extraer_iso_readcd_MSG4 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		teclash
	fi
	break
fi

}

# extraer_iso_mkisofs
# genera una imagen ISO-9660 del CD mediante el comando mkisofs

extraer_iso_mkisofs(){

		if mount $LECTOR_CDROM $MNT/cdrom || mount $LECTOR_CDROM $D_MNT;then

			echo -e "${C_OK} $extraer_iso_mkisofs_MSG1 ${COLOR_DEL_INTERFAZ}"
			echo $extraer_iso_mkisofs_MSG2
		    	echo $extraer_iso_mkisofs_MSG3
		    		    
		    case $v_mkisofs in
		    
		    1)
		    	# mkisofs de las cdrtools
		    	
		    	echo "$extraer_iso_mkisofs_MSG4:$(mkisofs -version)"
				echo "$extraer_iso_mkisofs_MSG5:mkisofs -J -r -l -apple -hfs-volid \"NUEVO\" -mac-name -joliet-long -verbose -V \"NUEVO\" -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO \`cut -d \' \' -f 2 /etc/mtab \| grep -e \"$MNT/cdrom\" \| grep -v \"$MNT/cdrom.\" \` \|\| \`cut -d \' \' -f 2 /etc/mtab \|grep -e \"$D_MNT\""
				
				if mkisofs -J -r -l -apple -hfs-volid "NUEVO" -mac-name -joliet-long -verbose -V "NUEVO" -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO `cut -d ' ' -f 2 /etc/mtab | grep -e "$MNT/cdrom" | grep -v "$MNT/cdrom." ` || `cut -d ' ' -f 2 /etc/mtab |grep -e "$D_MNT"`;then
				
					sync
					echo ""
					echo -e "${C_OK} $extraer_iso_mkisofs_MSG6 $D_TMP${COLOR_DEL_INTERFAZ}"

				else

					if test $UD -eq 0;then
						img_error
					else
						text_img_error
						teclash
					fi

					echo ""
					echo $extraer_iso_mkisofs_MSG7

					rm -f $imagen
					echo "$extraer_iso_mkisofs_MSG5:mkisofs -J -r -joliet-long -verbose -V \"NUEVO\" -A \"LINUX-CDGRAB 0.5\"  -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO \`cut -d ' ' -f 2 /etc/mtab \| grep -e \"$MNT/cdrom\" | grep -v \"$MNT/cdrom.\" \` \|\| \`cut -d \' \' -f 2 /etc/mtab \|grep -e \"$D_MNT\""

					if mkisofs -J -r -joliet-long -verbose -V "NUEVO" -A "LINUX-CDGRAB 0.5"  -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO `cut -d ' ' -f 2 /etc/mtab | grep -e "$MNT/cdrom" | grep -v "$MNT/cdrom." ` || `cut -d ' ' -f 2 /etc/mtab |grep -e "$D_MNT"`;then
						sync
					echo -e "${C_OK} $extraer_iso_mkisofs_MSG8 $D_TMP ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

					else
						if test $UD -eq 0;then
							img_error
						else
							text_img_error
							teclash
						fi

						echo "$extraer_iso_mkisofs_MSG9 $imagen $extraer_iso_mkisofs_MSG10 $CDROM"
						echo "$extraer_iso_mkisofs_MSG11 $imagen"
						echo "$extraer_iso_mkisofs_MSG12 $imagen $extraer_iso_mkisofs_MSG12B $D_MNT"
						sleep 3

						umount $D_MNT &> /dev/null
						mount -o loop $imagen $D_MNT ; ls -l $D_MNT
						
					fi

				fi

				teclash
				
		    ;;
		    
		    
		    2)
		    
		    	# genisoimage del cdrkit
		    	
		    	echo "$extraer_iso_mkisofs_MSG4:$(genisoimage -version)"
				echo "$extraer_iso_mkisofs_MSG5:genisoimage -J -r -l -apple -hfs-volid \"NUEVO\" -mac-name -joliet-long -verbose -V \"NUEVO\" -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -hide-rr-moved -allow-limited-size -graft-points -pad -o $imagen -iso-level $NIVEL_ISO \`cut -d \' \' -f 2 /etc/mtab \| grep -e \"$MNT/cdrom\" \| grep -v \"$MNT/cdrom.\" \` \|\| \`cut -d \' \' -f 2 /etc/mtab \|grep -e \"$D_MNT\""
				
				if genisoimage -J -r -l -apple -hfs-volid "NUEVO" -mac-name -joliet-long -verbose -V "NUEVO" -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -hide-rr-moved -allow-limited-size -graft-points -pad -o $imagen -iso-level $NIVEL_ISO `cut -d ' ' -f 2 /etc/mtab | grep -e "$MNT/cdrom" | grep -v "$MNT/cdrom." ` || `cut -d ' ' -f 2 /etc/mtab |grep -e "$D_MNT"`;then
				
					sync
					echo ""
					echo -e "${C_OK} $extraer_iso_mkisofs_MSG6 $D_TMP ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

				else
					if test $UD -eq 0;then
						img_error
					else
						text_img_error
						teclash
					fi

					echo ""
					echo $extraer_iso_mkisofs_MSG7

					rm -f $imagen
					echo "$extraer_iso_mkisofs_MSG5:genisoimage -J -r -joliet-long -verbose -V \"NUEVO\" -A \"LINUX-CDGRAB 0.5\"  -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -allow-limited-size -graft-points -pad -o $imagen -iso-level $NIVEL_ISO \`cut -d ' ' -f 2 /etc/mtab \| grep -e \"$MNT/cdrom\" | grep -v \"$MNT/cdrom.\" \` \|\| \`cut -d \' \' -f 2 /etc/mtab \|grep -e \"$D_MNT\""

					if genisoimage -J -r -joliet-long -verbose -V "NUEVO" -A "LINUX-CDGRAB 0.5"  -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -allow-limited-size -graft-points -pad -o $imagen -iso-level $NIVEL_ISO `cut -d ' ' -f 2 /etc/mtab | grep -e "$MNT/cdrom" | grep -v "$MNT/cdrom." ` || `cut -d ' ' -f 2 /etc/mtab |grep -e "$D_MNT"`;then
						sync
						echo -e "${C_OK} $extraer_iso_mkisofs_MSG16 $D_TMP ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

					else
						if test $UD -eq 0;then
							img_error
						else
							text_img_error
							teclash
						fi

						echo "$extraer_iso_mkisofs_MSG13 $imagen $extraer_iso_mkisofs_MSG13B $CDROM"
						echo "$extraer_iso_mkisofs_MSG11 $imagen"
						echo "$extraer_iso_mkisofs_MSG12 $imagen $extraer_iso_mkisofs_MSG12B $D_MNT"
						sleep 3

						umount $D_MNT &> /dev/null
						mount -o loop $imagen $D_MNT ; ls -l $D_MNT
						
					fi
				fi

				teclash
		    ;;
		    
		    3)
		    
		    	echo $extraer_iso_mkisofs_MSG14
			teclash
		    ;;
		    
			esac
			
		else
			echo "$extraer_iso_mkisofs_MSG15 $LECTOR_CDROM"
			teclash
		fi ## cierra la condicion del mandato mount

}

# mkisofs_vanilla
# Crea una imagen puramente ISO-9660.

# Los nombres de archivo seran siempre en mayusculas
# y contaran de una nomenclatura de 8 caracteres . 3 caracteres
# imagen compatible en MS-DOS
# Acepta el primer parametro $ruta
# Acepta un segundo parametro $disc

mkisofs_vanilla(){
	
	if test $disk -eq 0;then
	# Disco de una sola sesion
	imagen=$D_TMP/lcdgrabimg.iso
	fi

	if test $disk -eq 1;then
	# Disco multisesion
	imagen=$D_TMP/lcdgrabcmulti.iso
	fi

	MSG=$mkisofs_vanilla_MSG1
	echo $mkisofs_vanilla_MSG2
	echo $mkisofs_vanilla_MSG3
	
	# Disco de una sola sesion
	if test $disk -eq 0;then
		echo "$mkisofs_vanilla_MSG4:mkisofs -o $imagen $ruta"
		if mkisofs -o $imagen $ruta;then
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$mkisofs_vanilla_MSG5" 9 50
			else
				echo -e "${C_OK} $mkisofs_vanilla_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi
		else
			if test $UD -eq 0;then
				img_error
			else
				text_img_error
				teclash
			fi
		fi
	fi
	
	# Disco multisesion
	if test $disk -eq 1;then
		echo "$mkisofs_vanilla_MSG4:mkisofs -o $imagen $ruta"
		if mkisofs -o $imagen -C $(cdrecord dev=ATAPI:$CANALATAPI -msinfo) -M $CANALATAPI $ruta;then
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$mkisofs_vanilla_MSG5" 9 50
			else
				echo -e "${C_OK} $mkisofs_vanilla_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi
		else
			if test $UD -eq 0;then
				img_error
			else
				text_img_error
				teclash
			fi
		fi
	fi
colores_interfaz


}

# generar_iso_directorio
#
# Genera una imagen ISO-9660 desde
# diferentes rutas de directorios
# especificadas por el usuario.
# 
# Primeramente genera una iso-9660
# con metadatos RockRidge, HFS y Joliet.
# Si este intento es fallido, se eliminan
# los metadatos hfs.
# Si a su vez el proceso es fallido, se
# reintenta crear una iso sin estos metadatos.

generar_iso_directorio(){

		# Imagen de un directorio
		# 23-05-2016, soporte para imagenes iso puras, nombre 8.3 caracteres
		#             nombres de archivo en mayusculas.


		echo $generar_iso_directorio_MSG1
		sleep 1
		gestor_de_archivos $MSG
		clear	

		if test $UD -eq 0;then
			rutas_dir
		else
			text_rutas_dir
		fi

		clear
		cabecera
		echo $generar_iso_directorio_MSG2
		read etiqueta
		echo ""
	
		case $v_mkisofs in
		1)
		echo $generar_iso_directorio_MSG3
		echo $generar_iso_directorio_MSG4
		echo "$generar_iso_directorio_MSG5:$(mkisofs -version)"
		echo "$generar_iso_directorio_MSG6:mkisofs -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"

		if mkisofs -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then

			echo -e "${C_OK} $generar_iso_directorio_MSG7 $D_TMP ${COLOR_DEL_INTERFAZ}"
			error=0
			sleep 2
		else
			if test $UD -eq 0;then
				img_error
			else
				text_img_error
				teclash
			fi

			error=1

			echo $generar_iso_directorio_MSG8
			echo $generar_iso_directorio_MSG9
			echo "$generar_iso_directorio_MSG6:mkisofs -J -r -V -f -joliet-long -verbose $etiqueta -A LINUX-CDGRAB 0.5 -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1  -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"

			if mkisofs -J -r -V -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1  -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then

				echo -e "${C_OK} $generar_iso_directorio_MSG7 $D_TMP ${COLOR_DEL_INTERFAZ}"
				error=0
			else
				disc=0
				mkisofs_vanilla $ruta $disc

			fi
		fi

		;;
		
		2)
	
		echo $generar_iso_directorio_MSG3
		echo $generar_iso_directorio_MSG4
		echo "$generar_iso_directorio_MSG5:$(genisoimage -version)"
		echo "$generar_iso_directorio_MSG6:genisoimage -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -allow-limited-size -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"

		if genisoimage -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1 -hide-rr-moved -allow-limited-size -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then

			echo -e "${C_OK} $generar_iso_directorio_MSG7 $D_TMP ${COLOR_DEL_INTERFAZ}"
			error=0
			sleep 2
		else
			if test $UD -eq 0;then
				img_error
			else
				text_img_error
				teclash
			fi

			error=1

			echo $generar_iso_directorio_MSG8
			echo $generar_iso_directorio_MSG9
			echo "$generar_iso_directorio_MSG6:genisoimage -J -r -V -joliet-long -verbose $etiqueta -A LINUX-CDGRAB 0.5 -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1  -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"

			if genisoimage -J -r -V -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -volset-size 1 -volset-seqno 1  -hide-rr-moved -graft-points -pad -o $imagen -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then

				echo -e "${C_OK} $generar_iso_directorio_MSG7 $D_TMP ${COLOR_DEL_INTERFAZ}"
				error=0
			else
				disc=0
				mkisofs_vanilla $ruta $disc

			fi
		fi

		;;
		
		3)
			echo $generar_iso_directorio_MSG10
			error=1
			teclash
		;;
		
	esac
	
	if expr $error = 0;then
		clear
		cabecera
		echo "$generar_iso_directorio_MSG11: $imagen"
		echo ""
		echo $generar_iso_directorio_MSG12
		echo ""
		echo $generar_iso_directorio_MSG13
		read comp

			case $comp in
				"SI" | "si" | "Si" | "sI" | "s" | "S" | "Y" | "y" | "yes" | "YES" | "Yes" | "YEs" | "yEs" | "YeS" | "yeS" | "yES" )
				
					comprime $imagen
					ls -l $D_TMP
					teclash
					;;
				esac
	fi
}

# imagenISO
# Crea una imagen ISO - 9660, con extensiones (metadatos) RockRidge, HFS y Joliet.

# En caso de error intenta crear una imagen totalmente ISO - 9660.
# El formato de caracteres de los archivos seran mayusculas en nombres 8.3
 
imagenISO(){
	ruta="$HOME/rutas_lcdgrab.txt"
	imagen=$D_TMP/lcdgrabimg.iso
	MSG=$imagenISO_MSG1
	
	# Compatibilidad con el cdrkit de Debian,las cdrtools no usan
	# el parametro -allow-limited-size al llamar a mkisofs a la hora
	# de hacer imagenes con archivos >= 2 o 4 Gbytes por que no lo necesita,
	# en este caso basta especificar el nivel iso en 3 o 4.
	# Consultar la pagina man de mkisofs.
	# El parametro -allow-limited-size es usado por genisoimage en el cdrkit.
	 
	if test -x /usr/bin/mkisofs && ! test -h /usr/bin/mkisofs;then # comprueba si se trata del mkisofs disponible en las cdrtools.
	   	v_mkisofs=1
	elif test -x /usr/bin/genisoimage;then # comprueba si se trata del mkisofs disponible en el cdrkit.
	   	v_mkisofs=2
	else # mkisofs o genisoimage no se encuentra.
	  	v_mkisofs=3
	fi
	
while $verdadero;do
clear
cabecera
echo $imagenISO_MSG2
echo $imagenISO_MSG2B
echo ""
echo "1.- $imagenISO_MSG3"
echo "2.- $imagenISO_MSG4"
echo "3.- $imagenISO_MSG5"
echo "4.- $imagenISO_MSG6"
echo "5.- $imagenISO_MSG7"
echo ""
echo "0.- $imagenISO_MSG8"

read eleccion

case $eleccion in

######################### Imagen desde un CD usando dd

	1)		
	clear
	cabecera
	echo $imagenISO_MSG9
	extraer_isoCD_dd
		
	;;

######################### Imagen desde un DVD usando dd

	2)		
	clear
	cabecera
	echo $imagenISO_MSG9
	extraer_isoDVD_dd
		
	;;

######################### Imagen desde CD mediante readcd

	3)
		extraer_iso_readcd
	;;

######################### Imagen desde CD/DVD mediante mkisofs

	4)
		extraer_iso_mkisofs
	;;

######################### Imagen desde un directorio

	5)
		generar_iso_directorio
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

# imagen_img
# crea una imagen .img con dd

imagen_img(){

imagen_img=/tmp/lcdgrabimg.img

clear
cabecera
echo $imagen_img_MSG1
echo $imagen_img_MSG2
echo $imagen_img_MSG3
more /etc/fstab
more /etc/mtab
echo $imagen_img_MSG4
echo ""
mount
echo $imagen_img_MSG2
echo -n $imagen_img_MSG5
read dispositivo_origen

if test -b $dispositivo_origen;then
	
	clear
	cabecera
	echo "$imagen_img_MSG6: $dispositivo_origen"
	echo "$imagen_img_MSG7: dd bs=2048 if=${dispositivo_origen} of=${imagen_img} conv=noerror,sync"

	dd bs=2048 if=${dispositivo_origen} of=${imagen_img} conv=noerror,sync
	sync
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$imagen_img_MSG8 $imagen_img" 9 50
		else
			echo -e "${C_OK} $imagen_img_MSG8 $imagen_img ${COLORES_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi
else
	if test $UD -eq 0;then
		img_error
	else
		text_img_error
		teclash
	fi
fi
colores_interfaz

}

# monta_img
# monta y desmonta imagenes de CD en /mnt/lcdgrab

monta_img(){
		$MSG=$monta_img_MSG1
		gestor_de_archivos $MSG
		echo ""
		echo $monta_img_MSG2

		read ruta

		if ls $ruta | grep -e ".ext2" && expr $? = 0;then
			# Se trata de una imagen .ext2
			imgfs="ext2"
		else
			# Se trata de una imagen .iso
			imgfs="iso9660"
		fi

		if mount -o loop -t $imgfs $ruta $D_MNT;then

			clear
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$monta_img_MSG3" 9 50
				colores_interfaz
			else
				echo -e "${C_OK} $monta_img_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi

			ls -l $D_MNT
			teclash
		else
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$monta_img_MSG4" 9 50
				colores_interfaz
			else
				echo -e "${C_FA} $monta_img_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
				teclash
			fi
			
			if ! test -f $ruta;then

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$monta_img_MSG5 $ruta" 9 50
				else
					echo "$monta_img_MSG5 $ruta"
					teclash
				fi

			elif ! test -d $D_MNT;then

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$monta_img_MSG6 $D_MNT" 9 50
				else
					echo "$monta_img_MSG6 $D_MNT"
					teclash
				fi

			else

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$monta_img_MSG7" 9 50
				else
					echo $monta_img_MSG7
					teclash		
				fi
			fi

		fi

		colores_interfaz

}

# desmonta_img
# desmonta una imagen .iso, .ext2 o .img

desmonta_img(){

MSG=$desmonta_img_MSG1
if umount $D_MNT;then
	
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$desmonta_img_MSG2" 9 50
	else
		echo -e "${C_OK} $desmonta_img_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

else

	clear
	cabecera

	echo ""
	echo -e "${C_FA} $desmonta_img_MSG3 $D_MNT ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	echo ""
	echo $desmonta_img_MSG4
	echo "--------------------------------"
	mount
	echo ""
	echo $desmonta_img_MSG5
	echo $desmonta_img_MSG6
	echo $desmonta_img_MSG7
	teclash

		echo $desmonta_img_MSG8
		sleep 1
		gestor_de_archivos $MSG
		echo $desmonta_img_MSG9
		read ruta
		
		if umount $ruta;then
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$desmonta_img_MSG10" 9 50
			else
				echo $desmonta_img_MSG10
				teclash
			fi

		else
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$desmonta_img_MSG11" 9 50
			else
				echo $desmonta_img_MSG11
				teclash
			fi

		fi

fi

colores_interfaz

}

# nrg_a_iso
# Convierte imagenes de Nero Burning ROM en imagenes ISO-9660

# Adaptado de nrg70iso autor rodrigo nannig m. --> www.lawebdelprogramador.com
# No informar al autor de errores en el presente código

nrg_a_iso(){

imgciso=/tmp/lcdgrabnrgaiso.iso
MSG=$nrg_a_iso_MSG1

# comentarios del autor

# _NRG_HEADER es el tamaño de la cabecera del
# archivo nrg en bytes
# 
# NOTA: en realidad un archivo nrg no es mas
# que un archivo iso, a la cual se le agrega
# una cabecera de 300kb

_NRG_HEADER=300

gestor_de_archivos $MSG
echo $nrg_a_iso_MSG2
read imgnrg
echo $nrg_a_iso_MSG3

# comentarios del autor

# bs      bloques a leer y escribir en bytes (tambien bs=1k)
# skip    cuantos bloques nos vamos a saltar en bs bytes,
#         skip * bs = 300 * 1024
# if      fichero de entrada (el archivo nrg en nuestro caso)
# of      fichero de salida (el archivo iso a crear)

#
#############################################################################
#
# Informacion de archivos .nrg que son en realidad imagenes ISO-9660
# Comentarios del programa nrg2iso 0.1 y porción de código.
# Autor: Grégory Kokanosky <gregory.kokanosky@free.fr>
# Escrito en lenguaje C.
#
#if( fread( buf, 1,17*2048 ,f) == 17*2048 ) {

#    // taken from k3b
#    // check if this is an iso9660-image
#    // the beginning of the 16th sector needs to have the following format:
    
#    // first byte: 1
#    // second to 11th byte: 67, 68, 48, 48, 49, 1 (CD001)
#    // 12th byte: 0
    
#    iso = ( buf[16*2048] == 1 &&
#	    buf[16*2048+1] == 67 &&
#	    buf[16*2048+2] == 68 &&
#	    buf[16*2048+3] == 48 &&
#	    buf[16*2048+4] == 48 &&
#	    buf[16*2048+5] == 49 &&
#	    buf[16*2048+6] == 1 &&
#	    buf[16*2048+7] == 0 );
#  }
#  if(iso){
#    printf("It seems that %s is already an ISO 9660 image \n",filename);
#    printf("[Aborting conversion]\n");
#  }
# 
#

#
# Comentarios y poción de código de nrg70iso,sobre el mismo tema.
#
# algunos archivos nrg son iso en realidad, por lo
# cual solo basta con renombrarlos, esta funcion
# sirve para revisar el archivo nrg comprobando 
# que no sea un iso
#
# SINOPSIS: ckis filename
#
#ckiso()
#{
#  _err=0
#  dd bs=1024 skip=32 if="$1" of="$_ISO_TMP" count=1 2>"$_DD_TMP"

#  [ `cat "$_DD_TMP"|wc -l|cut -f1 -d' '` -ne 3 ] && 
#    _err=`expr $_err + 1`
#  [ $_err -eq 0 -a "`cut -b2-6 $_ISO_TMP`" != "CD001" ] && 
#    _err=`expr $_err + 1`

#  rm -f "$_DD_TMP" "$_ISO_TMP"
  
#  return $_err
#}
#
###############################################################################

if test -z $imgnrg && test -d $imgnrg;then # comprobacion para prevenir cuelgues del sistema.

	echo -e "${C_OK} $nrg_a_iso_MSG4 : $imgnrg $nrg_a_iso_MSG5 {$COLOR_DEL_INTERFAZ}"
	echo -e $nrg_a_iso_MSG6

else

    # Chequea si se trata de un archivo ISO-9660
    
    dd bs=1024 skip=32 if=$imgnrg of=$D_TMP/neroisotemporal count=1
    
    if test "$(cut -b2-6 $D_TMP/neroisotemporal)" = "CD001";then
    
    	# Se trata de un archivo iso.Se hace una nueva copia de él renombrado
    
    	nuevaiso=`basename "$imgnrg" .nrg`.iso
    	
    	echo -e "${C_AV} $imgnrg $nrg_a_iso_MSG7 ${COLOR_DEL_INTERFAZ}"
    	echo $nrg_a_iso_MSG8
   
    	cp -f $imgnrg $nuevaiso
    	echo -e "${C_OK} $nrg_a_iso_MSG9 ${COLOR_DEL_INTERFAZ}"
    	 	
    else
    	
    	# El archivo especificado si se trata de una imagen .nrg
    	# Se convierte a .iso
    	
		echo "$nrg_a_iso_MSG10:dd bs=1024 skip=$_NRG_HEADER if=$imgnrg of=$imgciso conv=noerror"
		
		if dd bs=1024 skip=$_NRG_HEADER if=$imgnrg of=$imgciso conv=noerror;then
			sync
			echo -e "${C_OK} $nrg_a_iso_MSG11 ${COLOR_DEL_INTERFAZ}"
		else
			echo -e "${C_FA} $nrg_a_iso_MSG12 ${COLOR_DEL_INTERFAZ}"
		fi	
	fi
	
	rm -f $D_TMP/neroisotemporal
fi

teclash
colores_interfaz

}

# GenerarArchivocue

# Genera un archivo .cue
# para una imagen de datos .bin
# que no acompañe de éste

GenerarArchivocue(){

MSG=$GenerarArchivocue_MSG1
gestor_de_archivos $MSG

echo ""
echo "$GenerarArchivocue_MSG2 $(pwd)"
echo ""
echo $GenerarArchivocue_MSG3
echo $GenerarArchivocue_MSG4
read imgbinpath
echo $GenerarArchivocue_MSG5
echo $GenerarArchivocue_MSG6
echo ""
read imagenbin
CUEF1="FILE \"$imagenbin\" BINARY"
CUEF2="  TRACK 01 MODE1/2352"
CUEF3="     INDEX 01 00:00:00"

nuevocue=`basename "$imagenbin" .bin`.cue

echo $CUEF1 > $imgbinpath/$nuevocue
echo $CUEF2 >> $imgbinpath/$nuevocue
echo $CUEF3 >> $imgbinpath/$nuevocue

if test -f $imgbinpath/$nuevocue;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$GenerarArchivocue_MSG7" 9 50
	else
		echo -e "${C_OK} $GenerarArchivocue_MSG7 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
else
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$GenerarArchivocue_MSG8" 9 50
	else
		echo -e "${C_FA} $GenerarArchivocue_MSG8 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
fi

colores_interfaz

}

# ImagenbincueCDDVD
# Crea una Imagen *.bin *.cue desde la grabadora de CD-DVD

# Contenido de ejemplo para un fichero cue (Datos)

# FILE "Imagenbincue.bin" BINARY
#  TRACK 01 MODE1/2352
#     INDEX 01 00:00:00

ImagenbincueCDDVD(){

# Contenido para la hoja cue de linux-cdgrab

CUEF1="FILE \"lcdgrabimgbincue.bin\" BINARY"
CUEF2="  TRACK 01 MODE1/2352"
CUEF3="     INDEX 01 00:00:00"

clear
cabecera
echo "$ImagenbincueCDDVD_MSG1:cdrdao read-cd --read-raw --datafile $HOME/lcdgrabimgbincue.bin --device $IDE $HOME/lcdgrabimgbincue.cue"

if cdrdao read-cd --read-raw --datafile $HOME/lcdgrabimgbincue.bin --device $IDE $HOME/lcdgrabimgbincue.cue;then

	# reescribe la hoja cue por estandarizacion
	# a la hora de ser grabado.
	# se escribe una hoja cue para un cd de datos.

	echo $CUEF1 > $HOME/lcdgrabimgbincue.cue
	echo $CUEF2 >> $HOME/lcdgrabimgbincue.cue
	echo $CUEF3 >> $HOME/lcdgrabimgbincue.cue

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$ImagenbincueCDDVD_MSG2" 9 50
	else
		echo -e "${C_OK} $ImagenbincueCDDVD_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
else
	if test $UD -eq 0;then
		img_error
	else
		text_img_error
		teclash
	fi
fi

	expulsar_medio $IDE

colores_interfaz

}

