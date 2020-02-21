#########################################################
# lcgdrabMenu_API/lcdgrabUIAUDIO.sh
# Menu de Interfaz para la conversion de Audio.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

####################### CONVERSION DE AUDIO ####################################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUIAUDIO.idiom

# menu_conversion_audio

menu_conversion_audio(){

while $verdadero;do

clear
cabecera
printf "\t\t$menu_conversion_audio_MSG1\n"
printf "=================================================\n"
printf "\n"
echo -e "${C_ET}$menu_conversion_audio_MSG2${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
printf "1.- $menu_conversion_audio_MSG3\n"
printf "2.- $menu_conversion_audio_MSG4\n"
printf "3.- $menu_conversion_audio_MSG5\n"
printf "4.- $menu_conversion_audio_MSG6\n"
echo -e "${C_ET}$menu_conversion_audio_MSG7${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
printf "5.- $menu_conversion_audio_MSG8\n"
printf "6.- $menu_conversion_audio_MSG9\n"
printf "7.- $menu_conversion_audio_MSG10\n"
printf "8.- $menu_conversion_audio_MSG11\n\n"
printf "0.- $menu_conversion_audio_MSG0\n"
read opca

case $opca in

	1)	
		MSG=$menu_conversion_audio_MSG12
		gestor_de_archivos $MSG
		mp3awav
		colores_interfaz
	;;

	2)
		
		MSG=$menu_conversion_audio_MSG13		
		gestor_de_archivos
		oggawav
		colores_interfaz
	;;

	3)	
		MSG=$menu_conversion_audio_MSG14	
		gestor_de_archivos
		wavamp3
		colores_interfaz
	;;

	4)
		MSG=$menu_conversion_audio_MSG14		
		gestor_de_archivos
		wavaogg
		colores_interfaz
	;;

	5)	
		cdawav
		colores_interfaz
	;;

	6)
		cddawav
		teclash
	;;

	7)
		cdamp3
	;;

	8)
		cdaogg
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

