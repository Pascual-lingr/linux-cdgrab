#!/bin/bash

# path de ejecución: /usr/share/linux-cdgrab/parches/lingr10LectorCodigoHash.sh

# lingr10LectorCodigoHash.sh ver 0.1 --> 02/02/2025

# Soporte para la lectura de códigos hash en LINUX-CDGRAB 1.0
# Lee el código hash de un archivo en distintos formatos.
#
# Pascual Martínez Cruz --> pascual89@hotmail.com
# Distribuir bajo la misma licencia que Linux-cdgrab 1.0 (GPL v2)

presskey(){

echo ""
# De lcdgrabAPP-SYS.idiom
echo $teclash_MSG1
#
read xcxcxcx

}

cabeceraHash(){

clear
echo "==----------------------------------=="
echo "=   LINUX-CDGRAB 1.0 HASH CODE FILE  ="
echo "==----------------------------------=="
echo ""

}

#	########################## PROGRAMA PRINCIPAL ##########################
#	

if test -z $D_LINUXCDGRAB;then
	export D_LINUXCDGRAB="/usr/share/linux-cdgrab"
fi

if test -z $IDIOM;then
	export IDIOM=".defecidiom"
fi

# Reutiliza fichero de idioma desde los fuentes de linux-cdgrab-1.0

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabAPP-SYS.idiom || exit $?

if test -z $UD;then
	export UD=1
fi

echo -e ${COLOR_DEL_INTERFAZ}
echo -e ${FONDO_INTERFAZ}

cabeceraHash

echo -n "Iso IMG: "
read archivoiso

echo ""
echo -e "${C_ET}MD5${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
md5sum -t $archivoiso
echo -e "${C_ET}BLAKE2${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
b2sum -t $archivoiso
echo -e "${C_ET}SHA1${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
sha1sum -t $archivoiso
echo -e "${C_ET}SHA224${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
sha224sum -t $archivoiso
echo -e "${C_ET}SHA256${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
sha256sum -t $archivoiso
echo -e "${C_ET}SHA384${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
sha384sum -t $archivoiso
echo -e "${C_ET}SHA512${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
sha512sum -t $archivoiso

echo ""
presskey

