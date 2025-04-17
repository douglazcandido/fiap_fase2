import json

calcular_icms = lambda valor: round(valor * 0.18, 2)

def input_texto(mensagem):
    while True:
        valor = input(mensagem).strip()
        if valor:
            return valor.upper()
        print('O campo não pode estar vazio.')

def input_float(mensagem):
    while True:
        try:
            valor = float(input(mensagem).replace(',', '.'))
            if valor <= 0:
                raise ValueError('O valor deve ser maior que zero.')
            return valor
        except ValueError as e:
            print(f'Erro: {e}')

def cadastrar_produtos():
    produtos = []

    while True:
        opcao = input('Deseja cadastrar um novo produto [sim/não]? ').strip().lower()
        if opcao not in ['sim', 'não', 'nao']:
            continue
        if opcao in ['não', 'nao']:
            break

        descricao = input_texto('Descrição do Produto: ')
        embalagem = input_texto('Tipo de Embalagem: ')
        valor = input_float('Valor do Produto (R$): ')

        produto = {
            'descricao': descricao,
            'tipo_embalagem': embalagem,
            'valor_produto': valor,
            'valor_icms': calcular_icms(valor)
        }

        produtos.append(produto)

    return produtos

def salvar_json(produtos, nome_arquivo='1_5_arquivo_produto.json'):
    if len(produtos) >= 5:
        with open(nome_arquivo, 'w', encoding='utf-8') as f:
            json.dump(produtos, f, ensure_ascii=False, indent=4)
        print(f'Arquivo {nome_arquivo} criado com sucesso!')
    else:
        print('É necessário cadastrar no mínimo 5 produtos.')

# Execução principal
if __name__ == '__main__':
    produtos = cadastrar_produtos()
    salvar_json(produtos)
