#########################################################
# lcgdrabAPP_API/lcdgrabAPP-SYS.sh
# Funciones de notificacion para el Interfaz de Usuario.
# Funciones comunes al Interfaz de Usuario.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabAPP_API_idiom/lcdgrabAPP-SYS.idiom

# colores_interfaz
# muestra en pantalla los colores elegidos para el
# interfaz y borra la pantalla.

colores_interfaz(){
echo -e " ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ} "
clear
}

# cabecera
# cabecera de menu del programa.

cabecera(){
colores_interfaz
printf "=================================================\n"
printf "=\t\tLINUX-CDGRAB 0.5\t\t=\n"
printf "=\t\t----------------\t\t=\n"
printf "=================================================\n"

}

# m_cdrecord-sin-overburn
# Mensaje Ejecucion de cdrecord sin -overburn

m_cdrecord-sin-overburn(){

echo ""
echo $m_cdrecord_sin_overburn_MSG1
echo $m_cdrecord_sin_overburn_MSG2
echo $m_cdrecord_sin_overburn_MSG3
echo ""

}

# estas funciones informan sobre errores de grabacion y creacion de imagenes.
# se replican para que funcionen sin el comando dialog. (versiones text_*)
# El uso de estas funciones requiere que la 
# variable este informada como UD=0

# Opcion_invalida
# Muestra el mensaje de elección erronea en un menu

Opcion_invalida(){

dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$Opcion_invalida_D_MSG1" 9 50
colores_interfaz

}

# img_error

img_error(){

dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$img_error_D_MSG1" 9 50
colores_interfaz

}

# CD_error

CD_error(){

dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$CD_error_D_MSG1" 9 50
colores_interfaz

}

# DVD_error

DVD_error(){

dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$DVD_error_D_MSG1" 9 50
colores_interfaz

}

# DO_error

DO_error(){

dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$DO_error_D_MSG1" 9 50
colores_interfaz

}

# tecla
# espera la pulsacion de una tecla

tecla(){

dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$tecla_D_MSG1" 10 95
colores_interfaz

}

# rutas_dir
# pide rutas de directorios al usuario

rutas_dir(){

dir="z"

until `test $dir = "f" `;do
clear

dialog --title "$rutas_dir_D_MSG1" --backtitle "LINUX-CDGRAB 0.5" --inputbox "$rutas_dir_D_MSG2" 8 60 2> $D_LINUXCDGRAB/lcdgrabnombreruta.$$

dir=`cat $D_LINUXCDGRAB/lcdgrabnombreruta.$$`

if ! test $dir = "f";then
	
	if test -d $dir;then

		if ! test -f $HOME/rutas_lcdgrab.txt;then

			echo $dir > $HOME/rutas_lcdgrab.txt
		else
			echo $dir >> $HOME/rutas_lcdgrab.txt
		fi
		
	else
		dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$rutas_dir_D_MSG3 $dir $rutas_dir_D_MSG4" 10 25
		colores_interfaz

	fi
fi
rm -f $dir
done

rm -f $D_LINUXCDGRAB/lcdgrabnombreruta.*

}

# una_sola_grabadora

# Comprueba que en la máquina solo existe una unidad física instalada,
# en este caso hará una pausa para poder cambiar el CD o DVD de la unidad.
# Ordenadores con una sola grabadora.

una_sola_grabadora(){

if test $IDE == $LECTOR_CDROM;then
	eject $IDE
	dialog --title $una_sola_grabadora_D_MSG1 --backtitle "LINUX-CDGRAB 0.5" --msgbox "$una_sola_grabadora_D_MSG2" 15 90
	colores_interfaz
fi

}

# grabacion_ok

grabacion_ok(){

dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox "$grabacion_ok_D_MSG1" 9 50
colores_interfaz

}

#
# Replica de funciones en texto.
# Por compatibilidad en sistemas sin dialog.
# El uso de estas funciones requiere que la 
# variable este informada como UD=1
#

# text_Opcion_invalida
# Muestra el mensaje de elección erronea en un menu

text_Opcion_invalida(){

echo $text_Opcion_invalida_MSG1

}

# text grabacion_ok
# Muestra el mensaje de grabacion finalizada correctamente

text_grabacion_ok(){

echo -e "${C_OK}	$grabacion_ok_D_MSG1 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

}

# text_img_error

text_img_error(){

echo -e "${C_FA} $text_img_error_MSG1 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

}

# text_CD_error

text_CD_error(){

echo -e "${C_FA} $text_CD_error_MSG1 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

}

# text_DVD_error

text_DVD_error(){

echo -e "${C_FA} $text_DVD_error_MSG1 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

}

# text_DO_error

text_DO_error(){

echo -e "${C_FA} $text_DO_error_MSG1 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

}

# teclash
# espera la pulsacion de una tecla, modo texto.

teclash(){

	echo $teclash_MSG1
	read xxxx
	colores_interfaz

}

# text_rutas_dir
# rutas_dir version texto.
# pide rutas de directorios al usuario

text_rutas_dir(){

dir=""

until [ $dir = "f" ];do
clear
echo $text_rutas_dir_MSG1
echo ""

read dir

if ! test $dir = "f";then
	
	if test -d $dir;then

		if ! test -f $HOME/rutas_lcdgrab.txt;then

			echo $dir > $HOME/rutas_lcdgrab.txt
		else
			echo $dir >> $HOME/rutas_lcdgrab.txt
		fi
	else
		echo $text_rutas_dir_MSG2 $dir $text_rutas_dir_MSG3
		sleep 1
	fi
fi

done

}

# text_una_sola_grabadora
# una_sola_grabadora version texto.

text_una_sola_grabadora(){
cabecera
if test $IDE == $LECTOR_CDROM;then
echo -e "${C_AV}"
echo $text_una_sola_grabadora_MSG1
echo "---------------------------------"
echo $text_una_sola_grabadora_MSG2
echo $text_una_sola_grabadora_MSG3
echo $text_una_sola_grabadora_MSG4
echo $text_una_sola_grabadora_MSG5
echo $text_una_sola_grabadora_MSG6
echo $text_una_sola_grabadora_MSG7
echo -e "${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
fi
eject $IDE
teclash
}

### Fin declaracion de funciones de texto.

# logo
# imprime el logo

logo(){
colores_interfaz
clear
more $D_LINUXCDGRAB/logo.txt
echo ""
read xx

}

# selecciona_interfaz_de_notificacion
#
# Selecciona el modo en que se dan 
# notificaciones al usuario.
# Mediante dialog o echo

selecciona_interfaz_de_notificacion(){

PGM="dialog"

if which $PGM &> /dev/null ;then

	#se usa dialog

	UD=0
else
	#se usa echo
	UD=1
fi

export UD

}

# colores_por_defecto
# Carga los colores de la aplicacion por defecto en caso de que $D_LINUXCDGRAB/lcdgrabAPP_API/colores.dat no exista

colores_por_defecto(){

export COLOR_DEL_INTERFAZ=${B_BLANCO} # B_BLANCO
export FONDO_INTERFAZ=${FONDO_AZUL} # FONDO_AZUL
export C_OK=${B_VERDE} # B_VERDE
export C_FA=${B_ROJO} # B_ROJO
export C_AV=${B_NEGRO} # B_NEGRO
export C_ET=${B_MAGENTA} # B_MAGENTA 


}

# ImprimirProgreso
# Imprime una barra de progreso del proceso en ejecución.
# Funcion invocada de la siguiente manera:
# proceso_en_ejecucion & ImprimirProgreso

ImprimirProgreso(){

local pid=$!
local delay=0.75
local spinstr='|/-\'

while [ "$(ps a | awk '{print $1}' | grep $pid)" ];do

    local temp=${spinstr#?}
    
    printf "%c" "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b"
    
done


}

