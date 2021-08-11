'''
Programa: Scanner de IP
Ob: Lista de 'ips' + lista de 'portas'
'''

# Bibliotecas
import socket
from os import system

###########
# FUNCOES #
###########

# Metodo: Scanneando Portas + IPs
def scanner(listaPorta, listaIP):

    # Comando de sistema
    system("clear")

    # Estrutura de repeticao: Percorrendo as listas de ips
    for i in range(0, len(listaIP)):

        print("\n ---------------------------------------------------")
        print(" # Alvo: " + str(listaIP[i]))
        print(" --------------------------------------------------- \n")

        # Estrutura de repeticao: Percorrendo as listas de portas
        for j in range(0, len(listaPorta)):

            # Criando conexao + Tempo de verificacao
            client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            client.settimeout(0.15)

            # Resposta do codigo
            codigo = client.connect_ex((str(listaIP[i]), listaPorta[j]))

            # Estrutura de decisao (baseado no codigo)
            if codigo == 0: 
                print(" # Porta Aberta: ", listaPorta[j])
            else:
                print(" X Porta Fechada: ", listaPorta[j])

        print(" --------------------------------------------------- ")

# Execucao do programa
def scanLista():

    # Controle
    contIP = 0
    contPorta = 0

    # Listas
    listaIP = [] # Lista a ser preenchida com IPs
    listaPorta = [] # Lista a ser preenchida com as portas

    print(" # Entre com 5 portas a serem escaneadas: ")

    # Estrutura em loop: Controle de porta
    while contPorta < 5:

        # Entrada de dados
        porta = int(input(" # Porta " + str(contPorta + 1) + ": "))

        # Populando o vetor
        listaPorta.append(porta)

        # Variavel de controle
        contPorta += 1

    # Entrada de dados
    qtd = int(input("\n # Quantidade de hosts (Ex: 3): "))

    # Estrutura em loop: Controle de IP
    while contIP < qtd:

        # Entrada de dados
        ip = input(" # IP (Ex: 192.168.0.1 ou google.com): ")

        # Populando o vetor
        listaIP.append(ip)

        # Variavel de controle
        contIP += 1

    # Chamada de metodo com passagem de parametro (vetor)
    scanner(listaPorta, listaIP)

############
# PROGRAMA #
############

def main():

    # Comando de sistema
    system("clear")

    # Apresentacao
    print("\n ===== PORT SCAN ===== \n")

    # Chamada de metodo
    scanLista()

# Execucao
if __name__ == '__main__':

    try:
        main()

    except Exception as erro:
        print(erro)
