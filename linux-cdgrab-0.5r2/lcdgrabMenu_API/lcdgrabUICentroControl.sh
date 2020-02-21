#########################################################
# lcgdrabMenu_API/lcdgrabUICentroControl.sh
# Menu de Interfaz para configurar la aplicacion.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

############################## CENTRO DE CONTROL ###############################
################################################################################

# expande el fichero de idioma

source $D_LINUXCDGRAB/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUICentroControl.idiom

# cab_config
# Cabecera para el asistente de configuracion de Linux-cdgrab

cab_config(){

	printf "=================================\n"
	printf "= $cab_config_MSG1 =\n"
	printf "=================================\n"

}

# ayuda_IDE
# Imprime la ayuda de la configuracion de $IDE

ayuda_IDE(){

cat << EOF

$ayuda_IDE_MSG1
$ayuda_IDE_MSG2

$ayuda_IDE_MSG3

$ayuda_IDE_MSG4
$ayuda_IDE_MSG5
$ayuda_IDE_MSG6

$ayuda_IDE_MSG7

$ayuda_IDE_MSG8
$ayuda_IDE_MSG9

$ayuda_IDE_MSG10
$ayuda_IDE_MSG11

EOF

}

# desinstalar
# desinstala el programa

desinstalar(){

rm -rf $D_LINUXCDGRAB
umount $D_MNT 2> /dev/null
rm -rf $D_MNT

if test -x $D_BIN/lcdgrab10;then
	rm -f $D_BIN/lcdgrab10
fi

if test -f $D_CFG/lcdgrab.cfg;then
	rm -f $D_CFG/lcdgrab.cfg
fi

if test -f $HOME/rutas_lcdgrab.txt;then
	rm -f $HOME/rutas_lcdgrab.txt
fi

rm -f `whereis lcdgrab.1.gz`

echo $desinstalar_MSG1
echo ""
sleep 2

}

# imprimir_variables
# Imprime los valores por pantalla de Velocidad, IDE, LECTOR_CDROM, CANALATAPI y UD.

imprimir_variables(){

echo "$imprimir_variables_MSG1 = $Velocidad"
echo "$imprimir_variables_MSG2 = $IDE"
echo "$imprimir_variables_MSG3 = $LECTOR_CDROM"
echo "$imprimir_variables_MSG4 = $CANALATAPI"
echo ""

}

# imprimir_lcdgrabcfg
# Imprime los valores del archivo de configuracion

imprimir_lcdgrabcfg(){

print_Velocidad="$( cat $D_CFG/lcdgrab.cfg | grep -e 'VELOCIDAD.' | sed -e 's/VELOCIDAD//g' -e 's/ //g' -e 's/[=]//g')"

print_IDE="$( cat $D_CFG/lcdgrab.cfg | grep -e 'IDE.' | sed -e 's/IDE//g' -e 's/ //g' -e 's/[=]//g')"

print_LECTOR_CDROM="$( cat $D_CFG/lcdgrab.cfg | grep -e 'LECTOR_CDROM.' | sed -e 's/LECTOR_CDROM//g' -e 's/ //g' -e 's/[=]//g')"

print_CANALATAPI="$( cat $D_CFG/lcdgrab.cfg | grep -e 'CANALATAPI.' | sed -e 's/CANALATAPI//g' -e 's/ //g' -e 's/[=]//g')"

echo "$imprimir_lcdgrabcfg_MSG1 = $print_Velocidad"
echo "$imprimir_lcdgrabcfg_MSG2 = $print_IDE"
echo "$imprimir_lcdgrabcfg_MSG3 = $print_LECTOR_CDROM"
echo "$imprimir_lcdgrabcfg_MSG4 = $print_CANALATAPI"

}

# chequeo_de_aplicaciones
# chequea los programas que necesita el script
# pasarle el parametro programa

chequeo_de_aplicaciones(){

SI="${C_OK} $chequeo_de_aplicaciones_MSG1 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
NO="${C_FA} $chequeo_de_aplicaciones_MSG2 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
disc=0

for programa in $*;do

	if which $programa &> /dev/null ;then

		#lo encuentra

		echo -e " $programa ------> $SI ---> $( which ${programa} )"
	else
		echo -e " $programa ------> $NO ---> $chequeo_de_aplicaciones_MSG3 ${programa} "
		let disc++
	fi

done

if test $disc -ne 0;then

	echo -e "${C_FA}"
	echo $chequeo_de_aplicaciones_MSG4
	echo $chequeo_de_aplicaciones_MSG5
	echo -e "${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
else
	echo -e "${C_AV}$chequeo_de_aplicaciones_MSG6${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

fi

read XXXX

colores_interfaz

}

# leer_lcdgrabcfg
# Lee los parametros del archivo de configuracion

leer_lcdgrabcfg(){

export Velocidad="$( cat $D_CFG/lcdgrab.cfg | grep -e 'VELOCIDAD.' | sed -e 's/VELOCIDAD//g' -e 's/ //g' -e 's/[=]//g')"

export IDE="$( cat $D_CFG/lcdgrab.cfg | grep -e 'IDE.' | sed -e 's/IDE//g' -e 's/ //g' -e 's/[=]//g')"

export LECTOR_CDROM="$( cat $D_CFG/lcdgrab.cfg | grep -e 'LECTOR_CDROM.' | sed -e 's/LECTOR_CDROM//g' -e 's/ //g' -e 's/[=]//g')"

export CANALATAPI="$( cat $D_CFG/lcdgrab.cfg | grep -e 'CANALATAPI.' | sed -e 's/CANALATAPI//g' -e 's/ //g' -e 's/[=]//g')"

}

# msgdefCANALATAPI
# Informa el dispositivo por defecto 0,0,0 para el CANAL ATAPI
# en caso de error de escaneo. Este dispositivo es usado en
# la grabacion de CD Multisesion con cdrecord.

msgdefCANALATAPI(){

echo $msgdefCANALATAPI_MSG1
echo $msgdefCANALATAPI_MSG2
CANALATAPI="0,0,0"
teclash

}

# nuevo_lcdgrabcfg
# Crea un nuevo archivo de configuracion

# Acepta $Velocidad,$IDE y $LECTOR_CDROM como argumentos

nuevo_lcdgrabcfg(){

errcdrecord=0

if test $# -eq 4;then
	
        # si se pasan argumentos a la funcion crea /etc/lcdgrab.cfg con los valores pasados

	VAR_DESCRIPCION=$nuevo_lcdgrabcfg_MSG1
	VAR_VELOCIDAD="$nuevo_lcdgrabcfg_MSG2 = $Velocidad"
	VAR_IDE="IDE = $IDE"
	VAR_LECTOR_CDROM="$nuevo_lcdgrabcfg_MSG3 = $LECTOR_CDROM"
	VAR_CANALATAPI="$nuevo_lcdgrabcfg_MSG4 = $CANALATAPI"

	echo $VAR_DESCRIPCION > $D_CFG/lcdgrab.cfg
	echo $VAR_VELOCIDAD >> $D_CFG/lcdgrab.cfg
	echo $VAR_IDE >> $D_CFG/lcdgrab.cfg
	echo $VAR_LECTOR_CDROM >> $D_CFG/lcdgrab.cfg
	echo $VAR_CANALATAPI >> $D_CFG/lcdgrab.cfg	

else
	clear
	cab_config
	if ! which cdrecord &> /dev/null ;then
		echo -e "${C_FA}$nuevo_lcdgrabcfg_MSG5${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo $nuevo_lcdgrabcfg_MSG6
		echo $nuevo_lcdgrabcfg_MSG7
		echo $nuevo_lcdgrabcfg_MSG8
		echo $nuevo_lcdgrabcfg_MSG9
		echo $nuevo_lcdgrabcfg_MSG10
		echo $nuevo_lcdgrabcfg_MSG11
		echo $nuevo_lcdgrabcfg_MSG12
		errcdrecord=1
		teclash
	fi
	export Velocidad=""
	export IDE=""
	export LECTOR_CDROM=""
	export CANALATAPI=""
	printf "$nuevo_lcdgrabcfg_MSG13...\n"
	printf "\n"

	# Obtiene la velocidad de grabacion

	if test -z $Velocidad;then
	
		while test -z $Velocidad &> /dev/null || ! expr $(expr $Velocidad % 2) = 0 &> /dev/null ;do
			printf "$nuevo_lcdgrabcfg_MSG14.\n"
			printf "$nuevo_lcdgrabcfg_MSG15 :\n$nuevo_lcdgrabcfg_MSG16 \n"
			read Velocidad
		done
		
	fi
	
	# Obtiene el canal IDE/SCSI o dispositivo de grabacion
	
	clear
	cab_config
	
	if test -z $IDE;then
		
		while $verdadero;do
			printf "$nuevo_lcdgrabcfg_MSG17.\n"
			printf "$nuevo_lcdgrabcfg_MSG18 :\n$nuevo_lcdgrabcfg_MSG19\n"
			read IDE
		
				case $IDE in

					a|A)
						clear
						ayuda_IDE
						teclash
						continue
					;;
			
					t)
						echo $nuevo_lcdgrabcfg_MSG20
						sleep 0.5
						if cdrecord -scanbus && cdrecord dev=ATAPI -scanbus;then
							echo -e "${C_OK}$nuevo_lcdgrabcfg_MSG27${COLOR_DEL_INTERFAZ}"
						else
							echo -e "${C_FA}$nuevo_lcdgrabcfg_MSG33${COLOR_DEL_INTERFAZ}"
							if test $errcdrecord -eq 1;then
								echo -e "${C_FA}$nuevo_lcdgrabcfg_MSG22${COLOR_DEL_INTERFAZ}"
							fi
						fi

						echo ""
						teclash
						continue
					;;
					
					d)

						clear
						more /etc/fstab
						echo ""
						teclash
					;;
					
					l)
						clear
						cabecera
						ls /dev
						teclash
					;;
					
					$(test -z $IDE))
						continue
					;;

					/dev*)
						break
					;;

					$(echo $IDE | grep -e '.,.,.'))

						break
					;;
				esac
		done
	fi

	# Obtiene el lector de CD-ROM o DVD-ROM

	clear
	cab_config

	if test -z $LECTOR_CDROM;then

		while test -z $LECTOR_CDROM || ! test -b $LECTOR_CDROM;do
			printf "$nuevo_lcdgrabcfg_MSG23.\n"
			printf "$nuevo_lcdgrabcfg_MSG24 :\n$nuevo_lcdgrabcfg_MSG25\n"
			read LECTOR_CDROM
			if [ $LECTOR_CDROM = "L" ] &> /dev/null;then

				clear
				cabecera
				ls /dev
				teclash
			fi
		done
	fi

	# Obtiene el canal IDE ATAPI donde esta conectada la grabadora

	clear
	cab_config

	if test -z $CANALATAPI;then
		clear
		cabecera
		echo $nuevo_lcdgrabcfg_MSG20
		sleep 0.5
		if cdrecord dev=ATAPI -scanbus;then
			echo -e "${C_OK}$nuevo_lcdgrabcfg_MSG27${COLOR_DEL_INTERFAZ}"
			echo $nuevo_lcdgrabcfg_MSG28
			echo $nuevo_lcdgrabcfg_MSG30
			echo -n $nuevo_lcdgrabcfg_MSG31
			read CANALATAPI

			$(echo $CANALATAPI | grep -e ".,.,." > /dev/null)

			if test $? != 0;then
				echo $nuevo_lcdgrabcfg_MSG32
				msgdefCANALATAPI
			fi

		else
			echo -e "${C_FA}$nuevo_lcdgrabcfg_MSG33${COLOR_DEL_INTERFAZ}"

			if test $errcdrecord -eq 1;then
				echo -e "${C_FA}$nuevo_lcdgrabcfg_MSG22${COLOR_DEL_INTERFAZ}"
				msgdefCANALATAPI
			fi
		fi

	fi

# crea /etc/lcdgrab.cfg con los valores recogidos

VAR_DESCRIPCION=$nuevo_lcdgrabcfg_MSG36
VAR_VELOCIDAD="VELOCIDAD = $Velocidad"
VAR_IDE="IDE = $IDE"
VAR_LECTOR_CDROM="LECTOR_CDROM = $LECTOR_CDROM"
VAR_CANALATAPI="CANALATAPI = $CANALATAPI"

echo $VAR_DESCRIPCION > $D_CFG/lcdgrab.cfg
echo $VAR_VELOCIDAD >> $D_CFG/lcdgrab.cfg
echo $VAR_IDE >> $D_CFG/lcdgrab.cfg
echo $VAR_LECTOR_CDROM >> $D_CFG/lcdgrab.cfg
echo $VAR_CANALATAPI >> $D_CFG/lcdgrab.cfg

echo -e "${C_OK} $nuevo_lcdgrabcfg_MSG37 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
sleep 2

fi

}

########## Funciones para cambiar el color en el interfaz de Linux-cdgrab. ################

# COLOR_DEL_INTERFAZ --> COLOR DE FUENTE PARA EL INTERFAZ
# FONDO_INTERFAZ --> COLOR DE FONDO PARA EL INTERFAZ
# C_AV --> COLOR FUENTE DE AVISO
# C_ET --> COLOR FUENTE DE ETIQUETA
# C_OK --> COLOR FUENTE OK
# C_FA --> COLOR FUENTE FALLO

# colores
# cambia los colores de linux-cdgrab de forma interactiva

colores(){

clear
cabecera

if ! test -e $D_LINUXCDGRAB/lcdgrabAPP_API/colores.dat;then
	echo "$colores_MSG1 $D_LINUXCDGRAB/colores.dat"
	echo $colores_MSG2
	colores_por_defecto
else

num_COLOR_DEL_INTERFAZ=""
num_FONDO_INTERFAZ=""
num_C_AV=""
num_C_ET=""
num_C_OK=""
num_C_FA=""

echo $colores_MSG3
echo "-----------------------------------------------------------------"
echo -e "${NEGRO} 1- $colores_MSG4 X ${COLOR_DEL_INTERFAZ}${STANDAR} 2.- $colores_MSG5 X ${COLOR_DE_INTERFAZ}${FONDO_NEGRO} 3.- $colores_MSG6 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}${FONDO_INTERFAZ}"
echo -e "${ROJO} 4.- $colores_MSG7 X ${COLOR_DEL_INTERFAZ}${B_NEGRO} 5.- $colores_MSG8 X ${COLOR_DE_INTERFAZ}${FONDO_ROJO} 6.- $colores_MSG9 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}"
echo -e "${VERDE} 7.- $colores_MSG10 X ${COLOR_DEL_INTERFAZ}${B_ROJO} 8.- $colores_MSG11 X ${COLOR_DE_INTERFAZ}${FONDO_VERDE} 9.-$colores_MSG12 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}"
echo -e "${AMARILLO} 10.- $colores_MSG13 X ${COLOR_DEL_INTERFAZ}${B_VERDE} 11.- $colores_MSG14 X ${COLOR_DE_INTERFAZ}${FONDO_NARANJA} 12.- $colores_MSG15 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}"
echo -e "${AZUL} 13.- $colores_MSG16 X ${COLOR_DEL_INTERFAZ}${B_AMARILLO} 14.- $colores_MSG17 X ${COLOR_DE_INTERFAZ}${FONDO_AZUL} 15.- $colores_MSG18 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}"
echo -e "${MAGENTA} 16.- $colores_MSG19 X ${COLOR_DEL_INTERFAZ}${B_AZUL} 17.- $colores_MSG20 X ${COLOR_DE_INTERFAZ}${FONDO_MAGENTA} 18.- $colores_MSG21 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}"
echo -e "${CIAN} 19.- $colores_MSG22 X ${COLOR_DEL_INTERFAZ}${B_MAGENTA} 20.- $colores_MSG23 X ${COLOR_DE_INTERFAZ}${FONDO_CIAN} 21.- $colores_MSG24 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}"
echo -e "${GRIS} 22.- $colores_MSG25 X ${COLOR_DEL_INTERFAZ}${B_CIAN} 23.- $colores_MSG27 X ${COLOR_DE_INTERFAZ}${FONDO_GRIS} 24.- $colores_MSG28 ${COLOR_DEL_INTERFAZ} $FONDO_NEGRO"
echo -e "${DEFECTO} 25.- $colores_MSG29 X ${COLOR_DEL_INTERFAZ}${B_BLANCO} 26.- $colores_MSG30 X ${COLOR_DE_INTERFAZ}${FONDO_DEFECTO} 27.- $colores_MSG31 ${COLOR_DEL_INTERFAZ} ${FONDO_NEGRO}"

while test  -z $num_COLOR_DEL_INTERFAZ;do
	echo ""
	echo $colores_MSG32

	read num_COLOR_DEL_INTERFAZ

	case $num_COLOR_DEL_INTERFAZ in

		1)  COLOR_DEL_INTERFAZ=${NEGRO} ;;
		2)  COLOR_DEL_INTERFAZ=${STANDAR} ;;
		4)  COLOR_DEL_INTERFAZ=${ROJO} ;;
		5)  COLOR_DEL_INTERFAZ=${B_NEGRO} ;;
		7)  COLOR_DEL_INTERFAZ=${VERDE} ;;
		8)  COLOR_DEL_INTERFAZ=${B_ROJO} ;;
		10) COLOR_DEL_INTERFAZ=${AMARILLO} ;;
		11) COLOR_DEL_INTERFAZ=${B_VERDE} ;;
		13) COLOR_DEL_INTERFAZ=${AZUL} ;;
		14) COLOR_DEL_INTERFAZ=${B_AMARILLO} ;;
		16) COLOR_DEL_INTERFAZ=${MAGENTA} ;;
		17) COLOR_DEL_INTERFAZ=${B_AZUL} ;;
		19) COLOR_DEL_INTERFAZ=${CIAN} ;;
		20) COLOR_DEL_INTERFAZ=${B_MAGENTA} ;;
		22) COLOR_DEL_INTERFAZ=${GRIS} ;;
		23) COLOR_DEL_INTERFAZ=${B_CIAN} ;;
		25) COLOR_DEL_INTERFAZ=${DEFECTO} ;;
		26) COLOR_DEL_INTERFAZ=${B_BLANCO} ;;

esac

done

while test  -z $num_FONDO_INTERFAZ;do
	echo $colores_MSG33
	read num_FONDO_INTERFAZ

	case $num_FONDO_INTERFAZ in

		3) FONDO_INTERFAZ=${FONDO_NEGRO} ;;
		6) FONDO_INTERFAZ=${FONDO_ROJO} ;;
		9) FONDO_INTERFAZ=${FONDO_VERDE} ;;
		12) FONDO_INTERFAZ=${FONDO_NARANJA} ;;
		15) FONDO_INTERFAZ=${FONDO_AZUL} ;;
		18) FONDO_INTERFAZ=${FONDO_MAGENTA} ;;
		21) FONDO_INTERFAZ=${FONDO_CIAN} ;;
		24) FONDO_INTERFAZ=${FONDO_GRIS} ;;
		27) FONDO_INTERFAZ=${FONDO_DEFECTO} ;;
	esac

done


while test  -z $num_C_AV;do
	echo $colores_MSG34
	read num_C_AV
	case $num_C_AV in

		1) C_AV=${NEGRO} ;;
		2) C_AV=${STANDAR} ;;
		4) C_AV=${ROJO} ;;
		5) C_AV=${B_NEGRO} ;;
		7) C_AV=${VERDE} ;;
		8) C_AV=${B_ROJO} ;;
		10) C_AV=${AMARILLO} ;;
		11) C_AV=${B_VERDE} ;;
		13) C_AV=${AZUL} ;;
		14) C_AV=${MAGENTA} ;;
		17) C_AV=${B_AZUL} ;;
		19) C_AV=${CIAN} ;;
		20) C_AV=${B_MAGENTA} ;;
		22) C_AV=${GRIS} ;;
		23) C_AV=${B_CIAN} ;;
		25) C_AV=${DEFECTO} ;;
		26) C_AV=${B_BLANCO} ;;

	esac

done



while test  -z $num_C_ET;do
	echo $colores_MSG35
	read num_C_ET

	case $num_C_ET in

		1) C_ET=${NEGRO} ;;
		2) C_ET=${STANDAR} ;;
		4) C_ET=${ROJO} ;;
		5) C_ET=${B_NEGRO} ;;
		7) C_ET=${VERDE} ;;
		8) C_ET=${B_ROJO} ;;
		10) C_ET=${AMARILLO} ;;
		11) C_ET=${B_VERDE} ;;
		13) C_ET=${AZUL} ;;
		14) C_ET=${B_AMARILLO} ;;
		16) C_ET=${MAGENTA} ;;
		17) C_ET=${B_AZUL} ;;
		19) C_ET=${CIAN} ;;
		20) C_ET=${B_MAGENTA} ;;
		22) C_ET=${GRIS} ;;
		23) C_ET=${B_CIAN} ;;
		26) C_ET=${B_BLANCO} ;;

	esac

done



while test  -z $num_C_OK;do
	echo $colores_MSG36
	read num_C_OK
	case $num_C_OK in

		1) C_OK=${NEGRO} ;;
		2) C_OK=${STANDAR} ;;
		4) C_OK=${ROJO} ;;
		5) C_OK=${B_NEGRO} ;;
		7) C_OK=${VERDE} ;;
		8) C_OK=${B_ROJO} ;;
		10) C_OK=${AMARILLO} ;;
		11) C_OK=${B_VERDE} ;;
		13) C_OK=${AZUL} ;;
		14) C_OK=${B_AMARILLO} ;;
		16) C_OK=${MAGENTA} ;;
		17) C_OK=${B_AZUL} ;;
		19) C_OK=${CIAN} ;;
		20) C_OK=${B_MAGENTA} ;;
		22) C_OK=${GRIS} ;;
		23) C_OK=${B_CIAN} ;;
		25) C_OK=${DEFECTO} ;;
		26) C_OK=${B_BLANCO} ;;

	esac
done



while test  -z $num_C_FA;do
	echo $colores_MSG37
	read num_C_FA
	case $num_C_FA in

		1) C_FA=${NEGRO} ;;
		2) C_FA=${ROJO} ;;
		5) C_FA=${B_NEGRO} ;;
		7) C_FA=${VERDE} ;;
		8) C_FA=${B_ROJO} ;;
		10) C_FA=${AMARILLO} ;;
		11) C_FA=${B_VERDE} ;;
		13) C_FA=${AZUL} ;;
		14) C_FA=${B_AMARILLO} ;;
		16) C_FA=${MAGENTA} ;;
		17) C_FA=${B_AZUL} ;;
		19) C_FA=${CIAN} ;;
		20) C_FA=${B_MAGENTA} ;;
		22) C_FA=${GRIS} ;;
		23) C_FA=${B_CIAN} ;;
		25) C_FA=${DEFECTO} ;;
		26) C_FA=${B_BLANCO} ;;

	esac
done

fi

export COLOR_DEL_INTERFAZ
export FONDO_INTERFAZ
export C_ET
export C_AV
export C_OK
export C_FA

echo $colores_MSG38
echo -e " ${COLOR_DEL_INTERFAZ} $colores_MSG39 ${COLOR_DEL_INTERFAZ}"
echo -e " ${C_ET} $colores_MSG40 ${COLOR_DEL_INTERFAZ}"
echo -e " ${C_AV} $colores_MSG41 ${COLOR_DEL_INTERFAZ}"
echo -e " ${C_OK} $colores_MSG42 ${COLOR_DEL_INTERFAZ}"
echo -e " ${C_FA} $colores_MSG43 ${COLOR_DEL_INTERFAZ}"
echo -e " ${FONDO_INTERFAZ} $colores_MSG44 ${FONDO_INTERFAZ} ${COLOR_DEL_INTERFAZ}"
colores_interfaz
sleep 1

}

# cambiar_esquema_de_color
# Cambia el esquema de colores de Linux-cdgrab

cambiar_esquema_de_color(){
		clear
		echo -e "${FONDO_NEGRO}"
		clear
		echo -e "${FONDO_NEGRO}"
		cabecera
		echo $cambiar_esquema_de_color_MSG1
		echo $cambiar_esquema_de_color_MSG3
		echo $cambiar_esquema_de_color_MSG2
		echo $cambiar_esquema_de_color_MSG3
		echo -e "1.- ${FONDO_NEGRO}${AZUL}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${VERDE} OK${COLOR_DEL_INTERFAZ}${ROJO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}${AMARILLO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${MAGENTA} $cambiar_esquema_de_color_MSG6 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}"
		echo -e "2.- ${FONDO_NEGRO}${ROJO}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${AMARILLO} OK${COLOR_DEL_INTERFAZ}${MAGENTA} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}${VERDE} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${BLANCO} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}"
		echo -e "3.- ${FONDO_GRIS}${B_BLANCO}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_VERDE} OK${COLOR_DEL_INTERFAZ}${B_AMARILLO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_GRIS}${B_BLANCO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_ROJO} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "4.- ${FONDO_CIAN}${B_AZUL}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_VERDE} OK${COLOR_DEL_INTERFAZ}${B_ROJO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_CIAN}${B_NEGRO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_BLANCO} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "5.- ${FONDO_NARANJA}${B_NEGRO}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_AZUL} OK${COLOR_DEL_INTERFAZ}${B_BLANCO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NARANJA}${B_AMARILLO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_VERDE} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "6.- ${FONDO_NEGRO}${MAGENTA}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${AMARILLO} OK${COLOR_DEL_INTERFAZ}${VERDE} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}${AMARILLO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${AZUL} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "7.- ${FONDO_ROJO}${B_NEGRO}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_CIAN} OK${COLOR_DEL_INTERFAZ}${B_BLANCO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}${B_VERDE} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_AZUL} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "8.- ${FONDO_NEGRO}${VERDE}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${CIAN} OK${COLOR_DEL_INTERFAZ}${ROJO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}${MAGENTA} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${AMARILLO} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "9.- ${FONDO_NEGRO}${B_CIAN}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_VERDE} OK${COLOR_DEL_INTERFAZ}${B_ROJO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}${B_AZUL} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_MAGENTA} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "10.- ${FONDO_VERDE}${B_AMARILLO}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_CIAN} OK${COLOR_DEL_INTERFAZ}${B_ROJO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_VERDE}${B_BLANCO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_AZUL} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "11.- ${FONDO_NEGRO}${B_AMARILLO}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_VERDE} OK${COLOR_DEL_INTERFAZ}${B_ROJO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_NEGRO}${B_BLANCO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_CIAN} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "12.- ${FONDO_MAGENTA}${B_AZUL}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_AMARILLO} OK${COLOR_DEL_INTERFAZ}${B_NEGRO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_MAGENTA}${B_VERDE} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_BLANCO} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "13.- ${FONDO_VERDE}${B_CIAN}$cambiar_esquema_de_color_MSG4 ${COLOR_DEL_INTERFAZ}${B_VERDE} OK${COLOR_DEL_INTERFAZ}${B_ROJO} $cambiar_esquema_de_color_MSG5 ${COLOR_DEL_INTERFAZ}${FONDO_VERDE}${B_BLANCO} $cambiar_esquema_de_color_MSG6b${COLOR_DEL_INTERFAZ}${B_AMARILLO} $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo -e "0.- ${STANDAR}$cambiar_esquema_de_color_MSG4 $cambiar_esquema_de_color_MSG5 $cambiar_esquema_de_color_MSG6b $cambiar_esquema_de_color_MSG6${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
		echo ""
		echo -n $cambiar_esquema_de_color_MSG
	
		read n_color

		case $n_color in

		
			# COLOR_DEL_INTERFAZ --> COLOR DE FUENTE PARA EL INTERFAZ
			# FONDO_INTERFAZ --> COLOR DE FONDO PARA EL INTERFAZ
			# C_AV --> COLOR FUENTE DE AVISO
			# C_ET --> COLOR FUENTE DE ETIQUETA
			# C_OK --> COLOR FUENTE OK
			# C_FA --> COLOR FUENTE FALLO

		1)

			COLOR_DEL_INTERFAZ=${AZUL}
			FONDO_INTERFAZ=${FONDO_NEGRO}
			C_OK=${VERDE}
			C_FA=${ROJO}
			C_AV=${AMARILLO}
			C_ET=${MAGENTA}
		;;


		2)
			COLOR_DEL_INTERFAZ=${ROJO}
			FONDO_INTERFAZ=${FONDO_NEGRO}
			C_OK=${BLANCO}
			C_FA=${MAGENTA}
			C_AV=${VERDE}
			C_ET=${AMARILLO}
		;;

		3)
			COLOR_DEL_INTERFAZ=${B_BLANCO}
			FONDO_INTERFAZ=${FONDO_GRIS}
			C_OK=${B_VERDE}
			C_FA=${B_AMARILLO}
			C_AV=${B_ROJO}
			C_ET=${B_CIAN}
		;;

		4)
			COLOR_DEL_INTERFAZ=${B_AZUL}
			FONDO_INTERFAZ=${FONDO_CIAN}
			C_OK=${B_VERDE}
			C_FA=${B_ROJO}
			C_AV=${B_AMARILLO}
			C_ET=${B_BLANCO}
		;;

		5)
			COLOR_DEL_INTERFAZ=${B_NEGRO}
			FONDO_INTERFAZ=${FONDO_NARANJA}
			C_OK=${B_AZUL}
			C_FA=${B_BLANCO}
			C_AV=${B_AMARILLO}
			C_ET=${B_VERDE}
		;;

		6)
			COLOR_DEL_INTERFAZ=${MAGENTA}
			FONDO_INTERFAZ=${FONDO_NEGRO}
			C_OK=${AMARILLO}
			C_FA=${VERDE}
			C_AV=${AMARILLO}
			C_ET=${AZUL}
		;;

		7)
					
			COLOR_DEL_INTERFAZ=${B_NEGRO}
			FONDO_INTERFAZ=${FONDO_ROJO}
			C_OK=${B_CIAN}
			C_FA=${B_BLANCO}
			C_AV=${B_VERDE}
			C_ET=${B_AZUL}
		;;

		8)
					
			COLOR_DEL_INTERFAZ=${VERDE}
			FONDO_INTERFAZ=${FONDO_NEGRO}
			C_OK=${CIAN}
			C_FA=${ROJO}
			C_AV=${MAGENTA}
			C_ET=${AMARILLO}
		;;

		9)
			COLOR_DEL_INTERFAZ=${B_CIAN}
			FONDO_INTERFAZ=${FONDO_NEGRO}
			C_OK=${B_VERDE}
			C_FA=${B_ROJO}
			C_AV=${B_AZUL}
			C_ET=${B_MAGENTA}
		;;

		10)

			COLOR_DEL_INTERFAZ=${B_AMARILLO}
			FONDO_INTERFAZ=${FONDO_VERDE}
			C_OK=${B_CIAN}
			C_FA=${B_ROJO}
			C_AV=${B_BLANCO}
			C_ET=${B_AZUL}

		;;

		11)

			COLOR_DEL_INTERFAZ=${B_AMARILLO}
			FONDO_INTERFAZ=${FONDO_NEGRO}
			C_OK=${B_VERDE}
			C_FA=${B_ROJO}
			C_AV=${B_BLANCO}
			C_ET=${B_CIAN}

		;;

		12)

			COLOR_DEL_INTERFAZ=${B_AZUL}
			FONDO_INTERFAZ=${FONDO_MAGENTA}
			C_OK=${B_AMARILLO}
			C_FA=${B_NEGRO}
			C_AV=${B_VERDE}
			C_ET=${B_BLANCO}

		;;

		13)

			COLOR_DEL_INTERFAZ=${B_CIAN}
			FONDO_INTERFAZ=${FONDO_VERDE}
			C_OK=${B_VERDE}
			C_FA=${B_ROJO}
			C_AV=${B_BLANCO}
			C_ET=${B_AMARILLO}

		;;

		0)
					
			COLOR_DEL_INTERFAZ=${STANDAR}
			FONDO_INTERFAZ=${STANDAR}
			C_OK=${STANDAR}
			C_FA=${STANDAR}
			C_AV=${STANDAR}
			C_ET=${STANDAR}
		;;

		*)	

			clear
			echo $cambiar_esquema_de_color_MSG9
			echo $cambiar_esquema_de_color_MSG10
			echo ""
			echo $cambiar_esquema_de_color_MSG11
			echo $cambiar_esquema_de_color_MSG12
			echo $cambiar_esquema_de_color_MSG13
			echo $cambiar_esquema_de_color_MSG14
			echo $cambiar_esquema_de_color_MSG15
			echo $cambiar_esquema_de_color_MSG16
			sleep 1
			colores_por_defecto
		;;
	
		esac

		export COLOR_DEL_INTERFAZ
		export FONDO_INTERFAZ
		colores_interfaz
}

# cambia_lector
# cambia el dispositivo de la variable LECTOR_CDROM
# cambia el dispositivo de la variable IDE
# cambia el dispositivo de la variable CANALATAPI

# reimplementada

cambia_lector(){
clear
cabecera
echo $cambia_lector_MSG1
more /etc/fstab
echo ""
echo "1.- $cambia_lector_MSG2 : $LECTOR_CDROM"
echo "2.- $cambia_lector_MSG3 : $IDE"
echo "3.- $cambia_lector_MSG4 : $CANALATAPI"
echo -e "${C_ET}		$cambia_lector_MSG5 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo $cambia_lector_MSG6
echo $cambia_lector_MSG7

read opc_nuevo_dispositivo


case $opc_nuevo_dispositivo in

1)	# El lector de cdrom o dvd

	echo $cambia_lector_MSG8
	read nuevo_dispositivo

	if ! test -b $nuevo_dispositivo;then
				
		echo -e "${C_FA} $nuevo_dispositivo $cambia_lector_MSG9 ${COLOR_DEL_INTERFAZ}"

	elif test -z $nuevo_dispositivo;then
		
		if test -b /dev/cdrom;then
			LECTOR_CDROM=/dev/cdrom
		elif test -b /dev/dvd;then
			LECTOR_CDROM=/dev/dvd
		fi

		echo "$cambia_lector_MSG10 ${LECTOR_CDROM} $cambia_lector_MSG11"
		echo ""
			
	else
		LECTOR_CDROM=$nuevo_dispositivo
		echo "$cambia_lector_MSG12 $LECTOR_CDROM"
	fi
	
;;

2)	# La grabadora

	echo $cambia_lector_MSG8
	read nuevo_dispositivo

	if ! test -b $nuevo_dispositivo;then
				
		echo -e "${C_FA} $nuevo_dispositivo $cambia_lector_MSG9 ${COLOR_DEL_INTERFAZ}"

	elif test -z $nuevo_dispositivo;then
		
		if test -b /dev/cdrw;then
			IDE=/dev/cdrw
			echo "$cambia_lector_MSG10 ${IDE} $cambia_lector_MSG11"
		fi
			
	else
		IDE=$nuevo_dispositivo
		echo "$cambia_lector_MSG12 $IDE"
	fi

	echo -e "${C_AV} $cambia_lector_MSG13 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
	
;;

3)	# Dispositivo ATAPI para asignar a dev=ATAPI

	echo $cambia_lector_MSG14
	read nuevo_dispositivo

	$(echo $nuevo_dispositivo | grep -e ".,.,." > /dev/null)

	if test $? != 0;then
		echo $cambia_lector_MSG15
		echo $cambia_lector_MSG16
		echo $cambia_lector_MSG17
		CANALATAPI="0,0,0"
		teclash			
	else
		CANALATAPI=$nuevo_dispositivo

	fi

	echo "$cambia_lector_MSG18 $CANALATAPI"	

;;

*)
	clear
	cabecera
	echo $cambia_lector_MSG19
	sleep 0.5
;;


esac


}

# cambia_generador_isocd
# Selecciona la herramienta para
# generar imagenes iso de CD.

cambia_generador_isocd(){

while $verdadedo;do
	clear
	cabecera
	echo $cambia_generador_isocd_MSG1
	echo $cambia_generador_isocd_MSG2
	echo $cambia_generador_isocd_MSG3
	echo ""
	echo "$cambia_generador_isocd_MSG4 $utiliso"
	echo ""
	echo "1.- $cambia_generador_isocd_MSG5"
	echo "2.- $cambia_generador_isocd_MSG6"
	echo ""
	echo "0.- $cambia_generador_isocd_MSG7"
	echo ""
	echo $cambia_generador_isocd_MSG8
	
	read mutiliso

	case $mutiliso in

	1)
		export utiliso=1
		echo $cambia_generador_isocd_MSG9
		sleep 1
		break
	;;

	2)
		export utiliso=2
		echo $cambia_generador_isocd_MSG10
		sleep 1
		break
	;;

	0)
		break
	;;

	*)
		text_Opcion_invalida
		sleep 1
	;;

	esac

done

}

# cambia_notificaciones
# Permite cambiar el sistema de
# notificacion de procesos en la aplicacion

cambia_notificaciones(){

while $verdadedo;do
	clear
	cabecera
	echo "$cambia_notificaciones_MSG1 = $UD"
	echo ""
	echo "0 -- $cambia_notificaciones_MSG2"
	echo "1 -- $cambia_notificaciones_MSG3"
	echo ""
	echo "X -- $cambia_notificaciones_MSG4"
	echo ""
	echo $cambia_notificaciones_MSG5
	
	read mutiliso

	case $mutiliso in

	0)
		if test -x ${D_BIN}/dialog;then
			export UD=0
			echo $cambia_notificaciones_MSG6
		else
			export UD=1
			echo $cambia_notificaciones_MSG7
			echo $cambia_notificaciones_MSG8
		fi

		sleep 1
		break
	;;

	1)
		export UD=1
		echo $cambia_notificaciones_MSG8
		sleep 1
		break
	;;

	X|x)
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

}

# cambiar_idioma_UI
#
# Selecciona el idioma usado
# en el interfaz de la aplicacion.

cambiar_idioma_UI(){

#while $verdadero;do
	clear
	cabecera
	echo $cambiar_idioma_UI_MSG1
	ls ${D_LINUXCDGRAB}/lcdgrabAPI_idiom
	echo $cambiar_idioma_UI_MSG2
	echo $cambiar_idioma_UI_MSG3
	read IDIOM

	
	export IDIOM
	echo $IDIOM > ${D_LINUXCDGRAB}/UIIdiom.idiom
	echo "========================================================"
	more ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/Descriptionlcdgrablang.txt
	echo "========================================================"
	echo "$cambiar_idioma_UI_MSG4 $IDIOM"
	more ${D_LINUXCDGRAB}/UIIdiom.idiom
	teclash

}

########################## CENTRO DE CONTROL #############################
##########################################################################

# centro_de_control
# Configuracion de Linux-cdgrab.

# menu del Centro de control

centro_de_control(){
colores_interfaz
while $verdadero;do
clear
cabecera
printf "\t\t$centro_de_control_MSG1\n"
printf "=================================================\n\n"
echo "1.- $centro_de_control_MSG2"
echo "2.- $centro_de_control_MSG3"
echo "3.- $centro_de_control_MSG4"
echo "4.- $centro_de_control_MSG5"
echo "5.- $centro_de_control_MSG6"
echo "6.- $centro_de_control_MSG7"
echo "7.- $centro_de_control_MSG8"
echo "8.- $centro_de_control_MSG9"
echo "9.- $centro_de_control_MSG10"
echo "10.- $centro_de_control_MSG10b"
echo "11.- $centro_de_control_MSG10c"
echo "12.- $centro_de_control_MSG11"
echo ""
echo "0.- $centro_de_control_MSG20"
echo ""
echo -n "$centro_de_control_MSG12 "
read confop

case $confop in

	1)
		# crea un nuevo fichero de configuracion

		if test -f $D_CFG/lcdgrab.cfg;then
			rm -f $D_CFG/lcdgrab.cfg
		fi

		nuevo_lcdgrabcfg

	;;

	2)
		# borra el fichero de configuracion

		if test -f $D_CFG/lcdgrab.cfg;then
			rm -f $D_CFG/lcdgrab.cfg
		else
			echo -e "	${C_AV} $centro_de_control_MSG13 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			sleep 0.5
		fi
	;;

	3)
		# muestra el fichero de configuracion

		clear
		cabecera
		if test -f $D_CFG/lcdgrab.cfg;then

			imprimir_lcdgrabcfg

		else
			echo -e "	${COLOR_DEL_INTERFAZ} $centro_de_control_MSG14 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"

		fi

		sleep 1
		teclash
	;;

	4)
		clear
		cabecera
		imprimir_variables
		teclash
	;;

	5)

		# Cambia el dispositivo de caracter asociado al CD-ROM o a la grabadora
		# linux-cdgrab usa /dev/cdrom por defecto
		
		cambia_lector
		teclash


	;;

	6)
		# Chequea los programas instalados

		clear
		echo $VERSION
		chequeo_de_aplicaciones $APLICACIONES
	;;
	
	7)
		cabecera
		echo "$centro_de_control_MSG15 ..."
		sleep 0.5
		if cdrecord -scanbus && cdrecord dev=ATAPI -scanbus;then
			echo -e "${C_OK}$centro_de_control_MSG16${COLOR_DEL_INTERFAZ}"
		else
			echo -e "${C_FA}$centro_de_control_MSG17${COLOR_DEL_INTERFAZ}"
		fi
		teclash	
	;;

	8)
		# Cambiar utilidad generadora de iso desde CD

		cambia_generador_isocd
	;;

	9)
		# Cambiar el modo de notificar procesos

		cambia_notificaciones
	;;

	10)
		# cambia el color del interfaz

		while $verdadero;do
			clear
			cabecera
			echo "1.- $centro_de_control_MSG24"
			echo "2.- $centro_de_control_MSG25"
			echo ""
			echo "0.- $centro_de_control_MSG20"
			read color

			case $color in

				1)

					cambiar_esquema_de_color

				;;
	

				2)	
					colores

				;;

				0)

					break
				;;

				*)

					echo $centro_de_control_MSG26
					sleep 0.5
					continue
				;;
			

			esac

		done

	;;

	11)
		# cambia el idioma del interfaz de menus
		
		cambiar_idioma_UI
		
	;;

	12)
		# desinstala el script
		
		export COLOR_DEL_INTERFAZ=${STANDAR}
		desinstalar
		echo -e "${COLOR_DEL_INTERFAZ}"
		clear
		exit
		
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

