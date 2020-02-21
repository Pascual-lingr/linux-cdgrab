#########################################################
# lcgdrabCMD_API/lcdgrabCompresion-API.sh
# Soporte para archivos comprimidos.
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

################ COMPRESION DE ARCHIVOS  ################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabCompresion-API.idiom

# empaquetar
# empaqueta una imagen o directorio

empaquetar(){

echo $empaquetar_MSG1
read ruta
echo $empaquetar_MSG2
echo "1.- $empaquetar_MSG3"
echo "2.- $empaquetar_MSG4"
echo -n $empaquetar_MSG5
read eop

case $eop in
1) 
	echo "$empaquetar_MSG6:tar -cvzf $ruta.tar.gz $ruta"
	tar -cvzf $ruta.tar.gz $ruta
;;

2) 
	echo "$empaquetar_MSG6:tar -cvjf $ruta.tar.bz2 $ruta"
	tar -cvjf $ruta.tar.bz2 $ruta || tar -cvyf ruta.tar.bz2 $ruta
;;

*)
	if test $UD -eq 0;then
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$empaquetar_MSG7" 9 50
	else
		echo $empaquetar_MSG7
		sleep 1
	fi

;;
esac
teclash
colores_interfaz
}

# desempaquetar
# desempaqueta una imagen o directorio

desempaquetar(){

echo $desempaquetar_MSG1
read ruta
if ls $ruta | grep -e ".gz" && expr $? != 2;then

	opciones="-xvzf"

elif ls $ruta | grep -e ".bz2" && expr $? != 2;then

	opciones="-xvjf"

else
	echo ""
	echo ""
	echo -e "${C_FA}"
	echo "$desempaquetar_MSG2 $archivo_comprimido"
	echo ""
	echo "$desempaquetar_MSG3 $archivo_comprimido $desempaquetar_MSG4"
	echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	echo ""
	teclash
	break
fi

echo "$desempaquetar_MSG5:tar $opciones $ruta"

if tar $opciones $ruta;then

		echo -e "	${C_OK}$ruta $desempaquetar_MSG6 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo ""
	
else
		echo -e "${C_FA} $desempaquetar_MSG7 $ruta${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"

fi

teclash
colores_interfaz
}

# comprime
# comprime una imagen

comprime(){

	mensaje=$comprime_MSG1

while $verdadero;do
	clear
	cabecera
	echo "1.- $comprime_MSG2"
	echo "2.- $comprime_MSG3"
	echo "3.- $comprime_MSG4"
	echo ""
	echo "0.- $comprime_MSG5"

	read menu_comprime

	case $menu_comprime in

		1 | 2 | 3)
		echo $mensaje

		if test $menu_comprime -eq 1;then
			compresor=bzip2
		elif test $menu_comprime -eq 2;then
			compresor=gzip
		elif test $menu_comprime -eq 3;then
			compresor="xz -z"
		fi
		
		echo "$comprime_MSG6:$compresor -v $imagen"

		if $compresor -v $imagen;then
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$comprime_MSG7" 9 50
			else
				echo $comprime_MSG7
				teclash
			fi
		else
			echo ""
			echo -e "	${C_FA} $comprime_MSG8 $compresor ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo ""
			teclash
		fi

		;;

		0)
		break
		;;

		*)
			if test $UD -eq 0;then
				dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$comprime_MSG9" 9 50
				continue
			else
				echo $comprime_MSG9
				teclash
			fi
		;;


	esac

done
colores_interfaz
}

# descomprime
# descomprime una imagen

descomprime(){

echo $descomprime_MSG1
echo $descomprime_MSG2
echo ""
read archivo_comprimido

#	solo se descomprime el .gz .bz2 y .zip

#	grep retorna 2 en caso de un error inesperado

if ls $archivo_comprimido | grep -e ".gz" && expr $? != 2;then

	descompresor="gunzip -v"

elif ls $archivo_comprimido | grep -e ".bz2" && expr $? != 2;then

	descompresor="bunzip2 -v"

elif ls $archivo_comprimido | grep -e ".zip" && expr $? != 2;then

	descompresor="unzip"

elif ls $archivo_comprimido | grep -e ".xz" && expr $? != 2;then

	descompresor="xz --decompress"
else
	echo ""
	echo ""
	echo -e "${C_FA}"
	echo "$descomprime_MSG3 $archivo_comprimido"
	echo ""
	echo "$descomprime_MSG4 $archivo_comprimido $descomprime_MSG5"
	echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
	echo ""
	teclash
	break
fi
	echo "$descomprime_MSG6:$descompresor $archivo_comprimido"

	if $descompresor $archivo_comprimido;then
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$archivo_comprimido $descomprime_MSG7" 9 50
		else
			echo "$archivo_comprimido $descomprime_MSG7"
			teclash
		fi

	else
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$descomprime_MSG8" 9 50
		else
			echo $descomprime_MSG8
			teclash
		fi

	fi

colores_interfaz
}

