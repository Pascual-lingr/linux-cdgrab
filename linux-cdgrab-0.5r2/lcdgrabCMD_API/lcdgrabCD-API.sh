#########################################################
# lcgdrabCMD_API/lcdgrabCD-API.sh
# Coleccion de funciones para grabaciones en CD.
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de linux-cdgrab 0.5
#########################################################

################## GRABACION EN CD ######################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabCD-API.idiom

# copia_bin
# copia un CD de datos creando una imagen binaria con dd.

copia_bin(){

#Si test llega valiendo 1, borra la imagen generada con dd al final del proceso.
	
tes=0

if test $utiliso -eq 1;then
	extraer_isoCD_dd
else
	extraer_iso_readcd
fi	

###### graba la imagen generada anteriormente en un CD o DVD.

#- comprueba si solo existe una grabadora fisica instalada en el ordenador.

if test $UD -eq 0;then

	una_sola_grabadora
else
	text_una_sola_grabadora
fi

#- fin de la comprobacion.

cabecera

echo "$copia_bin_MSG1:cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -dao -overburn -eject -data $imagen"

if cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -dao -overburn -eject -data $imagen & ImprimirProgreso;then

	tes=1
else
	if test $UD -eq 0;then
		CD_error
	else
		text_CD_error
		teclash
	fi

	cabecera
	echo $copia_bin_MSG2
	m_cdrecord-sin-overburn
	echo "$copia_bin_MSG1:cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -eject -data $imagen"

	if cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -eject -data $imagen & ImprimirProgreso;then

		tes=1

	else
		if test $UD -eq 0;then
			CD_error
		else
			text_CD_error
			teclash
		fi
	fi

fi


echo ""
echo $copia_bin_MSG3
rm -rf $D_TMP/lcdgrabimg.iso

eject $LECTOR_CDROM
eject $IDE

if test $tes -eq 1;then

	if test $UD -eq 0;then
		grabacion_ok
	else
		text_grabacion_ok
		teclash
	fi

else

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$copia_bin_MSG4" 9 50
	else
		echo -e "${C_FA} $copia_bin_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

fi

}


# datos_al_vuelo
# copia un CD de datos al vuelo, necesario $LECTOR_CDROM

datos_al_vuelo(){
tes=0

echo "$datos_al_vuelo_MSG1:cdrecord dev=$IDE driveropts=burnfree speed=$Velocidad -v -dao -overburn -isosize -eject $LECTOR_CDROM"

if cdrecord dev=$IDE driveropts=burnfree speed=$Velocidad -v -dao -overburn -isosize -eject $LECTOR_CDROM & ImprimirProgreso;then
	tes=1
else
	if test $UD -eq 0;then
		CD_error
	else
		text_CD_error
		teclash
	fi

	sleep 1
	echo -e "${C_FA}"
	echo $datos_al_vuelo_MSG2
	echo -e "${COLOR_DEL_INTERFAZ}"
	echo "|----------------------------------------------------------------------|"
	
	m_cdrecord-sin-overburn
	echo "$datos_al_vuelo_MSG1:cdrecord dev=$IDE driveropts=burnfree speed=$Velocidad -v -dao -isosize -eject $LECTOR_CDROM"

	if cdrecord dev=$IDE driveropts=burnfree speed=$Velocidad -v -dao -isosize -eject $LECTOR_CDROM & ImprimirProgreso;then
		test=1
	else
		if test $UD -eq 0;then
			CD_error
			echo ""
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$datos_al_vuelo_MSG3 $LECTOR_CDROM $datos_al_vuelo_MSG4" 9 50
		else
			text_CD_error
			echo ""
			echo "$datos_al_vuelo_MSG3 $LECTOR_CDROM $datos_al_vuelo_MSG4"
			teclash
		fi
	fi

fi

if test $tes -eq 1;then

	if test $UD -eq 0;then
		grabacion_ok
	else
		text_grabacion_ok
		teclash
	fi

fi

}

# clonar_cd
# clona un CD de datos al vuelo ,pasar como parametro LECTOR_CDROM

clonar_cd(){

echo "$datos_al_vuelo_MSG1:cdrecord dev=$IDE speed=$Velocidad -v driveropts=burnfree -clone -isosize -eject $LECTOR_CDROM"

if cdrecord dev=$IDE speed=$Velocidad -v driveropts=burnfree -clone -isosize -eject $LECTOR_CDROM & ImprimirProgreso;then

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$clonar_cd_MSG2" 9 50
	else
		echo -e "${C_OK} $clonar_cd_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

else

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$clonar_cd_MSG3" 9 50
	else
		echo -e "${C_FA} $clonar_cd_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

fi

}

# datos
# graba datos del disco duro a un CD

datos(){
	ruta="$HOME/rutas_lcdgrab.txt"
	tes=0
	MSG=$datos_MSG1

############ crea la imagen

if test $UD -eq 0;then
dialog --title $datos_MSG2 --backtitle "LINUX-CDGRAB 0.5" --inputbox $datos_MSG3 8 60 2> $D_LINUXCDGRAB/lcdgrabnombreetiqueta.$$
etiqueta=`cat $D_LINUXCDGRAB/lcdgrabnombreetiqueta.$$`   
else
echo $datos_MSG3
read etiqueta
fi

colores_interfaz
echo $datos_MSG4
sleep 1
gestor_de_archivos $MSG

if test $UD -eq 0;then
clear ; rutas_dir
else
clear ; text_rutas_dir
fi

echo $datos_MSG5
sleep 1

clear

colores_interfaz

echo "$datos_MSG6:mkisofs -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimg.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"

if mkisofs -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimg.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then				

	sync
	echo ""
	echo -e "${C_OK}"
	echo "$datos_MSG7 : $D_TMP/lcdgrabimg.iso"
	echo ""
	echo $datos_MSG8
	echo -e "${COLOR_DEL_INTERFAZ}"
	sleep 2
	echo ""
else
	if test $UD -eq 0;then
	img_error
	else
	text_img_error
	teclash
	fi

	sleep 1
	echo ""
	echo $datos_MSG9
	echo $datos_MSG10
	echo ""
	sleep 1
		echo $datos_MSG11
		rm -f $D_TMP/lcdgrabimg.iso

		echo $datos_MSG12
		echo "$datos_MSG6:mkisofs -J -r -l -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimg.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"
		
		if mkisofs -J -r -l -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimg.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then

			sync
			echo ""
			echo -e "	${C_OK}$datos_MSG7 : $D_TMP/imagen.iso${COLOR_DEL_INTERFAZ}"
			echo ""
			
		else
			disc=0
			mkisofs_vanilla $ruta $disc
			teclash		
		fi

fi

################ graba el CD

colores_interfaz

echo "$datos_MSG6:cdrecord dev=$IDE speed=$Velocidad driveropts=burnfree -v -dao -overburn -eject -data $D_TMP/lcdgrabimg.iso"

if cdrecord dev=$IDE speed=$Velocidad driveropts=burnfree -v -dao -overburn -eject -data $D_TMP/lcdgrabimg.iso & ImprimirProgreso;then
	tes=1

else
	if test $UD -eq 0;then
		CD_error
	else
		text_CD_error
		teclash
	fi

	echo ""
	echo "$datos_MSG13 $D_TMP/lcdgrabimg.iso"

	echo $datos_MSG14
	m_cdrecord-sin-overburn
	echo "$datos_MSG6:cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -eject -data $D_TMP/lcdgrabimg.iso"

	if cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -eject -data $D_TMP/lcdgrabimg.iso & ImprimirProgreso;then
		tes=1
	else
		if test $UD -eq 0;then
			CD_error
		else
			text_CD_error
			teclash
		fi
	fi

fi


echo $datos_MSG15
echo ""
rm -f $HOME/rutas_lcdgrab.txt
rm -f $D_TMP/lcdgrabimg.iso
echo ""

if test $tes -eq 1;then

	if test $UD -eq 0;then
		grabacion_ok
	else
		text_grabacion_ok
		teclash
	fi
	
fi

echo ""
rm -f $D_LINUXCDGRAB/lcdgrabnombreetiqueta.$$

}

# borra
# borra un CD-RW

borra(){

while $verdadero;do
clear
cabecera
echo $borra_MSG1
echo $borra_MSG2
echo ""
echo "1.- $borra_MSG3"
echo "2.- $borra_MSG4"
echo ""
read mod

if test $mod -eq 1;then

	blank_option=fast

elif test $mod -eq 2;then

	blank_option=all

else
	Opcion_invalida
	echo ""
	echo $borra_MSG5
	sleep 0.1
	break
fi

clear
cabecera

echo "$borra_MSG6:cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -eject blank=$blank_option"

if cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -eject blank=$blank_option & ImprimirProgreso;then

	if test $UD -eq 0;then
		dialog --title "$borra_MSG7" --backtitle "LINUX-CDGRAB 05" --msgbox "$borra_MSG8" 9 50
	else
		echo -e "${C_OK} $borra_MSG8 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	fi

else
	if test $UD -eq 0;then
		dialog --title "$borra_MSG9" --backtitle "LINUX-CDGRAB 05" --msgbox "$borra_MSG10" 9 50
		colores_interfaz
	else
		echo -e "${C_FA} $borra_MSG10 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	fi

	echo $borra_MSG11
	sleep 2
	echo "$borra_MSG6:cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -eject blank=$blank_option -force"

	if cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -eject blank=$blank_option -force & ImprimirProgreso;then
		
		if test $UD -eq 0;then
			dialog --title "$borra_MSG7" --backtitle "LINUX-CDGRAB 05" --msgbox "$borra_MSG12" 9 50
		else
			echo -e "${C_FA} $borra_MSG12 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		fi

	else
		if test $UD -eq 0;then
	        	dialog --title "$borra_MSG13" --backtitle "LINUX-CDGRAB 05" --msgbox "$borra_MSG14\n$borra_MSG15" 9 50
		else
			echo -e "${C_FA} $borra_MSG14\n$borra_MSG15 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		fi

	fi

fi

done

}

# cerrar_cd
# cierra un CD abierto

cerrar_cd(){

	echo "$cerrar_cd_MSG1:cdrecord dev=$IDE -v speed=$Velocidad -fix"

	if cdrecord dev=$IDE -v speed=$Velocidad -fix -eject & ImprimirProgreso;then
		
		if test -eq $UD -eq 0;then
			dialog  --backtitle "LINUX-CDGRAB 05" --msgbox "$cerrar_cd_MSG2" 9 50
		else
			echo -e "${C_OK} $cerrar_cd_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	else
		if test -eq $UD -eq 0;then
			dialog  --backtitle "LINUX-CDGRAB 05" --msgbox "$cerrar_cd_MSG3" 9 50
		else
			echo -e "${C_FA} $cerrar_cd_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi
	fi

	colores_interfaz	

}

# grabimg
# graba una imagen en CD o DVD mediante cdrecord

# modificada para informar sobre el proceso
# de grabacion de imagenes .ext2

grabimg(){

tes=0
MSG=$grabimg_MSG1

	echo $grabimg_MSG2
	gestor_de_archivos $MSG
	echo $grabimg_MSG3
	read imagen



	echo "$grabimg_MSG4:cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -overburn -eject -data $imagen"

	if cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -overburn -eject -data $imagen & ImprimirProgreso;then

		if ls $imagen | grep -e ".ext2" && expr $? = 0;then
		# Se trata de una imagen .ext2
			tes=2
		else
		# Se trata de una imagen .iso
			tes=1
		fi
	else


	     if test $MEDIO != "DVD";then
		
		if test $UD -eq 0;then
			CD_error
		else
			text_CD_error
			teclash
		fi

		echo ""

			echo $grabimg_MSG5
			m_cdrecord-sin-overburn
			echo "$grabimg_MSG4:cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -data $imagen"

			if cdrecord dev=$IDE driveropts=burnfree -v speed=$Velocidad -dao -eject -data $imagen & ImprimirProgreso;then
	
				if ls $imagen | grep -e ".ext2" && expr $? = 0;then
				# Se trata de una imagen .ext2
					tes=2
				else
				# Se trata de una imagen .iso
					tes=1
				fi

			else

				if test $UD -eq 0;then
					DO_error
				else
					text_DO_error
					teclash
				fi

			fi

	    else
			if test $UD -eq 0;then
				DO_error
			else
				text_DO_error
				teclash
			fi
	    fi
	fi

	if test $tes -eq 1;then

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$grabimg_MSG6" 9 50
		else
			echo -e "${C_OK} $grabimg_MSG6 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	else 
	     if test $tes -eq 2;then

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$grabimg_MSG7" 9 50	
		else
			echo -e "${C_OK} $grabimg_MSG7 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	     fi
	fi

colores_interfaz

}

# grabimg_cue
# graba una imagen .bin desde su fichero .cue en CD.

# requiere cdrdao

grabimg_cue(){

MSG=$grabimg_cue_MSG1
gestor_de_archivos $MSG
echo $grabimg_cue_MSG2
echo $grabimg_cue_MSG3
echo "$grabimg_cue_MSG4: $(pwd)"
echo $grabimg_cue_MSG5
echo -n $grabimg_cue_MSG6
read filecue

echo "$grabimg_cue_MSG7:cdrdao write --device $IDE --driver generic-mmc --speed $Velocidad $filecue"

if `cdrdao write --device $IDE --driver generic-mmc --speed $Velocidad $filecue`;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$grabimg_cue_MSG8" 9 50
	else
		echo -e "${C_OK} $grabimg_cue_MSG8 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
else
	if test $UD -eq 0;then
		CD_error
	else
		text_CD_error
		teclash
	fi
fi

expulsar_medio $IDE
colores_interfaz

}

# graba un CD multisesion

cd_multi(){

imagen=$D_TMP/lcdgrabcmulti.iso

while $verdadero;do
clear
cabecera
echo ""
echo "1.- $cd_multi_MSG1"
echo -e "${C_AV}    $cd_multi_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo "2.- $cd_multi_MSG3"
echo -e "${C_AV}    $cd_multi_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo -e "${C_AV}    $cd_multi_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo ""
echo "0.- $cd_multi_MSG6"
read cdmultimenu

case $cdmultimenu in

	1)	# crea un CD-Multisesion a partir de una imagen .iso

		clear
		MSG=$cd_multi_MSG7
		cabecera
		gestor_de_archivos $MSG
		echo ""
		echo $cd_multi_MSG8
		read isomulti
		
		echo ""
		echo "$cd_multi_MSG9:cdrecord dev=$IDE speed=$Velocidad driversopts=burnfree -v -dao -eject -multi -data $isomulti"

		if cdrecord dev=$IDE speed=$Velocidad driveropts=burnfree -v -dao -eject -multi -data $isomulti & ImprimirProgreso;then
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$cd_multi_MSG10" 9 50
			else
				echo -e "${C_OK} $cd_multi_MSG10 ${COLOR_EL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi
		else
			if test $UD -eq 0;then
				CD_error
			else
				text_CD_error
				teclash
			fi
		fi

	;;

	2)	# crea un CD_Multisesion a partir de ficheros y directorios en disco

		clear
		cabecera
		MSG=$cd_multi_MSG11
		gestor_de_archivos $MSG
		echo ""
		echo $cd_multi_MSG12
		sleep 1.5

		if test $UD -eq 0;then
			rutas_dir
		else
			text_rutas_dir
		fi

		clear
		cabecera
		echo $cd_multi_MSG13
		read etiqueta
		echo $cd_multi_MSG14
		echo "$cd_multi_MSG9:mkisofs -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $imagen -C $(cdrecord -msinfo dev=ATAPI:$CANALATAPI) -M ATAPI:$IDE -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"

		if mkisofs -J -r -l -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $imagen -C $(cdrecord -msinfo dev=ATAPI:$CANALATAPI) -M ATAPI:$IDE -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then
			
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$D_TMP/lcdgrabimg.iso $cd_multi_MSG15" 9 50
			else
				echo -e "${C_OK} $D_TMP/lcdgrabimg.iso $cd_multi_MSG15 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi

		else
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$cd_multi_MSG16" 9 50
			else
				echo -e "${C_FA} $cd_multi_MSG16 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi

			rm -f $HOME/rutas_lcdgrab.txt
			rm -f $D_TMP/lcdgrabcmulti.iso
			break
		fi
		
		colores_interfaz
		echo $cd_multi_MSG17
		echo "$cd_multi_MSG9:cdrecord dev=$IDE speed=$Velocidad driveropts=burnfree -v -dao -eject -multi -data $imagen"
		if cdrecord dev=$IDE speed=$Velocidad driveropts=burnfree -v -eject -multi -data $imagen & ImprimirProgreso;then
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$cd_multi_MSG10" 9 50
			else
				echo -e "${C_OK} $cd_multi_MSG10 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi
		else
			if test $UD -eq 0;then
				CD_error
			else
				text_CD_error
				teclash
			fi
		fi

		rm -f $HOME/rutas_lcdgrab.txt
		rm -f $D_TMP/lcdgrabcmulti.iso

	;;

	0)	# Sale del menu
		break
	;;

	*)	# Opcion invalida
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

# copia_cd_audio
# copia un cd de audio , ripea las pistas con cdda2wav

copia_cd_audio(){

rm -rf $D_TMP/lcdgrabaudio &> /dev/null
mkdir $D_TMP/lcdgrabaudio

#ripea el CD

echo $copia_cd_audio_MSG1
echo "$copia_cd_audio_MSG2: cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ "

if cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ ;then

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$copia_cd_audio_MSG3" 9 50
	else
		echo -e "${C_OK} $copia_cd_audio_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	fi

else

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$copia_cd_audio_MSG4" 9 50
	else
		echo -e "${C_FA} $copia_cd_audio_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	fi
fi

#graba el CD

if test $UD -eq 0;then
	una_sola_grabadora
else
	text_una_sola_grabadora
fi

echo $copia_cd_audio_MSG5
echo "$copia_cd_audio_MSG2:cdrecord -v gracetime=2 dev=$IDE speed=$Velocidad -dao driveropts=burnfree -eject -useinfo -audio -pad -shorttrack $D_TMP/lcdgrabaudio/*.[Ww][Aa][Vv]"

if cdrecord -v gracetime=2 dev=$IDE speed=$Velocidad -dao driveropts=burnfree -eject -useinfo -audio -pad -shorttrack $D_TMP/lcdgrabaudio/*.[Ww][Aa][Vv] & ImprimirProgreso;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$copia_cd_audio_MSG6" 9 50
	else
		echo -e "${C_OK} $copia_cd_audio_MSG6 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
else
	if test $UD -eq 0;then
		CD_error
	else
		text_CD_error
		teclash
	fi
fi
rm -rf $D_TMP/lcdgrabaudio
colores_interfaz

}

# wav_a_cd
# graba archivos de audio .wav a un CD

wav_a_cd(){

MSG=$wav_a_cd_MSG1

cabecera
gestor_de_archivos $MSG


echo -e "${C_AV}"
echo $wav_a_cd_MSG2
echo $wav_a_cd_MSG3
echo $wav_a_cd_MSG4
echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
echo $wav_a_cd_MSG5

read wavruta

echo "$wav_a_cd_MSG6:cdrecord -v gracetime=2 dev=$IDE speed=$Velocidad -raw96r driveropts=burnfree -useinfo -audio -pad -shorttrack `ls $wavruta/*.[Ww][Aa][Vv]`"

# Comando de grabacion de audio ejecutado por K3B 2.0.2; El audio se graba como RAW96R
# cdrecord -v gracetime=2 dev=/dev/sr0 speed=10 -raw96r driveropts=burnfree textfile=/tmp/qt_temp.wn2568 -useinfo -audio -shorttrack _________

cdrecord -v gracetime=2 dev=$IDE speed=$Velocidad -raw96r driveropts=burnfree -eject -useinfo -audio -pad -shorttrack `ls $wavruta/*.[Ww][Aa][Vv]` & ImprimirProgreso

if test $UD -eq 0;then
	dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$wav_a_cd_MSG7" 9 50
else
	echo -e "${C_OK} $wav_a_cd_MSG7 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	teclash
fi

colores_interfaz

}

# mp3_a_cd
# Graba archivos de audio .mp3 a un CD

mp3_a_cd(){

cabecera

mp3awav

clear

wav_a_cd

colores_interfaz

}

# ogg_a_cd
# Graba archivos de audio .ogg a un CD

ogg_a_cd(){

cabecera

oggawav

clear

wav_a_cd

colores_interfaz

}

# cdmixto
# Graba un CD mixto ; Datos .iso + Audio .wav

cdmixto(){

cte_zero=0

cabecera
MSG=$cdmixto_MSG1
gestor_de_archivos $MSG

echo -e "${C_AV}"
echo $cdmixto_MSG2
echo $cdmixto_MSG3
echo $cdmixto_MSG4
echo $cdmixto_MSG5
echo $cdmixto_MSG6
echo $cdmixto_MSG7
echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"

echo $cdmixto_MSG8
read cdmwavruta

echo $cdmixto_MSG9
read cdmisoruta
echo ""
echo -e "$C_ET"
echo $cdmixto_MSG10
echo $cdmixto_MSG11
echo $cdmixto_MSG10
echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
sleep 1

echo "$cdmixto_MSG12:cdrecord dev=$IDE speed=32 driveropts=burnfree -v -dao -eject $cdmisoruta -pad -audio `ls $cdmwavruta/*.[Ww][Aa][Vv]`"

if cdrecord dev=$IDE speed=32 driveropts=burnfree -v -dao -eject $cdmisoruta -pad -audio `ls $cdmwavruta/*.[Ww][Aa][Vv]` & ImprimirProgreso;then

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$cdmixto_MSG13" 9 50
	else
		echo -e "${C_OK} $cdmixto_MSG13 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

else
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$cdmixto_MSG14" 9 50
	else
		echo -e "${C_FA} $cdmixto_MSG14 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

fi

colores_interfaz

}

# discoinfo
# Informacion sobre el disco grabado ,usa cdrecord

discoinfo(){

echo "$discoinfo_MSG1:cdrecord dev=$IDE -mfinfo || cdrecord dev=$IDE -media-info"
cdrecord dev=$IDE -mfinfo || cdrecord dev=$IDE -media-info
teclash
colores_interfaz

}

