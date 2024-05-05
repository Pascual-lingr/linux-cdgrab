#!/bin/bash

# InstExtraslingr10.sh; Pascual Martínez Cruz
# Instalación de los extras para LINUX-CDGRAB 1.0
# Instala los parches e idiomas experimentales.
# Distribuir bajo licencia GPL v2.

echo "-- INSTALACION DE COMPLEMENTOS EXTRA PARA LINUX-CDGRAB 1.0 --"

case $1 in
"--linux")

cp lingr10ExtrasLeeme.txt /usr/share/linux-cdgrab

echo "Copiando idiomas experimentales"

cd ./ExIdiom

cp * -rf /usr/share/linux-cdgrab/lcdgrabAPI_idiom

echo "Idiomas experimentales instalados"

cd ..

echo "Copiando parches"

cd ./PatchV10
cp -f lingr10lightscribepatch.sh /usr/share/linux-cdgrab/parches
cp -f Leeme-soporte-lightscribe.txt /usr/share/linux-cdgrab/parches

cp -f lingr10reiserfspatch.sh /usr/share/linux-cdgrab/parches
cp -f Leeme-soporte-ReiserFS.txt /usr/share/linux-cdgrab/parches

chmod +x /usr/share/linux-cdgrab/parches/lingr10lightscribepatch.sh
chmod +x /usr/share/linux-cdgrab/parches/lingr10reiserfspatch.sh

cp -f ./Español/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/Español/lcdgrabparches_idiom
cp -f ./EspDefNA/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/EspDefNA/lcdgrabparches_idiom
cp -f ./.defecidiom/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/.defecidiom/lcdgrabparches_idiom
cp -f ./Catala/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/Catala/lcdgrabparches_idiom
cp -f ./English/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/English/lcdgrabparches_idiom

cp -f ./ExJapanese/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExJapanese/lcdgrabparches_idiom
cp -f ./ExChinese/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExChinese/lcdgrabparches_idiom
cp -f ./ExGerman/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExGerman/lcdgrabparches_idiom
cp -f ./ExRussian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExRussian/lcdgrabparches_idiom
cp -f ./ExFrench/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExFrench/lcdgrabparches_idiom
cp -f ./ExKorean/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExKorean/lcdgrabparches_idiom
cp -f ./ExGreek/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExGreek/lcdgrabparches_idiom
cp -f ./ExPortuguese/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExPortuguese/lcdgrabparches_idiom
cp -f ./ExItalian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExItalian/lcdgrabparches_idiom
cp -f ./ExDutch/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExDutch/lcdgrabparches_idiom
cp -f ./ExNorwegian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExNorwegian/lcdgrabparches_idiom
cp -f ./ExPolish/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExPolish/lcdgrabparches_idiom
cp -f ./ExCzech/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExCzech/lcdgrabparches_idiom
cp -f ./ExSwedish/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExSwedish/lcdgrabparches_idiom
cp -f ./ExArmenian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExArmenian/lcdgrabparches_idiom
cp -f ./ExGeorgian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExGeorgian/lcdgrabparches_idiom
cp -f ./ExSpanishEn/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExSpanishEn/lcdgrabparches_idiom
cp -f ./ExDanish/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExDanish/lcdgrabparches_idiom
cp -f ./ExAmharic/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExAmharic/lcdgrabparches_idiom
cp -f ./ExTigrinya/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExTigrinya/lcdgrabparches_idiom
cp -f ./ExVietnamese/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExVietnamese/lcdgrabparches_idiom
cp -f ./ExIcelandic/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExIcelandic/lcdgrabparches_idiom
cp -f ./ExSwahili/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExSwahili/lcdgrabparches_idiom
cp -f ./ExLao/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExLao/lcdgrabparches_idiom
cp -f ./ExLuxembourgish/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExLuxembourgish/lcdgrabparches_idiom
cp -f ./ExLithuanian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExLithuanian/lcdgrabparches_idiom
cp -f ./ExAfrikaans/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExAfrikaans/lcdgrabparches_idiom
cp -f ./ExUkrainian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExUkrainian/lcdgrabparches_idiom
cp -f ./ExTurkish/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExTurkish/lcdgrabparches_idiom
cp -f ./ExHungarian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExHungarian/lcdgrabparches_idiom
cp -f ./ExBelarusian/lingr10lightscribepatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExBelarusian/lcdgrabparches_idiom

cp -f ./Español/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/Español/lcdgrabparches_idiom
cp -f ./EspDefNA/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/EspDefNA/lcdgrabparches_idiom
cp -f ./.defecidiom/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/.defecidiom/lcdgrabparches_idiom
cp -f ./Catala/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/Catala/lcdgrabparches_idiom
cp -f ./English/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/English/lcdgrabparches_idiom

cp -f ./ExJapanese/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExJapanese/lcdgrabparches_idiom
cp -f ./ExChinese/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExChinese/lcdgrabparches_idiom
cp -f ./ExGerman/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExGerman/lcdgrabparches_idiom
cp -f ./ExRussian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExRussian/lcdgrabparches_idiom
cp -f ./ExFrench/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExFrench/lcdgrabparches_idiom
cp -f ./ExKorean/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExKorean/lcdgrabparches_idiom
cp -f ./ExGreek/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExGreek/lcdgrabparches_idiom
cp -f ./ExThai/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExThai/lcdgrabparches_idiom
cp -f ./ExPortuguese/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExPortuguese/lcdgrabparches_idiom
cp -f ./ExItalian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExItalian/lcdgrabparches_idiom
cp -f ./ExDutch/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExDutch/lcdgrabparches_idiom
cp -f ./ExNorwegian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExNorwegian/lcdgrabparches_idiom
cp -f ./ExPolish/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExPolish/lcdgrabparches_idiom
cp -f ./ExCzech/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExCzech/lcdgrabparches_idiom
cp -f ./ExSwedish/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExSwedish/lcdgrabparches_idiom
cp -f ./ExArmenian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExArmenian/lcdgrabparches_idiom
cp -f ./ExGeorgian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExGeorgian/lcdgrabparches_idiom
cp -f ./ExSpanishEn/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExSpanishEn/lcdgrabparches_idiom
cp -f ./ExDanish/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExDanish/lcdgrabparches_idiom
cp -f ./ExAmharic/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExAmharic/lcdgrabparches_idiom
cp -f ./ExTigrinya/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExTigrinya/lcdgrabparches_idiom
cp -f ./ExVietnamese/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExVietnamese/lcdgrabparches_idiom
cp -f ./ExIcelandic/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExIcelandic/lcdgrabparches_idiom
cp -f ./ExSwahili/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExSwahili/lcdgrabparches_idiom
cp -f ./ExLao/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExLao/lcdgrabparches_idiom
cp -f ./ExLuxembourgish/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExLuxembourgish/lcdgrabparches_idiom
cp -f ./ExLithuanian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExLithuanian/lcdgrabparches_idiom
cp -f ./ExAfrikaans/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExAfrikaans/lcdgrabparches_idiom
cp -f ./ExUkrainian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExUkrainian/lcdgrabparches_idiom
cp -f ./ExTurkish/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExTurkish/lcdgrabparches_idiom
cp -f ./ExHungarian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExHungarian/lcdgrabparches_idiom
cp -f ./ExBelarusian/lingr10reiserfspatch.idiom /usr/share/linux-cdgrab/lcdgrabAPI_idiom/ExBelarusian/lcdgrabparches_idiom

echo "Parches instalados"
echo "------- INSTALACION DE COMPLEMENTOS EXTRA FINALIZADA --------"
cd ..

;;

"--gobolinux")

cp lingr10ExtrasLeeme.txt /Programs/linux-cdgrab-1.0

echo "Copiando idiomas experimentales"

cd ./ExIdiom

cp * -rf /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom

echo "Idiomas experimentales instalados"

cd ..

echo "Copiando parches"

cd ./PatchV10
cp -f lingr10lightscribepatch.sh /Programs/linux-cdgrab-1.0/parches/
cp -f Leeme-soporte-lightscribe.txt /Programs/linux-cdgrab-1.0/parches/

cp -f lingr10reiserfspatch.sh /Programs/linux-cdgrab-1.0/parches/
cp -f Leeme-soporte-ReiserFS.txt /Programs/linux-cdgrab-1.0/parches/

chmod +x /Programs/linux-cdgrab-1.0/parches/lingr10lightscribepatch.sh
chmod +x /Programs/linux-cdgrab-1.0/parches/lingr10reiserfspatch.sh

cp -f ./Español/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/Español/lcdgrabparches_idiom
cp -f ./EspDefNA/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/EspDefNA/lcdgrabparches_idiom
cp -f ./.defecidiom/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/.defecidiom/lcdgrabparches_idiom
cp -f ./Catala/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/Catala/lcdgrabparches_idiom
cp -f ./English/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/English/lcdgrabparches_idiom

cp -f ./ExJapanese/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExJapanese/lcdgrabparches_idiom
cp -f ./ExChinese/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExChinese/lcdgrabparches_idiom
cp -f ./ExGerman/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExGerman/lcdgrabparches_idiom
cp -f ./ExRussian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExRussian/lcdgrabparches_idiom
cp -f ./ExFrench/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExFrench/lcdgrabparches_idiom
cp -f ./ExKorean/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExKorean/lcdgrabparches_idiom
cp -f ./ExThai/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExThai/lcdgrabparches_idiom
cp -f ./ExPortuguese/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExPortuguese/lcdgrabparches_idiom
cp -f ./ExItalian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExItalian/lcdgrabparches_idiom
cp -f ./ExDutch/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExDutch/lcdgrabparches_idiom
cp -f ./ExNorwegian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExNorwegian/lcdgrabparches_idiom
cp -f ./ExPolish/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExPolish/lcdgrabparches_idiom
cp -f ./ExCzech/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExCzech/lcdgrabparches_idiom
cp -f ./ExSwedish/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExSwedish/lcdgrabparches_idiom
cp -f ./ExArmenian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExArmenian/lcdgrabparches_idiom
cp -f ./ExGeorgian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExGeorgian/lcdgrabparches_idiom
cp -f ./ExSpanishEn/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExSpanishEn/lcdgrabparches_idiom
cp -f ./ExDanish/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExDanish/lcdgrabparches_idiom
cp -f ./ExAmharic/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExAmharic/lcdgrabparches_idiom
cp -f ./ExTigrinya/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExTigrinya/lcdgrabparches_idiom
cp -f ./ExVietnamese/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExVietnamese/lcdgrabparches_idiom
cp -f ./ExIcelandic/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExIcelandic/lcdgrabparches_idiom
cp -f ./ExSwahili/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExSwahili/lcdgrabparches_idiom
cp -f ./ExLao/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExLao/lcdgrabparches_idiom
cp -f ./ExLuxembourgish/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExLuxembourgish/lcdgrabparches_idiom
cp -f ./ExLithuanian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExLithuanian/lcdgrabparches_idiom
cp -f ./ExAfrikaans/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExAfrikaans/lcdgrabparches_idiom
cp -f ./ExUkrainian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExUkrainian/lcdgrabparches_idiom
cp -f ./ExTurkish/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExTurkish/lcdgrabparches_idiom
cp -f ./ExHungarian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExHungarian/lcdgrabparches_idiom
cp -f ./ExBelarusian/lingr10lightscribepatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExBelarusian/lcdgrabparches_idiom

cp -f ./Español/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/Español/lcdgrabparches_idiom
cp -f ./EspDefNA/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/EspDefNA/lcdgrabparches_idiom
cp -f ./.defecidiom/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/.defecidiom/lcdgrabparches_idiom
cp -f ./Catala/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/Catala/lcdgrabparches_idiom
cp -f ./English/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/English/lcdgrabparches_idiom

cp -f ./ExJapanese/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExJapanese/lcdgrabparches_idiom
cp -f ./ExChinese/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExChinese/lcdgrabparches_idiom
cp -f ./ExGerman/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExGerman/lcdgrabparches_idiom
cp -f ./ExRussian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExRussian/lcdgrabparches_idiom
cp -f ./ExFrench/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExFrench/lcdgrabparches_idiom
cp -f ./ExKorean/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExKorean/lcdgrabparches_idiom
cp -f ./ExThai/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExThai/lcdgrabparches_idiom
cp -f ./ExPortuguese/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExPortuguese/lcdgrabparches_idiom
cp -f ./ExItalian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExItalian/lcdgrabparches_idiom
cp -f ./ExDutch/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExDutch/lcdgrabparches_idiom
cp -f ./ExNorwegian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExNorwegian/lcdgrabparches_idiom
cp -f ./ExPolish/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExPolish/lcdgrabparches_idiom
cp -f ./ExCzech/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExCzech/lcdgrabparches_idiom
cp -f ./ExSwedish/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExSwedish/lcdgrabparches_idiom
cp -f ./ExArmenian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExArmenian/lcdgrabparches_idiom
cp -f ./ExGeorgian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExGeorgian/lcdgrabparches_idiom
cp -f ./ExSpanishEn/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExSpanishEn/lcdgrabparches_idiom
cp -f ./ExDanish/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExDanish/lcdgrabparches_idiom
cp -f ./ExAmharic/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExAmharic/lcdgrabparches_idiom
cp -f ./ExTigrinya/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExTigrinya/lcdgrabparches_idiom
cp -f ./ExVietnamese/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExVietnamese/lcdgrabparches_idiom
cp -f ./ExIcelandic/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExIcelandic/lcdgrabparches_idiom
cp -f ./ExSwahili/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExSwahili/lcdgrabparches_idiom
cp -f ./ExLao/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExLao/lcdgrabparches_idiom
cp -f ./ExLuxembourgish/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExLuxembourgish/lcdgrabparches_idiom
cp -f ./ExLithuanian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExLithuanian/lcdgrabparches_idiom
cp -f ./ExAfrikaans/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExAfrikaans/lcdgrabparches_idiom
cp -f ./ExUkrainian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExUkrainian/lcdgrabparches_idiom
cp -f ./ExTurkish/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExTurkish/lcdgrabparches_idiom
cp -f ./ExHungarian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExHungarian/lcdgrabparches_idiom
cp -f ./ExBelarusian/lingr10reiserfspatch.idiom /Programs/linux-cdgrab-1.0/lcdgrabAPI_idiom/ExBelarusian/lcdgrabparches_idiom

echo "Parches instalados"
echo "------- INSTALACION DE COMPLEMENTOS EXTRA FINALIZADA --------"

cd ..

;;

*)
	echo "$1 Opcion incorrecta"
	echo "No puede realizarse la instalación de complementos extra."
	echo "Usar --linux o --gobolinux segun la distribucion existente."
;;

esac

