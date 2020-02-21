#########################################################
# lcgdrabCMD_API/lcdgrabAUDIO-API.sh
# Coleccion de funciones para la extracción de pistas
# CD-Audio a diversos formatos de audio. Convierte
# formatos de audio. Soportados wav,ogg y mp3.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

########################## CONVERSION DE AUDIO ################################
###############################################################################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabAUDIO-API.idiom

# Funciones : mp3awav , oggawav
# Porción de código adaptado de mp32wav-0.2.4.
# mp32wav-0.2.4 --> Pacho Ramos pacho@condmat1.ciencias.uniovi.es
#		--> Encontrado en http://blogdrake.net
# No informar al autor de mp32wav sobre errores de este código.

# mp3awav
# convierte .mp3 en .wav
# acerta rutamp3 como parametro

mp3awav(){

if test -z $rutamp3 || ! test -d $rutamp3;then
	echo $mp3awav_MSG0
	read rutamp3
fi

if test -d $rutamp3;then

	cabecera

	for i in $rutamp3/*.[Mm][Pp][3];do

		cancionmp3=$i
		nombrewav=`basename "$cancionmp3" .mp3`.wav
		cancionwav="$( echo "$rutamp3/$nombrewav" | sed -e 's/[ ]/_/g' -e 's/[	]/_/g')"
		corregido="$( echo "$rutamp3/corregido.wav")"
		fnormalizado="$( echo "$rutamp3/fnormalizado.wav")"

		echo -e "${C_AV}$mp3awav_MSG1 $cancionmp3 $mp3awav_MSG1B ${COLOR_DEL_INTERFAZ}"
		echo "$mp3awav_MSG2:lame -h --decode \"$cancionmp3\" \"${cancionwav}\""

		if lame -h --decode "$cancionmp3" "${cancionwav}";then
			echo -e "${C_OK} $cancionwav OK ${COLOR_DEL_INTERFAZ}"
			echo ""

			echo "$mp3awav_MSG2:sox $cancionwav -r 44100 $corregido"

			if sox $cancionwav -r 44100 $corregido;then
				echo -e "${C_OK} $mp3awav_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
				mv -f "$corregido" "$cancionwav"
				echo "$mp3awav_MSG8 $cancionwav"

				echo "$mp3awav_MSG2:sox --norm $cancionwav $fnormalizado"

				if sox --norm $cancionwav $fnormalizado;then
					mv -f "$fnormalizado" "$cancionwav"
					echo -e "${C_OK} $mp3awav_MSG9 $cancionwav $mp3awav_MSG10 ${COLOR_DE_INTERFAZ}${FONDO_INTERFAZ}"
				else
					echo -e "${C_FA} $mp3awav_MSG11 $cancionwav ${COLOR_DE_INTERFAZ}${FONDO_INTERFAZ}"
				fi

			else
				echo -e "${C_FA} $mp3awav_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			fi

			echo ""

		else 
			echo -e "${C_FA} $cancionmp3 $mp3awav_MSG5 ${COLOR_DEL_INTERFAZ}"
		fi
	done

else
	cabecera
	echo -e "${C_FA} $mp3awav_MSG6 $rutamp3${COLOR_DEL_INTERFAZ}"
	sleep 2
	echo ""
fi

if test $UD -eq 0;then
	dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$mp3awav_MSG7" 9 50
else
	echo $mp3awav_MSG7
	teclash
fi

}

# oggawav
# convierte .ogg a .wav
# acepta rutaogg como parametro

oggawav(){

if test -z $rutaogg || ! test -d $rutaogg;then
	echo $oggawav_MSG1
	read rutaogg
fi

if test -d $rutaogg;then
	
	cabecera

	for i in $rutaogg/*.[Oo][Gg][Gg];do

		cancionogg=$i
		nombrewav=`basename "$cancionogg" .ogg`.wav
		cancionwav="$( echo "$rutaogg/$nombrewav" | sed -e 's/[ ]/_/g' -e 's/[	]/_/g')"
		corregido="$( echo "$rutaogg/corregido.wav")"
		fonormalizado="$( echo "$rutaogg/fonormalizado.wav")"

		echo -e "${C_AV} $oggawav_MSG2 $cancionogg $oggawav_MSG2B ${COLOR_DEL_INTERFAZ}"
		echo "$oggawav_MSG3:oggdec \"${cancionogg}\" -o \"${cancionwav}\""

			if oggdec "${cancionogg}" -o "${cancionwav}";then

				echo -e "${C_OK} $cancionwav OK${COLOR_DEL_INTERFAZ}"
				echo ""

			echo -e "${C_OK} $cancionwav OK ${COLOR_DEL_INTERFAZ}"
			echo ""

			echo "$oggawav_MSG3:sox $cancionwav -r 44100 $corregido"

				if sox $cancionwav -r 44100 $corregido;then
					echo -e "${C_OK} $oggawav_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
					mv -f "$corregido" "$cancionwav"

					echo "$oggawav_MSG3:sox --norm $cancionwav $fonormalizado"

					if sox --norm $cancionwav $fonormalizado;then
						mv -f "$fonormalizado" "$cancionwav"
						echo -e "${OK} $oggawav_MSG10 $cancionwav $oggawav_MSG11 ${COLOR_DE_INTERFAZ}${FONDO_INTERFAZ}"
					else
						echo -e "${FA} $oggawav_MSG12 $cancionwav ${COLOR_DE_INTERFAZ}${FONDO_INTERFAZ}"
					fi

				else
					echo -e "${C_FA} $oggawav_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
				fi

			else 
				echo -e "${C_FA} $cancionogg $oggawav_MSG6 ${COLOR_DEL_INTERFAZ}"
			fi
	done

else
	cabecera
	echo -e "${C_FA} $oggawav_MSG7 $rutaogg ${COLOR_DEL_INTERFAZ}"
	echo ""
fi

if test $UD -eq 0;then
	dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$oggawav_MSG8" 9 50
else
	echo "$oggawav_MSG8"
	teclash
fi

}

# cdawav
# cdawav,Ripea un CD de Audio a ficheros .wav

cdawav(){

mkdir ${D_TMP}/lcdgrabaudio

clear
cabecera

echo $cdawav_MSG1
echo "$cdawav_MSG2 cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ "

if cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ ;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $cdawav_MSG3 9 50
	else
		echo -e "${C_OK} $cdawav_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

	clear
	cabecera
	echo "$cdawav_MSG4 $D_TMP/lcdgrabaudio :"
	ls -l $D_TMP/lcdgrabaudio
	teclash
else
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $cdawav_MSG5 9 50
	else
		echo -e "${C_FA} $cdawav_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

fi

}

# cddawav
# ripea un numero determinado de pistas de audio a ficheros .wav

cddawav(){

x=1 # contador

clear
cabecera

echo $cddawav_MSG1
read numcanciones

if test -d $D_TMP/lcdgrabaudio;then
	rm -rf $D_TMP/lcdgrabaudio
fi

mkdir $D_TMP/lcdgrabaudio

while `test $x -le $numcanciones`;do

	nombrewav=`basename pista_"$x"`.wav
	echo $cddawav_MSG2
	echo "$cddawav_MSG3 cdda2wav dev=$IDE auxdevice=$LECTOR_CDROM speed=$Velocidad -stereo -max -i $numcanciones track=$x $D_TMP/lcdgrabaudio"

	if cdda2wav dev=$IDE auxdevice=$LECTOR_CDROM speed=$Velocidad -stereo -max -i $numcanciones track=$x $D_TMP/lcdgrabaudio ;then
		echo -e "${C_OK} pista_$x.wav $cddawav_MSG4 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	else
		echo -e "${C_FA} $cddawav_MSG5 pista_$x.wav ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	fi

	let x++

done

}

# wavamp3
# comprime ficheros .wav en mp3

# comando de comprension: lame -h -m s -b 128 archivo.wav archivo.mp3

wavamp3(){

if test -z $*;then

	echo $wavamp3_MSG1
	read rutawav

else
	rutawav=$*
fi

if test -d $rutawav;then
	
	cabecera

	for i in $rutawav/*.[Ww][Aa][Vv];do

		cancionwav=$i
		nombremp3=`basename "$cancionwav" .wav`.mp3
		cancionmp3="$( echo "$rutawav/$nombremp3" | sed -e 's/[ ]/_/g' -e 's/[	]/_/g')"
		

		echo -e "${C_AV}$wavamp3_MSG1B $cancionwav $wavamp3_MSG2 .mp3 ${COLOR_DEL_INTERFAZ}"
		echo "$cdamp3_MSG2 lame -h -m s -b 128 $cancionwav $cancionmp3"

		
		if lame -h -m s -b 128 $cancionwav $cancionmp3;then
			echo -e "${C_OK} $cancionmp3 OK${COLOR_DEL_INTERFAZ}"
			echo ""
		else
			echo -e "${C_FA}$wavamp3_MSG6 $cancionwav $wavamp3_MSG5 ${COLOR_DEL_INTERFAZ}"
		fi
		
	done
fi

if test -eq 0;then
	dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $wavamp3_MSG7 9 50
else
	echo $wavamp3_MSG7
	teclash
fi
rm -f $rutawav/*.[Ww][Aa][Vv] $rutawav/*.inf

}

# cdamp3
# Ripea un CD de Audio a ficheros .mp3

cdamp3(){

mkdir ${D_TMP}/lcdgrabaudio

clear
cabecera

echo $cdamp3_MSG1
echo "$cdamp3_MSG2 cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ "

if cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ ;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $cdamp3_MSG3 9 50
	else
		echo -e "${C_OK} $cdamp3_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

	rutamp3="$D_TMP/lcdgrabaudio"
else
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $cdamp3_MSG4 9 50
	else
		echo -e "${C_FA} $cdamp3_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi

fi

clear
cabecera
echo ""
echo "$cdamp3_MSG5 wavamp3 $rutamp3"
wavamp3 $rutamp3

}

# wavaogg
# Comprime ficheros .wav en .ogg

wavaogg(){

if test -z $1 || ! test -d $1;then
echo $wavaogg_MSG1
read rutawav
else
	rutawav=$*
fi

if test -d $rutawav;then
	
	cabecera

	for i in $rutawav/*.[Ww][Aa][Vv];do

		cancionwav=$i
		nombreogg=`basename "$cancionwav" .wav`.ogg
		cancionogg="$( echo "$rutawav/$nombreogg" | sed -e 's/[ ]/_/g' -e 's/[	]/_/g')"
		

		echo -e "${C_AV}$wavaogg_MSG2 $cancionwav $wavaogg_MSG3 ${COLOR_DEL_INTERFAZ}"
		echo "$wavaogg_MSG4 oggenc $cancionwav -o $cancionogg"

		
		
		if oggenc $cancionwav -o $cancionogg;then
			echo -e "${C_OK} $cancionogg OK${COLOR_DEL_INTERFAZ}"
			echo ""
		else
			echo -e "${C_FA} $wavaogg_MSG5 $cancionwav $wavaogg_MSG6 ${COLOR_DEL_INTERFAZ}"
		fi
		
	done
fi

echo ""
rm -f $rutawav/*.inf $rutawav/*.[Ww][Aa][Vv]
teclash

}

# cdaogg
# Ripea un CD de Audio a ficheros .ogg

cdaogg(){

mkdir ${D_TMP}/lcdgrabaudio

clear
cabecera

echo $cdaogg_MSG1
echo "$cdaogg_MSG2 cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ "

if cdda2wav dev=$LECTOR_CDROM auxdevice=$IDE speed=$Velocidad -stereo -max -B $D_TMP/lcdgrabaudio/ ;then
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $cdaogg_MSG3 9 50
	else
		echo -e "${C_OK} $cdaogg_MSG3 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
	rutaogg="$D_TMP/lcdgrabaudio"
else
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $cdaogg_MSG4 9 50
	else
		echo -e "${C_FA} $cdaogg_MSG4 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		teclash
	fi
fi

cabecera
echo "$cdaogg_MSG5 wavaogg $rutaogg"
wavaogg $rutaogg

}

