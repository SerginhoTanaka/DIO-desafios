menu = """
[d] depositar
[s] sacar
[e] extrato
[q] sair
"""
saldo = 0
limite = 500
extrato = ""
numero_saques = 0
LIMITE_SAQUES = 3

while True:
    opcao = input(menu)
    if opcao == 'd':
        valor = float(input("Informe o valor que deseja depositar: "))
        if valor < 1:
            print("Não é possível depositar um valor negativo.")
        else:
            saldo += valor
            extrato += f"Depósito: R$ {valor:.2f}\n"

    elif opcao == 's':
        valor = float(input("Informe o valor que deseja sacar: "))

        if valor <= 0:
            print("Valor inválido.")
        elif valor > saldo:
            print("Saldo insuficiente.")
        elif valor > limite:
            print("Valor excede o limite de saque.")
        elif numero_saques >= LIMITE_SAQUES:
            print("Limite de saques diários excedido.")
        else:
            saldo -= valor
            extrato += f"Saque: R$ {valor:.2f}\n"
            numero_saques += 1

    elif opcao == 'e':
        if not extrato:
            print("Não foram realizadas movimentações.")
        else:
            print(extrato)
            print(f"Saldo: R$ {saldo:.2f}")

    elif opcao == 'q':
        break

    else:
        print("Opção inválida.")
