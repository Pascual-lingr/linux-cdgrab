#########################################################
# lcgdrabCMD_API/lcdgrabExpulsaCDDVD-API.sh
# Implementa la expulsion del disco insertado en la
# unidad.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de linux-cdgrab 0.5
#########################################################

# Expande el archivo de idioma

source $D_LINUXCDGRAB/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabExpulsaCDDVD-API.idiom

# expulsar_medio
# Expulsa el disco de un dispositivo de bloque

expulsar_medio(){

if ! test -z $*;then
	UNIDAD_OPTICA=$*
else
	UNIDAD_OPTICA=$LECTOR_CDROM
fi

if eject $UNIDAD_OPTICA || eject -vrsfq;then
	echo $expulsar_medio_MSG1
	sleep 1
else
			
	clear
	echo ""
	echo -e "${C_FA}$expulsar_medio_MSG2 $CDROM${COLOR_DEL_INTERFAZ}"
	echo -n $expulsar_medio_MSG3
	read UNIDAD_OPTICA

		`eject -vrsfq $UNIDAD_OPTICA`
fi

clear

colores_interfaz

}


