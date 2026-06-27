LINUX-CDGRAB 1.0 debian_cdrkit

Esta aplicación corresponde con una versión no oficial y modificada
de linux-cdgrab-1.0r3 para utilizar solamente el paquete cdrkit 
en grabaciones de CD/DVD y en la creación de imagenes .iso
Incluye también breves variaciones respecto de la versión original.
Compatible con los archivos de idioma y parches de linux-cdgrab 1.0
Motivo:
Aunque linux-cdgrab 1.0 diferencia el uso entre cdrtools y cdrkit,
existen opciones solamente funcionales con el paquete cdrtools.

Requisitos:
-----------
Las herramientas de grabación cdrkit, cdrdao, dvd+-rw-tools y libburnia.
Compresores de archivo zip, xz, gzip, bzip2.
Conversores de sonido lame, oggenc, sox y flac.
Conversor de video ffmpeg.
Dispositivos /dev/loop para montar imagenes de CD/DVD/BD.
Formateadores de disco: mke2fs, mkfs.ext3, mkfs.ext4, mkfs.xfs,
mkfs.jfs, mkfs.btrfs, mkfs.ntfs, mkfs.vfat y mkexfatfs.
Utilidades estándares de Linux como tar, grep, dd, mke2fs, cat etc.

Necesitará tener todos los programas instalados en su sistema para 
que todas las opciones de la aplicación funcionen correctamente.

Las distribuciones de Linux suelen tener estas herramientas instaladas.

Instalación:
------------
Puede realizarse la descarga directa del paquete a través de su página web
desde el directorio distros del repositorio de linux-cdgrab o bien clonar 
este mismo repositorio git mediante la siguiente orden:

git clone https://github.com/Pascual-lingr/linux-cdgrab

Dentro del directorio distros, descomprima el programa ejecutando:

tar -xvzf lingr10_cdrkit.tgz

Dentro del directorio de archivos de linux-cdgrab-1.0-cdrkit teclee ./instalar

Instalación de paquete .deb para Debian o distribuciones derivadas de esta:
Ejecutar el siguiente comando para instalar el paquete .deb

dpkg -i linux-cdgrab_1.0dc_all.deb

No instalar sobre la última versión original de linux-cdgrab o versiones anteriores.
Si desea usarse esta versión debian_cdrkit, desinstalar primero las citadas arriba.

Licencia:
---------
Distribuir bajo licencia GPL v2 (www.gnu.org).

Desarrollo:
-----------
Pascual Martínez Cruz. pascual89@hotmail.com

