#!/bin/bash

###################
## Controladores ##
###################

# Controle de pastas
controlador()
{
	# Estrutura de decisao: Existencia e criacao de pastas
	if [[ -r "NMAP_IP" && -r "NMAP_REDE" ]]
	then
		# Comando
		clear
	else
		# Instalacao
		apt-get install nmap
		
		# Criacao de pasta: IP e REDE
		mkdir NMAP_IP
		mkdir NMAP_REDE
		clear
	fi
}

# Verificador de relatorio
verificador()
{
	# Mensagem
	echo -e "\033[01;32m\n *** Relatorio Concluido [enter] *** \033[01;37m"
	read
}

#############################
## Metodos Scanner de Host ##
#############################

# Analise completa
completo()
{
	# Entrada de dados
	clear
	echo -e "\033[01;36m ------------ \033[01;37m"
	echo -e "\033[01;32m * Completo * \033[01;37m"
	echo -e "\033[01;36m ------------ \033[01;37m"
	echo ""
	echo -e -n "\033[01;35m # Host: \033[01;37m"
	
	# Entrada de dados
	read IP

	# Comando em variavel
	cmd1="-f -A -O -sV -sS -g 53 --open --privileged --randomize-hosts"
	cmd2="--version-intensity 9 --spoof-mac Dell --data-length 200 --dns-server 8.8.8.8,8.8.4.4"
	cmd3="-D $IP,8.8.8.7,8.8.8.6,8.8.8.5,6.8.8.4,8.8.8.3,8.8.8.2,8.8.8.1,177.53.142.217,200.123.45.34,182.45.23.45,192.168.0.1,172.16.0.1 $IP"

	# Concatenacao
	cmd="$cmd1 $cmd2 $cmd3"

	# Comando
	nmap $cmd > NMAP_IP/completo_$IP.txt

	# Leitura de relatorio
	cat NMAP_IP/completo_$IP.txt | less
	
	# Comando
	verificador
}

# Analise por Vulnerabilidade
vulnerabilidades()
{
	# Controle
	a=1

	# Entrada de dados
	clear
	echo -e "\033[01;36m -------------------- \033[01;37m"
	echo -e "\033[01;32m * Vulnerabilidades * \033[01;37m"
	echo -e "\033[01;36m -------------------- \033[01;37m"
	echo ""
	echo -e -n "\033[01;37m # Host [Ex: testphp.vulnweb.com || Ex: 127.0.0.1]: \033[01;37m"

	# Entrada de dados
	read IP

	# Estrutura de repeticao
	while ((a==1))
	do
		# Mensagem
		clear
		echo -e "\033[01;36m -------------------- \033[01;37m"
		echo -e "\033[01;32m * Vulnerabilidades * \033[01;37m"
		echo -e "\033[01;36m -------------------- \033[01;37m"
		echo ""
		echo -e "\033[01;31m + Tipos de Vulnerabilidade + \033[01;37m"
		echo -e "\033[01;32m [1] Enumeration		  \033[01;37m"
		echo -e "\033[01;33m [2] Fileupload          	  \033[01;37m"
		echo -e "\033[01;34m [3] Frontpage Login     	  \033[01;37m"
		echo -e "\033[01;35m [4] HTTP Passwd         	  \033[01;37m"
		echo -e "\033[01;36m [5] Directory Traversal 	  \033[01;37m"
		echo -e "\033[01;37m [6] Sql Injection       	  \033[01;37m"
		echo -e "\033[01;31m [7] Mysql               	  \033[01;37m"
   		echo -e "\033[01;32m [8] Dos			  \033[01;37m"
		echo -e "\033[01;33m [9] ALL			  \033[01;37m"
		echo ""
		echo -e "\033[01;31m [0] Voltar			  \033[01;37m"
		echo ""
		echo -e -n "\033[01;37m # Opc: \033[01;37m"
		read esc

		# Comando em variavel
		cmd1="-g 53 -O -sS -sV"
		cmd2="-D $IP,8.8.8.7,8.8.8.6,8.8.8.5,6.8.8.4,8.8.8.3,8.8.8.2,8.8.8.1,177.53.142.217,200.123.45.34,182.45.23.45,192.168.0.1,172.16.0.1 $IP"
		cmd="$cmd1 $cmd2"

		# Estrutura em escolha
		case $esc in

		1)	nmap -script="http-enum" $cmd > NMAP_IP/enumeration_$IP.txt
			cat NMAP_IP/enumeration_$IP.txt | less
	        	controle;;

		2)	nmap -script="http-fileupload-exploiter.nse" $cmd > NMAP_IP/fileUpload_$IP.txt
        		cat NMAP_IP/fileUpload_$IP.txt | less
        		controle;;

		3)	nmap -script="http-frontpage-login" $cmd > NMAP_IP/frontPage_$IP.txt
        		cat NMAP_IP/frontPage_$IP.txt | less
        		controle;;

		4)	nmap -script="http-passwd" $cmd > NMAP_IP/http_$IP.txt
        		cat NMAP_IP/http_$IP.txt | less
        		controle;;

		5)	nmap -script="http-phpmyadmin-dir-traversal" $cmd > NMAP_IP/directoryTraversal_$IP.txt
        		cat NMAP_IP/directoryTraversal_$IP.txt | less
        		controle;;
		
		6)	nmap -script="http-sql-injection" $cmd > NMAP_IP/sqlInjection_$IP.txt
			cat NMAP_IP/sqlInjection_$IP.txt | less
    			controle;;

    		7)	nmap -script="mysql-brute" $cmd > NMAP_IP/mysql_$IP.txt
       			cat NMAP_IP/mysql_$IP.txt | less
			controle;;
    
    		8)	nmap -script="ntp-monlist,dns-recursion,snmp-sysdescr" $cmd > NMAP_IP/dos_$IP.txt
     			cat NMAP_IP/dos_$IP.txt | less
     			controle;;

		9)	nmap -script="vuln" $cmd > NMAP_IP/allVulns_$IP.txt
        		cat NMAP_IP/allVulns_$IP.txt | less
        		controle;;

		0)	a=2;;

		*)	;;

		esac
	done
}

# Analisando sistema operacional
sistemaOperacional()
{
	# Apresentacao
	clear
	echo -e "\033[01;36m ----------------------- \033[01;37m"
	echo -e "\033[01;32m * Sistema Operacional * \033[01;37m"
	echo -e "\033[01;36m ----------------------- \033[01;37m"
	echo ""

	# Entrada de dados
	echo -e -n "\033[01;35m # Host: \033[01;37m"
	read IP

	# Comandos
	cmd1="-O -sS -sV --data-length 200 -g 53"
	cmd2="-D $IP,8.8.8.7,8.8.8.6,8.8.8.5,6.8.8.4,8.8.8.3,8.8.8.2,8.8.8.1,177.53.142.217,200.123.45.34,182.45.23.45,192.168.0.1,172.16.0.1 $IP"

	# Concatenacao
	cmd="$cmd1 $cmd2"

	# Comando
	nmap $cmd > NMAP_IP/operacional_$IP.txt

	# Leitura de relatorio
	cat NMAP_IP/operacional_$IP.txt | less

	# Chamada de metodo
	verificador
}

#################################
#### Metodos Scanner de Rede ####
#################################

sistemasOperacionais()
{
	# Entrada de dados
	clear
	echo ""
	echo -e "\033[01;32m ------------------------- \033[01;37m"
	echo -e "\033[01;36m * Sistemas Operacionais * \033[01;37m"
	echo -e "\033[01;32m ------------------------- \033[01;37m"
	echo ""
	echo -e -n "\033[01;35m # Host: \033[01;37m"

	# Leitura dos dados
	read IP

	# Comando em variavel
	cmd="-f -sV -O -D $IP,8.8.8.7,8.8.8.6,8.8.8.5,6.8.8.4,8.8.8.3,8.8.8.2,8.8.8.1,177.53.142.217,200.123.45.34,182.45.23.45,192.168.0.1,172.16.0.1 $IP/24"

	# Comando
	nmap $cmd > NMAP_REDE/sistemasOperacionais_$IP.txt

	# Descricoes
	clear
	cat NMAP_REDE/sistemasOperacionais_$IP.txt | grep -i -E "Nmap scan report for|Os details:"

	# Descricoes: Deteccao de sistema operacional [Windows]
    	windows=$(cat NMAP_REDE/sistemasOperacionais_$IP.txt | grep -i "OS: Windows*" | wc -l)
    	echo ""
    	echo " --- Sistemas operacionais Microsoft ---"
    	echo " * Windows: $windows"

	# Descricoes: Deteccao de sistema operacional [Linux]
	linux=$(cat NMAP_REDE/sistemasOperacionais_$IP.txt | grep -i "Running: Linux*" | wc -l)
	echo "" 
	echo " --- Sistemas operacionais Linux ---"
	echo " * Linux: $linux"

	# Chamada de metodo
	verificador
}

sistemasPortas()
{
	# Entrada de dados
	clear
	echo ""
	echo -e "\033[01;32m ---------------------- \033[01;37m"
   	echo -e "\033[01;36m * Escanner de portas * \033[01;37m"
  	echo -e "\033[01;32m ---------------------- \033[01;37m"
  	echo ""
  	echo -e -n "\033[01;35m # Host: \033[01;37m"
  	read IP
	echo ""
  	echo -e -n "\033[01;33m # Portas [Ex: 80,135,110]: \033[01;37m"
  	read portas

	# Comando em variavel
	cmd="-f -p $portas -sS -sV -O -open --version-intensity 9 --privileged $IP/24"

	# Comando: Nmap
	nmap $cmd > NMAP_REDE/portas_$IP.txt

	# Descricoes IP
	var1=$(cat NMAP_REDE/portas_$IP.txt | grep -i "Nmap scan report for")
	echo ""
	echo "*** IP ***"
	echo "$var1"
	
	# Descricoes MAC
	var2=$(cat NMAP_REDE/portas_$IP.txt | grep -i "MAC")
	echo ""
	echo "*** MAC ***"
	echo "$var2"

	# Descricoes: Deteccao de sistema operacional [Windows]
	var3=$(cat NMAP_REDE/portas_$IP.txt | grep -i "OS: Windows*" | wc -l)
	echo ""
	echo "--- OS ---"
	echo "Windows: $var3"

	# Descricoes: Deteccao de sistema operacional [Linux]
	var4=$(cat NMAP_REDE/portas_$IP.txt | grep -i "Running: Linux*" | wc -l)
	echo ""
	echo "--- OS ---"
	echo "Linux: $var4"

	# Chamada de metodo
	verificador
}

detalhado()
{
	# Entrada de dados
	clear
        echo -e "\033[01;32m ----------------- \033[01;37m"
        echo -e "\033[01;36m *   Detalhado   * \033[01;37m"
        echo -e "\033[01;32m ----------------- \033[01;37m"
        echo ""
	echo -e -n "\033[01;35m + IP: \033[01;37m"

	# Leitura dos dados
	read IP

	# Comando em variavel
	cmd="-f -sV -A -O -D $IP,8.8.8.7,8.8.8.6,8.8.8.5,6.8.8.4,8.8.8.3,8.8.8.2,8.8.8.1,177.53.142.217,200.123.45.34,182.45.23.45,192.168.0.1,172.16.0.1 $IP/24"

	# Comando Nmap
        nmap $cmd > NMAP_REDE/detalhado_$IP.txt
        
        # Relatorio detalhado
        cat NMAP_REDE/detalhado_$IP.txt | less
}

############################
#### Estruturas de Menu ####
############################

# Menu: Host
hostMenu()
{
	clear
	echo -e "\033[01;31m ------------------ \033[01;37m"
	echo -e "\033[01;32m     NMAP - Host    \033[01;37m"
	echo -e "\033[01;31m ------------------ \033[01;37m"
	echo -e ""
	echo -e "\033[01;33m [1] Completo	     \033[01;37m"
   	echo -e "\033[01;35m [2] Vulnerabilidades    \033[01;37m"
	echo -e "\033[01;34m [3] Sistema Operacional \033[01;37m"
  	echo ""
	echo -e -n "\033[01;36m # Opc: \033[01;37m"
    	read resp

	# Estrutura de escolha
  	case $resp in
	
	1)	completo;;
	2)	vulnerabilidades;;
    	3)	sistemaOperacional;;
    	*)	;;

	esac
}

# Menu: REDE
netMenu()
{
	clear
	echo -e "\033[01;31m ------------------ \033[01;37m"
	echo -e "\033[01;32m     NMAP - REDE    \033[01;37m"
	echo -e "\033[01;31m ------------------ \033[01;37m"
	echo -e ""
	echo -e "\033[01;33m [1] Pesquisar: Sistemas operacionais 	     \033[01;37m"
	echo -e "\033[01;34m [2] Pesquisar: Sistemas operacionais X (Portas) \033[01;37m"
	echo -e "\033[01;35m [3] Hosts Detalhados			     \033[01;37m"
	echo ""
	echo -e -n "\033[01;36m # Opc: \033[01;37m"
	read resp

	# Estrutura de escolha
	case $resp in

	1)	sistemasOperacionais;;
	2)	sistemasPortas;;
	3)	detalhado;;
	*)	;;

    	esac
}

##################
#### Programa ####
##################

# Chamada de metodo
controlador

# Estrutura em loop
while ((1))
do
	clear
	echo -e "\033[01;31m * Author: DarkProgrammer000 \033[01;37m"
	echo -e "\033[01;35m # GitHub: \033[01;37m"
	echo -e "\033[01;32m ============\033[01;37m"
	echo -e "\033[01;36m     NMAP    \033[01;37m"
	echo -e "\033[01;32m ============\033[01;37m"
	echo -e ""
	echo -e "\033[01;31m [1] Escaneamento de Host  \033[01;37m"
	echo -e "\033[01;32m [2] Escaneamento na Rede  \033[01;37m"
	echo -e "\033[01;33m [3] Sair		       \033[01;37m"
	echo -e ""

	# Entrada de dados
	echo -e -n "\033[01;34m # Opc: \033[01;37m"
	read esc

	# Estrutura em escolha
	case $esc in

	1)	hostMenu;;
	2)	netMenu;;
	3)	exit 1;;
	*)	;;
	
	esac
done
