#########################################################
# lcgdrabCMD_API/lcdgrabUNIDADES-API.sh
# Coleccion de funciones para la escritura de archivos
# de imagen y formateo en unidades de disco.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de linux-cdgrab 0.5
#########################################################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabCMD_API_idiom/lcdgrabUNIDADES-API.idiom

################## DISPOSITIVOS DE BLOQUE ###################

# volcar_imagen
# vuelca una imagen .ext2 o.img en un dispositivo de bloque.

# NOTA: 
# Esta funcion no es funcional en discos opticos.
# Usar sobre pendrives, diskettes, particiones de disco etc.

# Usar con precaucion y bajo riesgo propio.
# La escritura de la imagen se hace con dd desde el inicio
# de disco, no se permite escribir la imagen desde otras 
# regiones del disco.

# No usar en sistemas de multiples particiones.
# La restauracion puede dejar la tabla de particiones y
# particiones en si inservibles.

volcar_imagen(){

MSG=$volcar_imagen_MSG1

clear
cabecera
echo -e "${C_AV} "
echo $volcar_imagen_MSG2
echo $volcar_imagen_MSG3
echo $volcar_imagen_MSG4
echo ""
echo $volcar_imagen_MSG5

echo $volcar_imagen_MSG6
echo $volcar_imagen_MSG7
echo $volcar_imagen_MSG8
echo ""
echo $volcar_imagen_MSG9
echo $volcar_imagen_MSG10
echo ""
echo $volcar_imagen_MSG11
echo $volcar_imagen_MSG12
echo $volcar_imagen_MSG13
echo $volcar_imagen_MSG14
echo -e "${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"

echo $volcar_imagen_MSG15
read opciondddisco

case $opciondddisco in

"C" | "c")

gestor_de_archivos $MSG
echo -n $volcar_imagen_MSG16
read imagenavolcar

clear

cabecera
echo -e "${C_ET} $volcar_imagen_MSG17 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
mount
echo ""
echo $volcar_imagen_MSG18
read DispositivoBloque

clear
cabecera
echo "$volcar_imagen_MSG19 $imagenavolcar $volcar_imagen_MSG20 $DispositivoBloque"
echo ""
echo "$volcar_imagen_MSG21:dd bs=2048 if=$imagenavolcar of=$DispositivoBloque conv=sync;sync"

dd bs=2048 if=$imagenavolcar of=$DispositivoBloque conv=sync;sync

echo ""
echo -e "${C_AV} $volcar_imagen_MSG22 ${COLOR_DEL_INTERFAZ} ${FONDO_INTERFAZ}"
echo ""
teclash

;;

*)
break
;;

esac

}

# Formateador_linuxfs,
# Adaptado de la version en desarrollo 1.0 alpha
# Formatea una unidad con los siguientes sistemas de ficheros:
# ext2, ext3 y ext4
# Reiserfs
# NTFS
# FAT32 (vfat)
#
# NOTA: 
# Esta opcion borrara todos los datos y formato anterior
# de la unidad.
# Usar con precaucion, usar bajo propio riesgo.

Formateador_linuxfs(){

local vollabel=""
local lingrblksize=4096

while $verdadero;do
			clear
			cabecera
			printf "\t\t $Formateador_linuxfs_MSG6 \n"
			printf "=================================================\n"
			echo $Formateador_linuxfs_MSG1
			echo $Formateador_linuxfs_MSG2
			echo ""
			echo -e "${C_ET}---------LINUX------------${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo "1.- Ext2 (Second extended)"
			echo "2.- Ext3 (Three extended)"
			echo "3.- Ext4 (Four extended)"
			echo "4.- Reiserfs (Reiser file system)"
			echo -e "${C_ET}---------WINDOWS----------${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo "5.- NTFS"
			echo "6.- VFat (FAT32)"
			echo ""
			echo "0.- $Formateador_linuxfs_MSG14"
			echo ""
			echo "SL --> $Formateador_linuxfs_MSG7"
			echo -e "${C_AV}       $Formateador_linuxfs_MSG9${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"


			echo ""

			read fop

			case $fop in

				1)
		
				# Formatea la unidad en ext2
				if test -z $vollabel;then
					vollabel="EXT2FS-DISK"
				fi

				echo $Formateador_linuxfs_MSG3
				read dispositivobloqueformatext2
				umount $dispositivobloqueformatext2 
				echo "$Formateador_linuxfs_MSG4: mke2fs -m 0 -L $vollabel $dispositivobloqueformatext2"
				mke2fs -m 0 -L $vollabel $dispositivobloqueformatext2

				echo $Formateador_linuxfs_MSG5
				echo ""
				teclash
				break

				;;

				2)

				# Formatea la unidad en ext3
				if test -z $vollabel;then
					vollabel="EXT3FS-DISK"
				fi

				echo $Formateador_linuxfs_MSG3
				read dispositivobloqueformatext3
				umount $dispositivobloqueformatext3 
				echo "$Formateador_linuxfs_MSG4: mkfs.ext3 -t ext3 -L $vollabel -b $lingrblksize -o \"LINUX\" $dispositivobloqueformatext3"
				mkfs.ext3 -t ext3 -L $vollabel -b $lingrblksize -o "LINUX" $dispositivobloqueformatext3

				echo $Formateador_linuxfs_MSG5
				echo ""
				teclash
				break

				;;

				3)

				# Formatea la unidad en ext4
				if test -z $vollabel;then
					vollabel="EXT4FS-DISK"
				fi

				echo $Formateador_linuxfs_MSG3
				read dispositivobloqueformatext4
				umount $dispositivobloqueformatext4 
				echo "$Formateador_linuxfs_MSG4: mkfs.ext4 -t ext4 -b $lingrblksize -o \"LINUX\" $dispositivobloqueformatext4"
				mkfs.ext4 -t ext4 -L $vollabel -b $lingrblksize -o "LINUX" $dispositivobloqueformatext4

				echo $Formateador_linuxfs_MSG5
				echo ""
				teclash
				break	

				;;

				4)

				# Formatea la unidad en reiserfs
				if test -z $vollabel;then
					vollabel="REISERFS-DISK"
				fi

				echo $Formateador_linuxfs_MSG3
				read dispositivobloqueformatreiserfs
				umount $dispositivobloqueformatreiserfs 
				echo "$Formateador_linuxfs_MSG4: mkreiserfs -b $lingrblksize -f -l $vollabel --format 3.6 $dispositivobloqueformatreiserfs"
				mkreiserfs -b $lingrblksize -f -l $vollabel --format 3.6 $dispositivobloqueformatreiserfs
	
				echo $Formateador_linuxfs_MSG5
				echo ""
				teclash
				break

				;;

				5)

				# Formatea  la unidad en ntfs
				if test -z $vollabel;then
					vollabel="NTFS-DISK"
				fi

				echo $Formateador_linuxfs_MSG3
				read dispositivobloqueformatntfs
				umount $dispositivobloqueformatntfs 
				echo "$Formateador_linuxfs_MSG4: "
				mkfs.ntfs -f -L $vollabel $dispositivobloqueformatntfs
				echo $Formateador_linuxfs_MSG5
				echo ""
				teclash
				break

				;;

				6)

				# Formatea  la unidad en vfat
				if test -z $vollabel;then
					vollabel="VFAT-DISK"
				fi

				echo $Formateador_linuxfs_MSG3
				read dispositivobloqueformatvfat
				umount $dispositivobloqueformatvfat 
				echo "$Formateador_linuxfs_MSG4: mkfs.vfat -n $vollabel $dispositivobloqueformatvfat"
				mkfs.vfat -n $vollabel $dispositivobloqueformatvfat
				echo $Formateador_linuxfs_MSG5
				echo ""
				teclash
				break

				;;

				'SL')
				
				clear
				cabecera
				echo ""
				echo -n "$Formateador_linuxfs_MSG10: "
				read vollabel
				echo "$Formateador_linuxfs_MSG11: $vollabel"
				teclash
				continue
				;;

				0)
					break
				;;


				*)

				if test $UD -eq 0;then
					Opcion_invalida
				else
					text_Opcion_invalida
					teclash
				fi

				continue

				;;

			esac
done
}

