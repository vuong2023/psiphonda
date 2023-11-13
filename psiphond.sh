#!/bin/bash

### by dankelthaher - scripts ###

## PSIPHOND SCRIPT DE AUTOINSTALACON 

## VARIABLES DE COLORES
#COLORES 
blanco='\033[1;38;5;231m'
gris='\033[1;38;5;247m'
morado105='\033[1;38;5;105m'
verde36='\033[1;38;5;36m'
azulRB='\033[1;38;5;39m'
verde34='\033[1;38;5;34m'
melon='\033[1;38;5;208m'
guinda='\033[1;38;5;161m'
rojo='\033[1;31m'
cyanR='\033[1;38;5;87m'
cierre='\033[0m'

bar1="\e[1;30m◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚◚\e[0m"
bar2="\033[38;5;226m---------------------------------------------------------\033[0m"
bar3="\033[38;5;226m--------------------- = MENU = --------------------------\033[0m"

#RUTAS DE ARCHIVOS
cred1=".credenciales"
dir_main="/root/psi"
file_ip="/root/ip"
file_init="/root/psi/psiphond"

#ENLACES DE ARCHIVOS

## INSTALANDO BINARIO
binario_script(){
[[ ! -d $dir_main ]] && mkdir $dir_main
apt-get install net-tools -y
IP=$(wget -qO- ipv4.icanhazip.com)
IP2=$(wget -qO- http://whatismyip.akamai.com/)
[[ "$IP" != "$IP2" ]] && ipvps="$IP2" || ipvps="$IP"
echo -e "$ipvps" > $file_ip
        cd $dir_main
        wget 'https://docs.google.com/uc?export=download&id=1AuP6XISWohM0NbUyItnQeN1F7Ayj85Ez' -O 'psiphond'
        chmod 775 psiphond
        ./psiphond --ipaddress 0.0.0.0 --protocol FRONTED-MEEK-HTTP-OSSH:80 --protocol FRONTED-MEEK-OSSH:443 generate
        apt install screen -y
}

## INSTALACION
instalar_psi(){
    clear
    if [[ "$(netstat -tlpn | grep 'psiphond' | wc -l)" != '1' ]]; then
    echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "${cyanR} ESTE SCRIPT INSTALARA LA PSIPHOND AUTOMATICAMENTE"
    echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -p "$(echo -e "${blanco}DESEA CONTINUAR ${blanco}? ${rojo}[${blanco}s/n${rojo}]${blanco}: ")"  -e -i s resp
    echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			if [[ $resp = 's' ]]; then
            cd $dir_main
            echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "${verde34}SI LA PANTALLA SE CONGELA PRESION crtl + a + d \033[0m"
                # INICIA ACA EL SERVICIO
		screen
                ./psiphond run

                if [[ "$(ps x | grep 'psiphond' | grep -v 'grep'|wc -l)" != '0' ]]; then
				   echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                   echo -e "${verde34} SERVICIO INICIADO CON EXITO EN EL PUERTO 443"
                   echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			    else
				echo ""
				   echo -e "${rojo} ALGO SALIO MAL EN LA INSTALACION"
                   echo ""
                   echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			    fi
            else
                   echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                   echo -e "${blanco} BUENA OPCION SI NO CONOCES PSIPHOND"
                   echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            fi # cierre de el respuetsa si
    else
    echo ""
    echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "${verde34} EL SERVICIO YA SE ESTA EJECUTANDO${cierre}"
    echo -e "${azulRB}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    exit 1
    fi
    ## FUNCIONES 
    
   
    echo ""
    echo -ne "\033[1;31mENTER \033[1;33mpara regresar al \033[1;32mMENU!\033[0m" && read enter && clear
}
    clear
    binario_script
    instalar_psi
