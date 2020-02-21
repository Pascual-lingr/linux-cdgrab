#                                LINUX-CDGRAB

lcdgrab(1)                  General Commands Manual                 lcdgrab(1)

NAME
       lcdgrab – LINUX-CDGRAB –
       Front-end para la grabación de discos ópticos CD y DVD.

SYNOPSIS
       lcdgrab

       lcdgrab [opciones]

OPTIONS
       Se permiten los siguientes argumentos en la llamada a lcdgrab:

       lcdgrab
       [-v]|[-h]|[-G=dispositivo][-V=numero][-L=dispositivo][-CA=dispositivo]

       -h  --help , Imprime una breve ayuda de sobre la sintaxis de llamada.

       -v  --version , Imprime la versión de Linux-cdgrab

       -G  --grabadora , especifica el canal IDE o  dispositivo  de  grabación
       -G=0,1,0 o -G=/dev/hdd

       -V  --velocidad , especifica la velocidad de grabación -V=32

       -L  --lector , especifica el lector de CD-ROM o DVD-ROM -L=/dev/cdrom

       -CA  --canal-atapi  ,  especifica  el  canal  IDE ATAPI de la grabadora
       -CA=0,0,0 o -CA=1,0,0

       Las opciones -G -V -L y -CA se implican entre sí.  Las opciones -h y -v
       son independientes entre sí y el resto.

EXAMPLES
       Ejecución con argumentos: lcdgrab -G=0,1,0 -L=/dev/hdc -V=16 -CA=0,1,0

       Ejecución      con     argumentos:     lcdgrab     --grabadora=/dev/hdd
       --lector=/dev/cdrom --velocidad=32 --canal-atapi=1,0,0

       Por cada ejecución del comando con estos argumentos, sera  generado  un
       nuevo archivo de configuración.

       Muestra la ayuda de comandos: lcdgrab --help

       Imprime la versión: lcdgrab --version

DESCRIPTION
       LINUX-CDGRAB es un front-end en modo consola
       para grabar discos ópticos (CD,DVD)
       La aplicación utiliza las herramientas de
       grabación cdrtools,cdrdao y dvd+-rw-tools
       para estas funciones.
       Permite también la creación de imagenes
       de CD y DVD, junto con conversión de
       ficheros de audio, compresión de archivos
       o bien el montado de unidades o imágenes
       de disco. Se realizan otras operaciones
       sobre dispositivos de bloque.
       Requisitos:
       Las herramientas de grabación cdrtools
       (acepta cdrkit), cdrdao y dvd+-rw-tools.
       Compresores de archivo zip, xz, gzip, bzip2.
       Conversores de sonido lame, oggenc y sox.
       Dispositivos /dev/loop para montar
       imágenes de CD/DVD.
       Compresores gzip, bzip2 y xz, empaquetador tar.
       Formateador mke2fs.
       Otras utilidades estándares de Linux.

       Instalación:
       ------------
       Descomprima el programa ejecutando:

       tar -xvzf lingrXY.tgz ( X e Y corresponden a la versión del programa )

       Dentro del directorio de archivos de linux-cdgrab teclee ./instalar

       Referencias al manejo interactivo del interfaz:
       -----------------------------------------------

       1.- Ejecute lcdgrab bajo la linea de comandos;
           No se implementa ninguna gestión de permisos
           de usuario. Los permisos de escritura sobre
           los directorios usados en la aplicación, así
           como los permisos de ejecución sobre las
           diferentes herramientas usadas deberán ser
           gestionados por el usuario root sobre el resto
           de usuarios existentes en el sistema.

       2.- Las diferentes opciones del interfaz se encuentran numeradas
           o bien seleccionables por combinación de letras mayusculas.
           Teclear el numero de opción o combinación mayuscula de teclas
           para navegar por el interfaz;

       3.- Configuración del programa;

           El programa usara un fichero de configuración generado
           a partir de los valores con los que se hizo la llamada
           a este, y usara este fichero durante su ejecución.

           Si el programa es lanzado sin argumentos y el fichero de
           configuración no existe en el sistema, el interfaz de configuración
           de linux-cdgrab permitira la configuración manual de la aplicación.

           Los datos que pedira el interfaz de configuración
           seran los siguientes:

            1.- Velocidad de grabación ;

            Basta con teclear el numero , por ejemplo 16.
            No se acepta ningun valor de velocidad máxima.

            2.- Canal IDE de la grabadora ;

            El canal donde esta conectada la grabadora.
            Si no lo sabe ejecute la siguiente orden : cdrecord -scanbus

            Un ejemplo sobre valores del canal IDE son : 0,0,0 o 0,1,0

               Puede especificar tambien en este caso el dispositivo
               de bloque que corresponde con su grabadora bien /dev/hdd,
               /dev/hde etc,en lugar del canal IDE.
               Segun su versión de cdrecord debe optar por un valor u otro.

            NOTA: Parametrización errónea de la variable $IDE
            Una parametrización incorrecta de la variable $IDE provocará que
               en  los procesos de grabación cdrecord no pueda abrir el driver
       SCSI.
            Si se da este comportamiento en la aplicación deberá borrase el
            archivo actual de configuración y configurar de nuevo el programa.

            3.- Unidad lectora de CD-ROM/DVD-ROM

            Especificar el dispositivo de bloques que el sistema asigne
            a esta unidad.

            4.- Canal Atapi.

            Valor usado por cdrecord en las grabaciones de CDs de datos
            iso multisesión.
            Es la referencia a nuestro dispositivo de grabación asignado
            por cdrecord al hacer un escaneo del canal ATAPI.
            Especificar un valor de tipo 0,0,0 o bien 1,1,0 etc.

       4.- Modo de depuración ;

           El modo de depuración solo sirve para detectar errores de ejecución
           en linux-cdgrab.
           Si desea depurar el script escriba dep desde el menu principal.
           Si desea depurar un parche para linux-cdgrab escriba deppatch
           en el menu principal.

       5.- Logotipo ASCII ;

           Escribir logo en el menu principal para mostrar el logotipo ASCII.

       Linux-cdgrab realiza las siguientes operaciones:

       -Copia de CD o DVD de datos ISO-9660
       -Grabación de CD o DVD de datos ISO-9660 desde
        archivos del disco duro.
       -Grabacion de CD o DVD de datos ISO-9660 Multisesión.
       -Grabación de imagenes ISO-9660 o ext2 en CD y DVD
       -Grabación de imagenes bin cue en CD.
       -Copia de CD-Audio
       -Grabación de CD-Audio desde ficheros wav, mp3 u ogg
       -Borrado de CD-RW
       -Cierre de CDs de datos abiertos
       -Diversos formatos sobre discos DVD+RW Y DVD-RW
       -Grabación de DVD-Video
       -Crea imagenes de datos ISO-9660, ext2 y bin cue
       -Genera archivos de descripcion .cue desde imagen .bin
       -Monta unidades de disco e imagenes ISO-9660 y ext2
       -Genera y escribe imagenes .img, Usar sobre dispositivos
        de bloque. No funcional en discos ópticos.
       -Convierte imagenes .nrg de Nero Burning ROM en ISO-9660
       -Muestra información de discos CD y DVD existentes en la unidad.
       -Formatea dispositivos de bloque con ext2.
       -Tratamiento sobre archivos comprimidos, formatos zip, gzip, bz2 y xz
       -Ripero de CD-Audio a diferentes formatos. Soportados .wav, .mp3 y .ogg
       -Convierte archivos de audio. Soportados .wav, .mp3 y .ogg

       La aplicación soporta los siguientes tipos de CD:
       CD-Audio (Libro Rojo)
       CD-ROM CD-ROM XA (Libro Amarillo)
       CD-R CD-RW (Libro Naranja)
       Tipos de discos DVD soportados:
       DVD+R/RW DVD-R/RW DVD+RW DL
       DVD-RAM no probado aunque soportado por growisofs.

       Implementar un idioma para LINUX-CDGRAB
       ---------------------------------------

       Bajo el directorio lcdgrabAPI_idiom se almacenan
       los archivos de idioma del programa, distribuidos
       en subdirectorios nombrados con el idioma parametrizado.
       Se recomienda usar los archivos de idioma Español.
       Al ser su lengua original de documentación y desarrollo.
       Copiar el directorio Español con el nombre de idioma
       deseado bajo lcdgrabAPI_idiom.

       Traducir los mensajes contenidos en los ficheros *.idiom
       al idioma deseado.
       Se trata de ficheros de texto, usar el editor deseado.
       Editar el archivo Descriptionlcdgrablang.txt con la
       información del nuevo idioma.

       Linux-cdgrab usara el idioma contenido en el directorio
       ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/.defecidiom como
       idioma por defecto si los datos de definición de idioma
       estan corruptos en la instalación.
       Por defecto este directorio incluye los archivos del
       idioma Español. Aunque podrá usarse otro idioma si se desea
       sustituyendo estos mismos archivos por los del idioma
       deseado.

       Implementar un parche para LINUX-CDGRAB
       ---------------------------------------

       Linux-cdgrab ejecutará un fichero .sh externo
       al diseño de la aplicación, mediante la opción número 8
       de su menú principal.

       Conceptualmente estos ficheros serán considerados como
       modulos funcionales o parches de la aplicación, y permitirán
       que el programa use distintas funcionalidades durante
       su ejecución a las incluidas en el programa principal.
       El fichero .sh a ejecutar debera estar almacenado en el
       directorio parches de la instalación del programa.

       El fichero .sh ejecutado podra hacer uso de las variables
       exportadas al entorno por linux-cdgrab.
       Si se desea parametrizar algun idioma para un parche,
       el fichero .idiom correspondiente deberá almacenarse
       bajo el directorio lcdgrabparches_idiom del idioma usado.

FILES
       El fichero de configuración usado es /etc/lcdgrab.cfg
       /Programs/linux-cdgrab-0.5/lcdgrab.cfg sera usado
       bajo la distribución GoboLinux.
       La aplicación referencia la ruta del fichero de configuración
       según el valor almacenado en la variable de entorno $D_CFG
       El fichero de definición de colores es lcdgrabAPP_API/colores.dat
       El directorio de la instalación $D_LINUXCDGRAB contiene
       los diferentes ficheros .txt de documentación del programa.

ENVIRONMENT
       D_LINUXCDGRAB Directorio de instalación usado por la aplicación.
       D_PARCHES Directorio de instalación de parches usado por la aplicación.
       D_MNT Directorio usado como punto de montaje por la aplicación.
       MNT Directorio usado como punto de montaje por el sistema.
       D_TMP Directorio de archivos temporales.
       Las distintas imagenes de disco generadas por la aplicación
       se guardan en este directorio.
       D_CFG Directorio del archivo de configuración.
       D_BIN Directorio de ejecutables del sistema.
       UD Utilizada para mostrar  el  sistema  de  nofificaciones  de  fin  de
       proceso al usuario.
       Si su valor es 0, notifica con el comando dialog, si su valor
       es 1, notifica con mensajes en texto.
       Velocidad Velocidad utilizada en los procesos de grabación.
       IDE Dispositivo que corresponde con nuestra grabadora.
       Acepta valores como 0,0,0 0,1,0 o bien el nombre del dispositivo
       de bloque asignado a nuestra grabadora.
       Ejemplos /dev/dvdrw, /dev/hdc etc.
       LECTOR_CDROM Dispositivo que corresponde con la unidad lectora.
       CANALATAPI Dispositivo asignado por cdrecord como dev=ATAPI
       correspondiente con nuestra granadora.
       Necesario en grabaciones de CD multisesión.
       NIVEL_ISO Modo iso en el que sera generada una imagen.
       mkisofs acepta los n¡veles 1,2,3 y 4.
       El nivel 4 no es oficial, consultar la página man de mkisofs.
       grabadora_dvd Grabadora de DVD usada para las dvd+-rw-tools si existe.
       En este caso IDE tiene un valor del tipo X.Y.Z
       IDIOM Idioma usado en el interfaz de la aplicación.
       colores.dat
       Se exporta al entorno el conjunto de variables de color definidas
       en el archivo colores.dat
       Para usar un color de fondo es necesario
       usar colores de fuente brillante.
       En caso contrario, el color de fondo usado sera el estándar.
       C_OK Color de fuente para los procesos terminados con éxito.
       C_FA Color de fuente para los procesos terminados con error.
       C_ET  Color  de  fuente  para los mensajes de etiqueta existentes en el
       menú.
       C_AV Color de fuente para los mensajes de aviso existentes en el menú.
       COLOR_DEL_INTERFAZ Color de fuente usado en el interfaz.
       FONDO_INTERFAZ Color de fondo usado en el interfaz.
       utiliso Si su valor es 0, genera imagenes iso desde CD mediante dd
       Si su valor es 1, genera imagenes iso desde CD mediante readcd
       Usado en la opción de copia de CD de datos con imagen previa.

BUGS
        Es posible que en diversas distribuciones de Linux el montaje
        automático de unidades no permita a la aplicación funcionar
        corréctamente a la hora de realizar procesos de grabación de discos
        o montaje de dispositivos de bloque.
        (el script monta los dispositivos de forma tradicional con el
        comando mount).
        En los procesos de grabación el montaje automático de unidades
        interferirá con la ejecución de cdrecord, haciendo que éste no pueda
        acceder al dispositivo IDE/SCSI. Si se observa este comportamiento
        en la aplicación, deberá desmontarse la unidad correspondiente a la
        grabadora usando el comando umount o bien desde el própio programa.
        Realizada esta acción, la grabación de discos y el montaje de
        dispositivos de bloque debería realizarse sin ningún problema por
        parte del sistema.

AUTOR
       Escrito por Pascual Martínez Cruz
       pascual89@hotmail.com

COPYRIGHT
       Licenciado bajo GPL v2.
       Visite www.gnu.org para mas información.

                                                                    lcdgrab(1)
