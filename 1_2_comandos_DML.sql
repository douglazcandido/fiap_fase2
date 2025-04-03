--Resposta do Comando SQL item a)

--Primeiro cliente criado
INSERT INTO mc_cliente (nm_cliente, ds_email, st_cliente, nm_login, ds_senha)
	VALUES ('Dwight Kurt Schrute', 'dwight.schrute@email.com', 'A', 'dwight.schrute', 'senha123')

--Cadastrando cliente criado como pessoa física
INSERT INTO MC_CLI_FISICA (NR_CLIENTE, NR_CPF, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO)
	VALUES (1, '65106286000', TO_DATE('20/01/1966', 'DD/MM/YYYY'), 'M', 'Homem Cisgênero');

--Checando códigos disponíveis de logradouro
SELECT CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO
FROM MC_LOGRADOURO

--Cliente "Dwight Schrute" com endereço cadastrado
INSERT INTO MC_END_CLI (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DS_COMPLEMENTO_END, ST_END)
	VALUES (1, 5, '123', 'Fazenda Schrute', 'A');

--Segundo Cliente criado
INSERT INTO mc_cliente (nm_cliente, ds_email, st_cliente, nm_login, ds_senha)
	VALUES ('Dunder Mifflin', 'dunder.mifflin@email.com', 'A', 'dunder.mifflin', 'papel123');

--Cadastrando o cliente criado como pessoa jurídica
INSERT INTO MC_CLI_JURIDICA (NR_CLIENTE, DT_FUNDACAO, NR_CNPJ, NR_INSCR_EST)
	VALUES (2, TO_DATE('01/01/1949', 'DD/MM/YYYY'), '94697384000197', '746136685718');

--Alterando o CNPJ da empresa 'Dunder Mifflin' para 14 dígitos (havíamos gerado um com 15 dígitos de forma equivocada)
UPDATE MC_CLI_JURIDICA
SET NR_CNPJ = '94697384000197'
WHERE NR_CLIENTE = 2;

--Cliente "Dunder Mifflin" com endereço cadastrado
INSERT INTO MC_END_CLI (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DS_COMPLEMENTO_END, ST_END)
	VALUES (2, 6, '987', 'Rua do papel', 'A');

--Resposta do Comando SQL item b)

INSERT INTO mc_cliente (nm_cliente, ds_email, st_cliente, nm_login, ds_senha)
	VALUES ('Mose Schrute', 'mose.schrute@email.com', 'A', 'dwight.schrute', 'senha123')

--O erro: “ORA-00001: restrição exclusiva (RM561788.UK_MC_CLIENTE_MM_LOGIN) violada”, ocorreu pois o nm_login deve ser único devido a constraint unique no mesmo. Ao tentar cadastrar o usuário Mose Schrute com o mesmo nm_login já cadastrado pelo Dwight Schrute, o erro ocorreu. Portanto, não foi possível realizar o cadastro.

--Resposta do Comando SQL item c)

--Consultando os salários, códigos e nomes dos funcionários da Melhores Compras
SELECT VL_SALARIO, CD_FUNCIONARIO, NM_FUNCIONARIO
FROM MC_FUNCIONARIO

--Consultando os salários, códigos e cargos dos funcionários da Melhores Compras
SELECT VL_SALARIO, CD_FUNCIONARIO, DS_CARGO
FROM MC_FUNCIONARIO 

--Atualizando o cargo da funcionária 'Rachel Karen Green' e aumentando o salário em 12%.
UPDATE MC_FUNCIONARIO
SET 
    DS_CARGO = 'Especialista de vendas',
    VL_SALARIO = 4867.55 * 1.12
WHERE CD_FUNCIONARIO = 2

--Resposta do Comando SQL item d)

--Realizando o update no status do endereço de ‘Dunder Mifflin’, adicionando uma data de término do endereço (22/04/2025). A empresa possui o código 2.
UPDATE MC_END_CLI
SET ST_END = 'I',
    DT_TERMINO = TO_DATE('22/04/2025', 'DD/MM/YYYY')
WHERE NR_CLIENTE = 2;

--Resposta do Comando SQL item e)

--Sabemos que Dwight mora no código logradouro 5 que equivale ao bairro 3 (Santa Efigênia), um bairro do estado de SP. Portanto tentaremos deletar SP de MC_ESTADO.

DELETE FROM MC_ESTADO
WHERE SG_ESTADO = 'SP';

--Recebemos o erro: “Relatório de erros - ORA-02292: restrição de integridade (RM561788.FK_MC_CIDADE_ESTADO) violada - registro filho localizado”. A exclusão de ‘SP’ não foi possível pois SG_ESTADO é uma Foreign Key presente em MC_CIDADE e consequentemente afeta o MC_END_CLI onde Dwight está cadastrado. Por isso o registro filho. Portanto, não foi possível fazer a exclusão.

--Resposta do Comando SQL item f)

--Checando os produtos, nomes e status dos produtos da Melhores Compras.
SELECT CD_PRODUTO, DS_PRODUTO,ST_PRODUTO
FROM MC_PRODUTO;

--Tentativa de realizar um UPDATE no STATUS de “A” para “X” do “Notebook Dell Inspiron 15”.
UPDATE MC_PRODUTO
SET ST_PRODUTO = 'X'
WHERE CD_PRODUTO = 1;

--Recebemos o erro: “Relatório de erros - ORA-02290: restrição de verificação (RM561788.MC_PRODUTO_CK_ST_PROD) violada”. A alteração não foi possível devido a constraint que permite apenas os valores “A”(ativo) “I”(inativo) para os produtos da Melhores Compras. Como “X” não é um valor válido, a alteração foi impedida.

--Resposta do Comando SQL item g)

COMMIT;
