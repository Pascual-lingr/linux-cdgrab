#########################################################
# lcgdrabMenu_API/lcdgrabUITMPDIR.sh
# Menu de Interfaz para gestionar los archivos de imagen
# almacenados en el directorio /tmp del sistema.
#
# Pascual Martinez Cruz --> pascual89@hotmail.com
# Distribuir bajo GPL v2
# Parte de Linux-cdgrab 0.5
#########################################################

############################### INTERFAZ PARA /tmp ############################
###############################################################################

# Expande el fichero de idioma

source ${D_LINUXCDGRAB}/lcdgrabAPI_idiom/${IDIOM}/lcdgrabMenu_API_idiom/lcdgrabUITMPDIR.idiom

# dir_tmp
# INTERFAZ PARA MANIPULAR ARCHIVOS DEL DIRECTORIO TEMPORAL

# suprimido la opcion de comprimir archivos ya que lo hace el gestor de archivos

dir_tmp(){

		while $verdadero;do
			MSG=$dir_tmp_MSG1
			clear
			cabecera
			echo "1.- $dir_tmp_MSG2"
			echo "2.- $dir_tmp_MSG3"
			echo "|------------------------------------------------------|"
			echo "3.- $dir_tmp_MSG4"
			echo "4.- $dir_tmp_MSG5"
			echo "5.- $dir_tmp_MSG6"
			echo "0.- $dir_tmp_MSG7"
			echo -e "${C_ET}$dir_tmp_MSG8 $D_TMP ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
			echo "======================================"
			ls $D_TMP/*.iso $D_TMP/*.ext2 $D_TMP/*.gz $D_TMP/*.bz2 $D_TMP/*.xz $D_TMP/*.img

			echo ""
			echo -n "$dir_tmp_MSG9	"
			read eleccion

			case $eleccion in

				1)

				rm -rf $D_TMP/*.iso $D_TMP/*.ext2 $D_TMP/*.gz $D_TMP/*.bz2 $D_TMP/*.xz $D_TMP/*.img

				if test $UD -eq 0;then
					dialog --backtitle "LINUX-CDGRAB 0.5" --msgbox $dir_tmp_MSG10 9 50
				else
					echo $dir_tmp_MSG10
					teclash
				fi

				;;


				2)
					cd $D_TMP
					gestor_de_archivos $MSG
				;;

				3)

				clear
				cabecera
				echo "M.- $dir_tmp_MSG11"
				echo "D.- $dir_tmp_MSG12"

				read op_md_img

				case $op_md_img in

					"m" | "M" )

						monta_img

					;;

					"d" | "D" )

						desmonta_img
					
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
				
				;;

				4)

				MenuImagen

				;;

				5)
					clear
					cabecera
					echo "1.- $dir_tmp_MSG13"
					echo "2.- $dir_tmp_MSG14"
					echo ""
					echo -n "$dir_tmp_MSG15: "
					read op_grab_img

					if ! test -f $D_CFG/lcdgrab.cfg;then
						echo ""
						echo -e "${C_FA} $dir_tmp_MSG16 ${COLOR_DEL_INTERFAZ}${FONDO_INTERFAZ}"
						echo $dir_tmp_MSG17
						sleep 1
						teclash
						break
					else
						exportar_variables
					fi

					case $op_grab_img in

						1)	
							echo ""
							grabimg
						;;

						2)
							MSG=$dir_tmp_MSG18
							gestor_de_archivos $MSG
							echo $dir_tmp_MSG19
							read imagen
							echo ""
							buscar_grabadora
							grabimg-dvd $imagen
						;;
				
					esac

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

