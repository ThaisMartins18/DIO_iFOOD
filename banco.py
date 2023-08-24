menu = """

Escolha uma opção: 
[1] - Depósito
[2] - Saque
[3] - Extrato
[0] - Sair

=> """

saldo = 0
limite = 500
extrato = ""
numero_saques = 0
LIMITE_SAQUES = 3


while True:

    opcao = input("Opção: ")

    if opcao == "1":
        valor = float(input("Digite o valor do depósito: "))

        if valor > 0:
            saldo += valor
            extrato += f"Depósito de R$ {valor:.2f} realizado com sucesso!\n"
    
        else:
            print("Opção inválida! o valor inserido é inválido.")

    elif opcao == "2":
        valor = float(input("Digite o valor do saque: "))

        saldo_excedido = valor > saldo
        limite_excedido = valor > limite
        saques_excedidos = numero_saques >= LIMITE_SAQUES

        if saldo_excedido:
            print("Opção inválida! Saldo insuficiente!")

        elif limite_excedido:
            print("Opção inválida! Valor acima do limite diário!")

        elif saques_excedidos:
            print("Opção inválida! Número máximo de saques excedido!")

        elif valor > 0:
            saldo -= valor
            extrato += f"Saque: R$ {valor:.2f}\n"
            numero_saques += 1

        else:
            print("Opção inválida! O valor informado é inválido!")

    elif opcao == "3":
        print("\n********************** EXTRATO **********************")
        print("Não foram realizadas movimentações." if not extrato else extrato)
        print(f"\nSaldo: R$ {saldo:.2f}")
        print("\n*****************************************************")

    elif opcao == "0":
        print("Obrigada por utilizar nossos serviços, tenha um bom dia!")
        break

    else:
        print("Opção inválida, por favor selecione a opção desejada novamente.")