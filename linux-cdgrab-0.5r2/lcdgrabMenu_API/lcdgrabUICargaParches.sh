#########################################################
# lcgdrabMenu_API/lcdgrabUICargaParches.sh
# Interfaz para la cargar parches de la aplicacion.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

################### CARGA DE PARCHES ####################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUICargaParches.idiom

# cargar_parche
#
# Ejecuta un archivo .sh externo a la aplicacion
# existente en /usr/share/linux-cdgrab/parches

cargar_parche(){

		clear
		cabecera
		echo "$cargar_parche_MSG1"
		echo "------------------------------"

		ls $D_PARCHES/*.sh | more
		echo ""
		echo $cargar_parche_MSG2
		echo $cargar_parche_MSG3
		echo ""
		read parche

		if test -f $D_PARCHES/$parche;then

			 $D_PARCHES/$parche

		else
			echo -e "${C_FA}$cargar_parche_MSG4 : ${COLOR_DEL_INTERFAZ}$parche"
			echo ""
			teclash
		fi

}
