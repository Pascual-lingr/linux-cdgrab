#########################################################
# lcgdrabMenu_API/lcdgrabUIUnidadesDisco.sh
# Menu de Interfaz la escritura de datos y formateo
# sobre dispositivos de bloque.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

##################  DISPOSITIVOS DE BLOQUE ######################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUIUnidadesDisco.idiom

# MenuDispositivosBloque

MenuDispositivosBloque(){

while $verdadero;do

	clear
	cabecera
	printf "\t$MenuDispositivosBloque_MSG1\n"
	printf "=================================================\n"
	echo -e "${C_AV} "
	echo "$MenuDispositivosBloque_MSG2" 
	echo "+ $MenuDispositivosBloque_MSG3 "
	echo "+ $MenuDispositivosBloque_MSG4 "
	echo "+ $MenuDispositivosBloque_MSG5"
	echo "+ $MenuDispositivosBloque_MSG6"
	echo "+ $MenuDispositivosBloque_MSG7 "
	echo "+ $MenuDispositivosBloque_MSG8"
	echo "+ $MenuDispositivosBloque_MSG9"
	echo "---------------------------------------------------------"
	echo -e "${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	
	echo -e "${C_ET}$MenuDispositivosBloque_MSG10${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	echo "1.- $MenuDispositivosBloque_MSG11"
	echo "2.- $MenuDispositivosBloque_MSG12"
	echo -e "${C_ET}$MenuDispositivosBloque_MSG13${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	echo "3.- $MenuDispositivosBloque_MSG14"

	echo "0.- $MenuDispositivosBloque_MSG15"
	echo ""
	echo -n "$MenuDispositivosBloque_MSG16 : "
	read opcion
	
	case $opcion in

		1)
		clear
		volcar_imagen
		;;

		2)
		UIFormatearUnidad_linuxfs
		;;

		3)
		imagen_img
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

# UIFormatearUnidad_linuxfs
# Interfaz para el formatear discos duros.

UIFormatearUnidad_linuxfs(){

while $verdadero;do
	clear
	cabecera
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

	case $opcionformatdisco in

		"C" | "c")

			Formateador_linuxfs

		;;

		*)

			break
		;;

	esac
done

}

