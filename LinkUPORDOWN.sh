#!/usr/bin/env bash

wireless_adapter=en0
target_ip=8.8.8.8
check_interval=10
#São dadas variáveis, adaptador de internet, ip do google a ser testado, e um intervado de 10 segundos

link_up() {
	if [ "$link_state" = "down" -o "$link_state" = "" ]; then
#variável que recebe se o link está Down, o link state está vazio >
		echo "$(date) Link is up on $ssid"
#aqui é dado um echo no date dentro do ssid
		say "Link is up on $ssid"
#Escreve que o link está up no ssid
		link_state=up
	fi
}

link_down() {
	if [ "$link_state" = "up" -o "$link_state" = "" ]; then
#variável que recebe se o link Up, o link state está vazio >
		echo "$(date) Link is down on $ssid"
#aqui é dado um echo no date dentro do ssid
		say "Link is down on $ssid" 
#Escreve que o link está down no ssid
		link_state=down
	fi
}

while true
do
#aqui é aonde tudo acontece
	ssid=$(networksetup -getairportnetwork $wireless_adapter | cut -c 24-)
#aqui está o ssid que é consultado com o adaptador de internet, o cut mostra os 24 caracteres do arquivo
	ping -c 1 -t 3 $target_ip > /dev/null 2>&1
# pinga para o google 3x 
	if [ $? -ne 0 ]; then
#aqui o $? apresenta o resultado de um comando, ou seja, através do -ne, se for igual a 0 >
		link_down
#link down
	else
		link_up
	fi
	sleep $check_interval
#dá um intervado de 10 segundos
done
