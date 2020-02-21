#########################################################
# lcgdrabCMD_API/lcdgrabDVD-API.sh
# Coleccion de funciones para grabaciones en DVD.
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

################################### GRABACION EN DVD #####################################

##############################################################################
################## API DE GRABACION CON dvd+-rw-tools ########################
##############################################################################

# Las siguientes llamadas a growisofs y dvd+rw-format han sido adaptadas de
# K3B y TkDVD.
# K3B --> www.k3b.org TkDVD --> http://regis.damongeot.free.fr/tkdvd

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabDVD-API.idiom

# buscar_grabadora
# comprueba el dispositivo que corresponde a la grabadora de DVD
# las dvd-rw-tools necesitan un dispositivo de bloque para funcionar.

# 12-10-2014 : Se elimina el código que muestra los dispositivos por medio del archivo /etc/fstab
#              Deja de ser util en distribuciones actuales de linux.

buscar_grabadora(){

if test -z $IDE;then
	IDE="$( cat $D_CFG/lcdgrab.cfg | grep -e 'IDE.' | sed -e 's/IDE//g' -e 's/ //g' -e 's/[=]//g')"
fi
	
if echo $IDE | grep -e '/dev.' &> /dev/null && expr $? = 0 &> /dev/null;then

	echo ""
	echo -e "$buscar_grabadora_MSG1 $IDE ${C_OK}$buscar_grabadora_MSG1B${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	grabadora_dvd=$IDE

else
	echo ""
	echo -e "$buscar_grabadora_MSG2 $IDE ${C_FA}$buscar_grabadora_MSG2B${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	echo -e "${C_AV}"
	echo "$buscar_grabadora_MSG3 $IDE"
	echo $buscar_grabadora_MSG4
	echo "$buscar_grabadora_MSG5 : /dev/ide/host0/bus1/target1/lun0/cd $buscar_grabadora_MSG6 /dev/hdd,/dev/hde etc"
	echo -e "${COLOR_DEL_INTERFAZ}"
	echo ""

	echo $buscar_grabadora_MSG7

	ls /dev
	tecla
        echo $buscar_grabadora_MSG8
        read grabadora_dvd

        if test -z $grabadora_dvd;then
		echo $buscar_grabadora_MSG9
        	teclash
	fi

fi

# exporta la grabadora al entorno.
echo "$buscar_grabadora_MSG10: $grabadora_dvd"
if ! test -z grabadora_dvd;then
     export grabadora_dvd
     echo "$buscar_grabadora_MSG11 $grabadora_dvd"
fi

sleep 1

}

# datos_dvd
# graba datos del disco duro a un DVD

datos_dvd(){
colores_interfaz
echo $datos_dvd_MSG1
read etiqueta

if test -z $etiqueta;then
	etiqueta="NUEVO DVD"
fi

echo ""
echo $datos_dvd_MSG2
echo ""

# comprueba que se trata de la version de mkisofs disponible en las cdrtools.

if test -x /usr/bin/mkisofs && ! test -h /usr/bin/mkisofs;then
	echo "$datos_dvd_MSG3 :$(mkisofs -version)"
	echo "$datos_dvd_MSG4:growisofs -Z $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -path-list $HOME/rutas_lcdgrab.txt"

	if growisofs -Z $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -path-list $HOME/rutas_lcdgrab.txt;then

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $datos_dvd_MSG5 9 50
		else
			echo -e "${C_OK} $datos_dvd_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	else
		if test $UD -eq 0;then
			DVD_error
		else
			text_DVD_error
			teclash
		fi
	fi
	
	expulsar_medio $IDE

elif test -x /usr/bin/genisoimage;then # comprueba que se trata de la version de mkisofs disponible en el cdrkit.

	echo "$datos_dvd_MSG3 :$(genisoimage -version)"
	echo "$datos_dvd_MSG4:growisofs -Z $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -allow-limited-size -path-list $HOME/rutas_lcdgrab.txt"

	if growisofs -Z $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -allow-limited-size -path-list $HOME/rutas_lcdgrab.txt;then

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $datos_dvd_MSG5 9 50
		else
			echo -e "${C_OK} $datos_dvd_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	else
		if test $UD -eq 0;then
			DVD_error
		else
			text_DVD_error
			teclash
		fi
	fi

	expulsar_medio $IDE

else

	echo $datos_dvd_MSG6
	teclash

fi

}

# datos_dvd_multi
# graba datos del disco duro a un DVD,crea un DVD multisesion

datos_dvd_multi(){

colores_interfaz
echo $datos_dvd_multi_MSG1
read etiqueta

if test -z $etiqueta;then
	etiqueta="NUEVO DVD"
fi

echo ""
echo $datos_dvd_multi_MSG2
echo ""

# comprueba que se trata de la version de mkisofs disponible en las cdrtools.El nivel iso debe estar en 3 para tener compatibilidad con ficheros grandes.

if test -x /usr/bin/mkisofs && ! test -h /usr/bin/mkisofs;then
	echo "$datos_dvd_multi_MSG3 :$(mkisofs -version)"
	echo "$datos_dvd_multi_MSG4:growisofs -M $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -path-list $HOME/rutas_lcdgrab.txt"

	if growisofs -M $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -path-list $HOME/rutas_lcdgrab.txt;then

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $datos_dvd_multi_MSG5 9 50
		else
			echo -e "${C_OK} $datos_dvd_multi_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	else
		if test $UD -eq 0;then
			DVD_error
		else
			text_DVD_error
			teclash
		fi
	fi
	
	expulsar_medio $IDE

elif test -x /usr/bin/genisoimage;then # comprueba que se trata de la version de mkisofs disponible en el cdrkit.Se utiliza -allow-limeted-size para dar soporte en ficheros grandes.

	echo "$datos_dvd_multi_MSG3 :$(genisoimage -version)"
	echo "$datos_dvd_multi_MSG4:growisofs -M $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -allow-limited-size -path-list $HOME/rutas_lcdgrab.txt"

	if growisofs -M $grabadora_dvd -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -dvd-compat -speed=$Velocidad -graft-points -pad -J -l -apple -hfs-volid $etiqueta -mac-name -r -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -iso-level $NIVEL_ISO -hide-rr-moved -allow-limited-size -path-list $HOME/rutas_lcdgrab.txt;then

		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $datos_dvd_multi_MSG5 9 50
		else
			echo -e "${C_OK} $datos_dvd_multi_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	else
		if test $UD -eq 0;then
			DVD_error
		else
			text_DVD_error
			teclash
		fi
	fi

	expulsar_medio $IDE

else
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $datos_dvd_multi_MSG6 9 50
	else
		echo $datos_dvd_multi_MSG6
		teclash
	fi

fi

}

# grabimg-dvd
# graba una imagen ISO-9660 en un DVD

# pasarle el parametro imagen

grabimg-dvd(){
cabecera
echo ""
echo $grabimg_dvd_MSG1
echo ""
echo "$grabimg_dvd_MSG2:growisofs -Z \"$grabadora_dvd=$imagen\" -dvd-compat -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -use-the-force-luke=spare:none -speed=$Velocidad"

if growisofs -Z "$grabadora_dvd=$imagen" -dvd-compat -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -use-the-force-luke=spare:none -speed=$Velocidad;then
	
	echo ""
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $grabimg_dvd_MSG3 9 50
	else
		echo -e "${C_OK} $grabimg_dvd_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

else
	if test $UD -eq 0;then
		DVD_error
	else
		text_DVD_error
		teclash
	fi
fi
	expulsar_medio $IDE
}

# copia_bin_dvd
# copia un DVD de datos creando una imagen binaria con dd, necesario el parametro LECTOR_CDROM

copia_bin_dvd(){

extraer_isoDVD_dd

if test $UD -eq 0;then
	una_sola_grabadora
else
	text_una_sola_grabadora
fi

cabecera

# graba la imagen en el DVD
echo ""
echo $copia_bin_dvd_MSG1
echo "$copia_bin_dvd_MSG2:growisofs -Z \"$grabadora_dvd=$imagen\" -dvd-compat -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -use-the-force-luke=spare:none -speed=$Velocidad"

if growisofs -Z "$grabadora_dvd=$imagen" -dvd-compat -use-the-force-luke=notray -use-the-force-luke=tty -use-the-force-luke=dao -use-the-force-luke=spare:none -speed=$Velocidad;then

	tes=1
else
	if test $UD -eq 0;then
		DVD_error
	else
		text_DVD_error
		teclash
	fi
fi

	expulsar_medio $IDE

echo ""
echo $copia_bin_dvd_MSG3
rm -rf $imagen
		
if test $tes -eq 1;then

	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $copia_bin_dvd_MSG4 9 50
	else
		echo -e "	${C_OK} $copia_bin_dvd_MSG4 ${COLOR_DEL_INTERFAZ}"
		echo ""
		teclash
	fi

fi

colores_interfaz
}

# formatear_dvd
# formatea un DVD+RW/DVD-RW

formatear_dvd(){

while $verdadero;do

	clear
	cabecera

	printf "1.- $formatear_dvd_MSG1 DVD+RW/DVD-RW\n"
	printf "\n"
	printf "\t\tDVD+RW\n"
	printf "\t\t------\n"
	printf "\n"
	printf "2.- $formatear_dvd_MSG2 DVD+RW\n"
	printf "3.- $formatear_dvd_MSG3 DVD+RW\n"
	printf "\n"
	printf "\t\tDVD-RW\n"
	printf "\t\t------\n"
	printf "\n"
	printf "4.- $formatear_dvd_MSG4\n"
	printf "5.- $formatear_dvd_MSG5\n"
	printf "\n"
	printf "N ---> $formatear_dvd_MSG6\n"
	printf "I ---> $formatear_dvd_MSG7\n"
	printf "\n"
	printf "0.- $formatear_dvd_MSG8\n"
	read fdvdop

	case $fdvdop in

		1)
			# DVD+RW / DVD-RW (Sobreescritura restringida)
			# Primer formato del DVD+RW/DVD-RW
			# no hace nada si ya esta formateado.
			# Si el disco es un DVD-RW lo formatea
			# en sobreescritura restringida.

			clear
			cabecera
			echo -e "${C_AV}"
			echo $formatear_dvd_MSG9
			echo $formatear_dvd_MSG10
			echo $formatear_dvd_MSG11
			echo $formatear_dvd_MSG12
			echo $formatear_dvd_MSG13
			echo $formatear_dvd_MSG14
			echo ""
			echo -e "${COLOR_DEL_INTERFAZ}"
			sleep 2
			echo "$formatear_dvd_MSG15:dvd+rw-format $grabadora_dvd"
			if dvd+rw-format $grabadora_dvd;then

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG16 9 50
				else
					echo -e "	${C_OK} $formatear_dvd_MSG16 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi

			else

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG17 9 50
				else
					echo -e "	${C_FA} $formatear_dvd_MSG17 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi
	
			fi
				expulsar_medio $IDE
		;;

		2)	
			# DVD+RW
			# Fuerza un nuevo formato para un DVD+RW
			# el comando nos indica que este modo no es recomendable.
			# Se pierden los datos del DVD+RW.

			clear
			cabecera
			echo $formatear_dvd_MSG18
			echo "$formatear_dvd_MSG15:dvd+rw-format -force $grabadora_dvd"
			echo ""
			if dvd+rw-format -force $grabadora_dvd;then

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG19 9 50
				else
					echo -e "	${C_OK} $formatear_dvd_MSG19 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi

			else

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG20 9 50
				else
					echo -e "	${C_FA} $formatear_dvd_MSG20 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi
	
			fi
				expulsar_medio $IDE
		;;

		3)
			# DVD+RW
			# Relocaliza el bloque lead-out en un DVD+RW
			# para obtener mejor compatibilidad en lectores DVD-ROM
			# No afecta a los datos del disco

			clear
			cabecera
			echo $formatear_dvd_MSG21
			sleep 1
			echo $formatear_dvd_MSG22
			echo "$formatear_dvd_MSG15:dvd+rw-format -lead-out $grabadora_dvd"
			echo ""
			if dvd+rw-format -lead-out $grabadora_dvd;then
				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG19 9 50
				else
					echo -e "	${C_OK} $formatear_dvd_MSG19 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi

			else

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG20 9 50
				else
					echo -e "	${C_FA} $formatear_dvd_MSG20 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi
	
			fi
				expulsar_medio $IDE
		;;
		
		4)
			# DVD-RW
			# Cambia el formato de un DVD-RW de sobreescritura restringida
			# a incremental secuencial (formato por defecto).Este nuevo formato
			# aunque sea el estandar no suele ser compatible en lectores DVD-ROM

			clear
			cabecera
			echo $formatear_dvd_MSG23
			echo "$formatear_dvd_MSG15:dvd+rw-format -blank=full $grabadora_dvd"
			echo ""
			if dvd+rw-format -blank=full $grabadora_dvd;then
				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG24 9 50
				else
					echo -e "	${C_OK} $formatear_dvd_MSG24 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi

			else

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG25 9 50
				else
					echo -e "	${C_FA} $formatear_dvd_MSG25 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi
	
			fi
				expulsar_medio $IDE
		;;

		5)
			# DVD-RW
			# Cambia el formato de un DVD-RW de incremental secuencial
			# a sobreescritura restringida.Este nuevo formato no parece 
			# see el estandar pero si es compatible con la mayoria de
			# lectores DVD-ROM

			clear
			cabecera
			echo $formatear_dvd_MSG26
			echo "$formatear_dvd_MSG15:dvd+rw-format -force=full $grabadora_dvd"
			echo ""
			if dvd+rw-format -force=full $grabadora_dvd;then
				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG24 9 50
				else
					echo -e "	${C_OK} $formatear_dvd_MSG24 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi

			else

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $formatear_dvd_MSG25 9 50
				else
					echo -e "	${C_FA} $formatear_dvd_MSG25 ${COLOR_DEL_INTERFAZ}"
					echo ""
					teclash
				fi
	
			fi
				expulsar_medio $IDE
		;;

		N)
			# Rellena de ceros un DVD+RW/DVD-RW
			# se escribe en el disco lo que genera /dev/zero.
			# Borra completamente los datos y el formato en un DVD+RW.
			# En el caso de un DVD-RW borra los datos pero no cambia
			# el formato de escritura secuencial a sobreescritura restringida
			# ni inversa,tampoco borra estos tipos de formato en el disco.

			null_dvd
		;;

		I)
			# Muestra la informacion del disco presente
			# en la unidad de grabacion.

			clear
			cabecera
			echo "$formatear_dvd_MSG15:dvd+rw-mediainfo $grabadora_dvd"
			dvd+rw-mediainfo $grabadora_dvd
			teclash
		;;

		0)
			break
		;;

		*)
			Opcion_invalida
		;;

	esac	 

done	
colores_interfaz

}

# null_dvd
# rellena de ceros un DVD+RW/DVD-RW

null_dvd(){
	colores_interfaz
	cabecera
	echo ""
	echo $null_dvd_MSG1
	echo "$null_dvd_MSG2:growisofs -Z $grabadora_dvd=/dev/zero"
	echo ""
	if growisofs -Z $grabadora_dvd=/dev/zero;then
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$null_dvd_MSG3" 9 50
		else
			echo -e "${C_OK} $null_dvd_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		fi
	else
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$null_dvd_MSG4" 9 50
		else
			echo -e "${C_FA} $null_dvd_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	fi

	expulsar_medio $IDE
}

# dvd_video
# graba DVD-Video

dvd_video(){

	colores_interfaz
	MSG=$dvd_video_MSG1
	gestor_de_archivos $MSG
	echo $dvd_video_MSG2
	echo ""
	read ruta_video

	echo "$dvd_video_MSG3:growisofs -Z $grabadora_dvd -use-the-force-luke=tty -speed=$Velocidad -dvd-compat -dvd-video $ruta_video"

	if growisofs -Z $grabadora_dvd -use-the-force-luke=tty -speed=$Velocidad -dvd-compat -dvd-video $ruta_video;then
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$dvd_video_MSG4" 9 50
		else
			echo -e "${C_OK} $dvd_video_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi
	else
		if test $UD -eq 0;then
			DVD_error
		else
			text_DVD_error
		fi
	fi

	expulsar_medio $IDE

}

##############################################################################
################## API DE GRABACION CON Cdrecord-ProDVD ######################
##############################################################################

# dvd_copia_bin
# copia un DVD de datos creando una imagen binaria con dd.

dvd_copia_bin(){

#Si test llega valiendo 1, borra la imagen generada con dd al final del proceso.
	
tes=0

extraer_isoDVD_dd

###### graba la imagen generada anteriormente en un CD o DVD.

#- comprueba si solo existe una grabadora fisica instalada en el ordenador.

if test $UD -eq 0;then

	una_sola_grabadora
else
	text_una_sola_grabadora
fi

#- fin de la comprobacion.

cabecera

echo "$dvd_copia_bin_MSG1:cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -dao -overburn -eject -data $imagen"

if cdrecord dev=$IDE -v driveropts=burnfree speed=$Velocidad -dao -overburn -eject -data $imagen & ImprimirProgreso;then

	tes=1
else
	if test $UD -eq 0;then
		DVD_error
	else
		text_DVD_error
		teclash
	fi

fi


echo ""
echo $dvd_copia_bin_MSG2
rm -rf $D_TMP/lcdgrabdvdimg.iso

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
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$dvd_copia_bin_MSG3" 9 50
	else
		echo -e "${C_FA} $dvd_copia_bin_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

fi

}

# dvd_datos
# graba datos del disco duro a un DVD

dvd_datos(){
	ruta="$HOME/rutas_lcdgrab.txt"
	tes=0
	MSG=$dvd_datos_MSG1

############ crea la imagen

if test $UD -eq 0;then
dialog --title $dvd_datos_MSG2 --backtitle "LINUX-CDGRAB 0.5" --inputbox "$dvd_datos_MSG3" 8 60 2> $D_LINUXCDGRAB/lcdgrabnombreetiqueta.$$
etiqueta=`cat $D_LINUXCDGRAB/lcdgrabnombreetiqueta.$$`   
else
echo $dvd_datos_MSG3
read etiqueta
fi

colores_interfaz
echo $dvd_datos_MSG4
sleep 1
gestor_de_archivos $MSG

if test $UD -eq 0;then
clear ; rutas_dir
else
clear ; text_rutas_dir
fi

echo $dvd_datos_MSG5
sleep 1

clear

colores_interfaz

echo "$dvd_datos_MSG6:mkisofs -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimgdvd.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"

if mkisofs -J -r -l -apple -hfs-volid $etiqueta -mac-name -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimgdvd.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then				

	sync
	echo ""
	echo -e "${C_OK}"
	echo "$dvd_datos_MSG7 : $D_TMP/lcdgrabimgdvd.iso"
	echo ""
	echo $dvd_datos_MSG8
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
	echo $dvd_datos_MSG9
	echo $dvd_datos_MSG10
	echo ""
	sleep 1
		echo $dvd_datos_MSG11
		rm -f $D_TMP/lcdgrabimgdvd.iso

		echo $dvd_datos_MSG12
		echo "$dvd_datos_MSG6:mkisofs -J -r -l -joliet-long -verbose -V $etiqueta -A \"LINUX-CDGRAB 0.5\" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimgdvd.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt"
		
		if mkisofs -J -r -l -joliet-long -verbose -V $etiqueta -A "LINUX-CDGRAB 0.5" -sysid $IDSISTEMA -hide-rr-moved -graft-points -pad -o $D_TMP/lcdgrabimgdvd.iso -iso-level $NIVEL_ISO -path-list $HOME/rutas_lcdgrab.txt;then

			sync
			echo ""
			echo -e "	${C_OK} $dvd_datos_MSG7 : $D_TMP/lcdgrabimgdvd.iso${COLOR_DEL_INTERFAZ}"
			echo ""
			
		else
			text_img_error
			teclash		
			break
		fi

fi

################ graba el DVD

colores_interfaz

echo "$dvd_datos_MSG6:cdrecord dev=$IDE speed=$Velocidad driveropts=burnfree -v -dao -overburn -eject -data $D_TMP/lcdgrabimgdvd.iso"

if cdrecord dev=$IDE speed=$Velocidad driveropts=burnfree -v -dao -overburn -eject -data $D_TMP/lcdgrabimgdvd.iso & ImprimirProgreso;then
	tes=1

else
	if test $UD -eq 0;then
		DVD_error
	else
		text_DVD_error
		teclash
	fi

fi


echo $dvd_datos_MSG13
echo ""
rm -f $HOME/rutas_lcdgrab.txt
rm -f $D_TMP/lcdgrabimgdvd.iso
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

# dvd_grabimg
# grabimg
# graba una imagen en CD o DVD mediante cdrecord

# modificada para informar sobre el proceso
# de grabacion de imagenes .ext2

dvd_grabimg(){

	grabimg

}

# dvd_borra
# Formatea un disco CD-RW/DVD-RW/DVD+RW

dvd_borra(){

clear
cabecera

echo "$dvd_borra_MSG1:cdrecord dev=$IDE speed=$Velocidad -format -v -eject"

if cdrecord dev=$IDE speed=$Velocidad -format -v -eject & ImprimirProgreso;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$dvd_borra_MSG2" 9 50
	else
		echo -e "${C_OK} $dvd_borra_MSG2 ${COLOR_EL_INTERFAZ} ${FONDO_INTERFAZ}"
	fi
else
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$dvd_borra_MSG3" 9 50
	else
		echo $dvd_borra_MSG3
		teclash
	fi
fi


}

# dvd_discoinfo
# Informacion sobre el disco grabado ,usa cdrecord

dvd_discoinfo(){

echo "$dvd_discoinfo_MSG1:cdrecord dev=$IDE -mfinfo || cdrecord dev=$IDE -media-info"
cdrecord dev=$IDE -mfinfo || cdrecord dev=$IDE -media-info
teclash
colores_interfaz

}

