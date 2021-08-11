"""
Programa: Scanner utilizando o 'ping'
"""

# Bibliotecas
from os import system
from ipaddress import ip_address

def apresentacao():

    # Comando de sistema
    system("clear")
    print("\033[01;31m # DARK PROGRAMMER 000 \033[01;37m")

    print("\n ===== PORT SCAN ===== \n")
    system("echo -n ' # IP [externo]: '")
    system("curl ifconfig.me --silent | awk {'print $1'}")

    system("echo -n ' # IP [interno]: '")
    system("hostname -I | awk {'print $1'}")
    print('''\033[01;32m
    		      ..:::::::::..
                  ..:::aad8888888baa:::..
              .::::d:?88888888888?::8b::::.
            .:::d8888:?88888888??a888888b:::.
          .:::d8888888a8888888aa8888888888b:::.
         ::::dP::::::::88888888888::::::::Yb::::
        ::::dP:::::::::Y888888888P:::::::::Yb::::
       ::::d8:::::::::::Y8888888P:::::::::::8b::::
      .::::88::::::::::::Y88888P::::::::::::88::::.
      :::::Y8baaaaaaaaaa88P:T:Y88aaaaaaaaaad8P:::::
      :::::::Y88888888888P::|::Y88888888888P:::::::
      ::::::::::::::::888:::|:::888::::::::::::::::
      ::::::::::::::::8888888888888b::::::::::::::'
       :::::::::::::::88888888888888::::::::::::::
        :::::::::::::d88888888888888:::::::::::::
         ::::::::::::88::88::88:::88::::::::::::
           ::::::::::88::88::88:::88::::::::::'
             ::::::::88::88::P::::88::::::::'
               ::::::88::88:::::::88::::::'
         	    ::::::::::::::::::::
                       ::::::::::
                       \033[01;37m''')

# Funcao: Endereco IP
def qtdHost():
    return int(input("\n# Quantidade de hosts: "))

# Funcao: Endereco IP
def conversao():

    # Entrada de dados
    strIP = input("# Digite IP [192.168.0.1]: ")

    # Transformando: String --> Ipv4
    Ipv4 = ip_address(strIP)

    # Controle: Retornando ao ip passado
    Ipv4 -= 1

    return Ipv4

# Funcao: Lista de IPs (255 hosts)
def hosts(Ipv4, qtdHost):

    # Lista
    listaIPv4 = []

    # Estrutura de repeticao
    for i in range(0, qtdHost):

        # Somando 1 ao IP
        Ipv4 += 1

        # Incremento lista
        listaIPv4.append(Ipv4)

    return listaIPv4

def ping(listaIPv4, arq):

    # Sistema
    system("clear")
    print("\033[01;34m\n ===== PORT SCAN =====\n\033[01;37m")

    # Estrutura de repeticao
    for i in range(0, len(listaIPv4)):

        # Retorno da resposta do codigo: Bash + Python
        codigo = system("ping -c 1 -n -w1 " + str(listaIPv4[i]))

        if codigo == 0:

            # Escrevendo no 'arq'
            arq.write("# %s\n" % listaIPv4[i])

            # Bash + Python
            # system("echo " + str(listaIPv4[i]) + ": Ativo > relatorio.txt")

    # Mensagem: Relatorio
    print("\033[01;34m# Relatorio concluido\033[01;37m")

# Metodo: Principal
def main():

    # Tela inicial
    apresentacao()

    # Arquivo
    arq = open("relatorio.txt", "w")
    arq.write("# %s\n\n" % "Lista de IPs Ativos")

    # Chamada de funcao
    ping(hosts(conversao(),qtdHost()), arq)

# Execucao
if __name__ == '__main__':

    try:
        main()

    except Exception as erro:
        print(erro)
