#########################################################
# lcgdrabMenu_API/lcdgrabUIGestorArchivos.sh
# Implementa un simple gestor de archivos para la
# aplicacion.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

############## Gestor de archivos ################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUIGestorArchivos.idiom

# ayuda_gestor_de_archivos
# Muestra la ayuda del gestor de archivos

ayuda_gestor_de_archivos(){

cat << EOF
$ayuda_gestor_de_archivos_MSG1
$ayuda_gestor_de_archivos_MSG2
$ayuda_gestor_de_archivos_MSG3
$ayuda_gestor_de_archivos_MSG4
$ayuda_gestor_de_archivos_MSG5

$ayuda_gestor_de_archivos_MSG6
$ayuda_gestor_de_archivos_MSG7
$ayuda_gestor_de_archivos_MSG8
$ayuda_gestor_de_archivos_MSG9
$ayuda_gestor_de_archivos_MSG10

$ayuda_gestor_de_archivos_MSG11
$ayuda_gestor_de_archivos_MSG12
$ayuda_gestor_de_archivos_MSG13
$ayuda_gestor_de_archivos_MSG14
$ayuda_gestor_de_archivos_MSG15
$ayuda_gestor_de_archivos_MSG16
EOF

}

# gestor_de_archivos

# Se prescinde del comando mc.
# Funcion para navegar por el sistema de archivos

gestor_de_archivos(){

while $verdadero;do
clear
cabecera
directorio=`pwd`

if ! test -z $MSG &> /dev/null;then
	echo $MSG
fi

echo "$gestor_de_archivos_MSG0 $directorio"
echo "$gestor_de_archivos_MSG0B $directorio"
echo ""
ls -a
echo ""
echo $gestor_de_archivos_MSG1
echo $gestor_de_archivos_MSG2
echo $gestor_de_archivos_MSG3

echo $gestor_de_archivos_MSG4
read accion
case $accion in

'X')	break ;;

'H')
	clear
	cabecera
	ayuda_gestor_de_archivos
	teclash
;;

'A')	
	cd ..
;;

'B')
	echo $gestor_de_archivos_MSG5
	read directorio
	cd $directorio
	continue
;;

'C')
	echo $gestor_de_archivos_MSG6
	read forig
	echo $gestor_de_archivos_MSG7
	read fdest

	if cp -f $forig $fdest;then
		if test -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG8 9 50
		else
			echo -e "${C_OK} $gestor_de_archivos_MSG8 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		fi

	else
		if test -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG9 9 50
		else
			echo -e "${C_FA} $gestor_de_archivos_MSG9 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		fi

	fi

	teclash

;;

'M')
	echo $gestor_de_archivos_MSG10
	read forig
	echo $gestor_de_archivos_MSG11
	read fdest

	if mv -f $forig $fdest;then
		if test -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG12 9 50
		else
			echo -e "${C_OK} $gestor_de_archivos_MSG12 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		fi

	else
		if test -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG13 9 50
		else
			echo -e "${C_FA} $gestor_de_archivos_MSG13 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
		fi

	fi

;;

'CD')
	echo $gestor_de_archivos_MSG14
	read dorig
	echo $gestor_de_archivos_MSG15
	read ddest

	if cp -rf $dorig $ddest;then
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG16 9 50
		else
			echo -e "${C_OK} $gestor_de_archivos_MSG16 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi

	else
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG17 9 50
		else
			echo -e "${C_FA} $gestor_de_archivos_MSG17 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi


	fi

;;

'MD')
	echo $gestor_de_archivos_MSG18
	read dorig
	echo $gestor_de_archivos_MSG19
	read ddest

	if cp -rf $dorig $ddest;then
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG20 9 50
		else
			echo -e "${C_OK} $gestor_de_archivos_MSG20 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi


	else
		if test $UD -eq 0;then
			dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $gestor_de_archivos_MSG21 9 50
		else
			echo -e "${C_FA} $gestor_de_archivos_MSG21 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
			teclash
		fi
	fi

;;

'Z')

	if test $UD -eq 0;then

		dialog --title $gestor_de_archivos_MSG22 --backtitle "LINUX-CDGRAB 05" --inputbox "\n$gestor_de_archivos_MSG23" 8 60 2> $D_LINUXCDGRAB/lcdgrab_fichero_a_comprimir$$

		imagen=`cat $D_LINUXCDGRAB/lcdgrab_fichero_a_comprimir$$`
		colores_interfaz
	else
		echo "$gestor_de_archivos_MSG23:"
		read imagen
	fi

	comprime $imagen
	rm -f $D_LINUXCDGRAB/lcdgrab_fichero_a_comprimir$$ &> /dev/null
;;

'DZ')

	descomprime
;;

'EZ')
	empaquetar
;;

'DEZ')
	desempaquetar
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
colores_interfaz
done


}

