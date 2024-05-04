			
			
LINUX - CDGRAB ver 1.0
=================

LINUX-CDGRAB es un front-end para grabar discos ópticos (CD, DVD y BD)

La aplicación utiliza las herramientas de grabación cdrtools, libburnia, cdrdao y dvd+-rw-tools para estas funciones.

Permite también la creación de imágenes de CD y DVD junto con conversión de ficheros de audio y video, compresión de archivos o bien el montado de unidades o imágenes de disco, entre otras opciones. Su interfaz es multilenguaje.

La aplicación es un conjunto de scripts de shell que actúan como un interfaz de menús interactivos, bien en texto o gráficos, encargados de llamar a las diferentes herramientas de grabación junto a otras diversas existentes en nuestra instalación, para llevar a cabo las funciones de grabación de discos ópticos, creación de imágenes, montaje de unidades e imágenes, operaciones sobre dispositivos de bloque, conversión de audio y video... etc.

Diseñado únicamente para el sistema operativo GNU/Linux y shell Bash.
Puede ejecutarse en otras versiones de UNIX e incluso en implementaciones como Cygwin o WSL de Windows, pero no se ha tenido en cuenta la compatibilidad con otro UNIX que no sea Linux. V_1.0 final -> 04/05/2024

Requisitos:
-------------
Las herramientas de grabación cdrtools (acepta cdrkit), cdrdao
y dvd+-rw-tools. También acepta libburnia.
Compresores de archivo zip, xz, gzip, bzip2.
Conversores de sonido lame, oggenc, sox y flac.
Conversor de video ffmpeg.
Dispositivos /dev/loop para montar imagenes de CD/DVD/BD.
Formateadores de disco: mke2fs, mkfs.ext3, mkfs.ext4, mkfs.xfs,
mkfs.jfs, mkfs.btrfs, mkfs.ntfs, mkfs.vfat y mkexfatfs.
Utilidades estandares de Linux como tar, grep, dd, mke2fs, cat etc.

Instalación:
--------------
Descargar directamente el paquete desde esta web o bien clonar el repositorio mediante la siguiente orden:

git clone https://github.com/Pascual-lingr/linux-cdgrab

Descomprima el programa ejecutando:

tar -xvzf lingrXY.tgz ( X e Y corresponden a la versión del programa )

Dentro del directorio de archivos de linux-cdgrab tecleé ./instalar

Licencia:
----------
Distribuir la aplicación bajo licencia GPL v2 (www.gnu.org).
Escrito por Pascual Martínez Cruz (pascual89@hotmail.com).
Gracias por usar linux-cdgrab


