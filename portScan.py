# Bibliotecas
import os
import socket

# Comando de sistema
os.system("clear")

# Apresentacao
print("\n{} PORT SCAN {}\n".format("=-=" * 5, "=-=" * 5))

# Port Scan
def Scanner(portas):

    # Entrada de dados
    host = input("\n- Host: ")

    # Estrutura de repeticao
    for i in range(0, len(portas)):

        # Criando conexao
        client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # Tempo de verificacao
        client.settimeout(0.15)

        # Mensagem de codigo
        codigo = client.connect_ex((str(host), portas[i]))

        # Estrutura de decisao (baseado no codigo)
        if codigo == 0:

            print(" # Porta Aberta: ", portas[i])

        else:
            print(" X Porta Fechada: ", portas[i])

# Execucao do programa
def Executar():

    # Variaveis
    portas = []# Lista a ser preenchida com as portas
    cont_port = 0# Contador de portas

    print("# Entre com as portas a serem escaneadas: ")

    # Estrutura em loop
    while cont_port < 3:

        # Entrada de dados
        p = int(input("Porta: "))

        # Populando o vetor
        portas.append(p)

        # Variavel de controle
        cont_port += 1

    # Chamda de metodo com passagem de paramento (vetor)
    Scanner(portas)

##################
#### PROGRAMA ####
##################

Executar()
