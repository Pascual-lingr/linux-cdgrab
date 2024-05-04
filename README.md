			
			
LINUX - CDGRAB 1.0
==================

LINUX-CDGRAB es un front-end para grabar discos ópticos (CD, DVD y BD)

La aplicación utiliza las herramientas de grabación cdrtools, libburnia, cdrdao y dvd+-rw-tools para estas funciones.

Permite también la creación de imágenes de CD y DVD junto con conversión de ficheros de audio y video, compresión de archivos o bien el montado de unidades o imágenes de disco, entre otras opciones. Su interfaz es multilenguaje.

La aplicación es un conjunto de scripts de shell que actúan como un interfaz de menús interactivos, bien en texto o gráficos, encargados de llamar a las diferentes herramientas de grabación junto a otras diversas existentes en nuestra instalación, para llevar a cabo las funciones de grabación de discos ópticos, creación de imágenes, montaje de unidades e imágenes, operaciones sobre dispositivos de bloque, conversión de audio y video... etc.

Diseñado únicamente para el sistema operativo GNU/Linux y shell Bash.
Puede ejecutarse en otras versiones de UNIX e incluso en implementaciones como Cygwin o WSL de Windows, pero no se ha tenido en cuenta la compatibilidad con otro UNIX que no sea Linux. V_1.0 final -> 04/05/2024

Linux-cdgrab realiza las siguientes operaciones:

 -Copia de CD o DVD de datos ISO-9660.
 
 -Grabación de CD, DVD y BD de datos ISO-9660 o UDF 
  desde archivos del disco duro.
  
 -Grabación de CD de datos ISO-9660 Multisesión.
 
 -Grabación de imagenes .ext2 en CD y DVD.
 
 -Grabación de imagenes ISO-9660 en CD, DVD y BD.
 
 -Grabación de imagenes bin cue en CD.
 
 -Copia de CD-Audio.
 
 -Grabación de CD-Audio desde ficheros wav, mp3, ogg y flac.
 
 -Borrado de CD-RW.
 
 -Cierre de CDs de datos abiertos.
 
 -Diversos formatos sobre discos DVD+RW y DVD-RW.
 
 -Grabación de DVD-Video (DVD 9).
 
 -Crea imágenes de datos ISO-9660, UDF, ext2 y bin cue.
 
 -Crea imágenes de datos ext3, ext4, XFS, JFS y Btrfs.
  Grabación no funcional en discos ópticos.
  
 -Genera archivos de descripción .cue desde imagen .bin .
 
 -Monta unidades de disco e imágenes ISO-9660, UDF, ext2,
  ext3, ext4, XFS, JFS, Btrfs.
  
  -Genera y escribe imagenes .img, usar sobre dispositivos
   de bloque. No funcional en discos ópticos.
   
  -Convierte imágenes .nrg de Nero Burning ROM en ISO-9660.
  
  -Muestra información de discos CD y DVD existentes en la unidad.
  
  -Formatea dispositivos de bloque en ext2, ext3, ext4,
   XFS, JFS, Btrfs, NTFS, vfat (FAT32) y exFAT.
   
  -Tratamiento sobre archivos comprimidos, formatos zip, gzip, bz2 y xz.
  
  -Extracción de CD-Audio a diferentes formatos. Soportados .wav, .mp3, .ogg y .flac .
  
  -Convierte archivos de audio. Soportados .wav, .mp3, .ogg y .flac .
  
  -Convierte archivos de video. Soportados mpeg, mkv, flv, mp4, etc.
  
  -Mezcla archivos de video con archivos de audio.
  
  -Extrae audio mp3 de un archivo de video.
  
  -Recorta fragmentos de video.
  
  -Graba una sesión de escritorio de usuario en video.
  
  -Vuelca imagenes .iso/.img autoarrancables (bootable) sobre pendrive o disco.

La aplicación soporta los siguientes tipos de CD:
 - CD-Audio (Libro Rojo)
 - CD-ROM CD-ROM XA (Libro Amarillo)
 - CD-R CD-RW (Libro Naranja)

Tipos de discos DVD soportados:
 - DVD+R/RW DVD-R/RW DVD+RW DL

Tipos de discos BD soportados:
 - BD-R/RE

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
Distribuir bajo licencia GPL v2.

Desarrollo:
-----------
Pascual Martínez Cruz.
pascual89@hotmail.com

