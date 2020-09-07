#!/bin/bash
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
rm $(pwd)/$0

### COLORES Y BARRA 
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${VERMELHO}======================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}

ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="%";;
"%")txt[$i]="4";;
"-")txt[$i]="K";;
"K")txt[$i]="-";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}

veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"gerar.sh")ARQ="/usr/bin/";;
"http-server.py")ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}

function_verify () {
  permited=$(curl -sSL "https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/Control-IP")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  echo -e "\n\n\n\033[1;31m====================================================="
  echo -e "\033[1;31m       ¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADA!"
  echo -e "\033[1;31m                CONTACTE A @Rufu99"
  echo -e "\033[1;31m=====================================================\n\n\n"
  [[ -d /etc/SCRIPT ]] && rm -rf /etc/SCRIPT
  exit 1
  } || {
  ### INTALAR VERCION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/Vercion")
  echo "$v1" > /etc/versin_script
  }
}

meu_ip

invalid_key () {
msg -bar2 && msg -verm "#¡Key Invalida#! " && msg -bar2
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
exit 1
}

echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;36m--------------------KEY GENERATOR BY @Rufu99----------------------\033[0m"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"

while [[ ! $Key ]]; do
msg -bar2 && msg -ne "# DIGITE LA KEY #: " && read Key
tput cuu1 && tput dl1
done
msg -ne "# Verificando Key # : "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[1;32m Key Completa" || {
   echo -e "\033[1;91m Key Incompleta"
   invalid_key
   exit
   }
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
sleep 1s
function_verify
[[ -e $HOME/lista-arq ]] && {
REQUEST=$(ofus "$Key" |cut -d'/' -f2)
for arqx in `cat $HOME/lista-arq`; do
echo -ne "\033[1;33mDescargando \033[1;31m[$arqx] "
wget -O $HOME/$arqx ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mRecibido!" || echo -e "\033[1;31m- \033[1;31mFalla (no recibido!)"
[[ -e $HOME/$arqx ]] && veryfy_fun $arqx
done
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/Install/trans &> /dev/null
[[ -e /bin/http-server.py ]] && mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR
cp $HOME/lista-arq /etc/SCRIPT
cp /bin/http-server.sh /etc/SCRIPT
mv /etc/SCRIPT/http-server.sh /etc/SCRIPT/http-server.py
wget https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/gerador/gerar.sh &>/dev/null
mv gerar.sh /etc/SCRIPT
cd /etc/SCRIPT
rm -rf FERRAMENTA KEY KEY! INVALIDA!
rm $HOME/lista-arq
sed -i -e 's/\r$//' /usr/bin/gerar.sh
msg -bar
echo "/usr/bin/gerar.sh" > /usr/bin/gerar && chmod +x /usr/bin/gerar
echo -e "\033[1;33m Perfecto, utilize el comando \033[1;31mgerar.sh o gerar \033[1;33mpara administrar sus keys y
 actualizar la base del servidor"
msg -bar
} || {
msg -bar
echo -e "\033[1;33mKey Invalida!"
msg -bar
}
echo -ne "\033[0m"
