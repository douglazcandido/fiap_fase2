--Item A, consulta SQL exibindo: código e nome da categoria, código e descrição do produto, valor unitário, tipo de embalagem e percentual do lucro de cada produto. Exibindo inclusive categorias sem produtos via LEFT JOIN (valores = null).

SELECT
    C.CD_CATEGORIA,
    C.DS_CATEGORIA,
    P.CD_PRODUTO,
    P.DS_PRODUTO,
    P.VL_UNITARIO,
    P.TP_EMBALAGEM,
    P.VL_PERC_LUCRO
FROM MC_CATEGORIA_PROD C LEFT JOIN MC_PRODUTO P
ON C.CD_CATEGORIA = P.CD_CATEGORIA
ORDER BY 
    C.DS_CATEGORIA ASC,
    P.DS_PRODUTO ASC;

--Item B, consulta SQL exibindo: Código e nome do cliente, e-mail, telefone, login, data de nascimento (DD/MM/YYYY), dia da semana que o cliente nasceu, quantos anos de vida tem, sexo biológico e seu CPF.

--Professor, aqui entramos em contato pelo Teams para entender como exibir as informações: dia da semana que o cliente nasceu e como mostrar isso em formato CHAR, quantos anos ele tem contando da data fictícia de seu nascimento até o dia de hoje (02/04/2025). Sua mensagem esclareceu as funções TO_CHAR e TRUNC.

SELECT
    C.NR_CLIENTE,
    C.NM_CLIENTE,
    C.DS_EMAIL,
    C.NR_TELEFONE,
    C.NM_LOGIN,
    TO_CHAR(F.DT_NASCIMENTO, 'DD-MM-YYYY')AS DT_NASCIMENTO,
    TO_CHAR(F.DT_NASCIMENTO, 'Day') AS DIA_SEMANA,
    TRUNC(MONTHS_BETWEEN(SYSDATE, F.DT_NASCIMENTO)/12) AS ANOS_DE_VIDA,
    F.FL_SEXO_BIOLOGICO,
    F.NR_CPF
FROM MC_CLIENTE C JOIN MC_CLI_FISICA F 
ON C.NR_CLIENTE = F.NR_CLIENTE
ORDER BY C.NR_CLIENTE;

--ITEM C, Consulta SQL, exibindo: código do produto, nome do produto, data e hora de visualização do produto. Por ordem de Data e Hora mais recente.

--Tivemos um problema: ao rodar o comando SQL que atendia a questão 3 não estávamos tendo nenhum retorno apenas "nenhuma linha foi encontrada" pois como não havia nenhum cliente antes dos criados, não havia nenhuma visualização de vídeo de produtos, portanto usamos os conhecimentos de insert into previamente usados para criar esses registros. Confirmado também via Teams (Obrigado!)

--Checando os vídeos disponíveis da Melhores Compras, para criar a visualização.
SELECT * FROM MC_SGV_PRODUTO_VIDEO

--Gerando uma visualização do cliente “Dwight Schrute” em um dos produtos da melhores compras.
INSERT INTO MC_SGV_VISUALIZACAO_VIDEO (NR_CLIENTE, CD_PRODUTO, NR_SEQUENCIA, DT_VISUALIZACAO, NR_HORA_VISUALIZACAO, NR_MINUTO_VIDEO, NR_SEGUNDO_VIDEO)
VALUES (1, 3, 1, TO_DATE('02/04/2025', 'DD/MM/YYYY'), 19, 49, 10);

--Agora sim atendendo ao pedido do item C, com a visualização que criamos do cliente "Dwight Schrute" feita em um dos vídeos de produtos da Melhores Compras

SELECT
    P.CD_PRODUTO,
    P.DS_PRODUTO,
    V.DT_VISUALIZACAO,
    V.NR_HORA_VISUALIZACAO
FROM
    MC_SGV_VISUALIZACAO_VIDEO V,
    MC_SGV_PRODUTO_VIDEO PV,
    MC_PRODUTO P
WHERE
    V.CD_PRODUTO = PV.CD_PRODUTO AND V.NR_SEQUENCIA = PV.NR_SEQUENCIA AND PV.CD_PRODUTO = P.CD_PRODUTO
ORDER BY
    V.DT_VISUALIZACAO DESC,
    V.NR_HORA_VISUALIZACAO DESC;