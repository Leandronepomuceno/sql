O QUE FAZ O COMANDO INNER JOIN?
O QUE FAZ O COMANDO LEFT/RIGHT OUTER JOIN?
O QUE FAZ O COMANDO CROSS JOIN?

--SELECIONE O NOME DO VENDEDOR E A DESCRI��O DE SUA EQUIPE
SELECT	V.NOME, 
		E.DESCRICAO
FROM	VENDEDOR V
		JOIN EQUIPE E
		ON V.CD_EQUIPE = E.CD_EQUIPE

--SELECIONE O NOME DO VENDEDOR E A DESCRI��O DE SUA EQUIPE DE TODOS OS VENDEDORES QUE PERTENCEM � EQUIPE DE DESCRI��O "KEY-ACCOUNT"
SELECT	V.NOME, 
		E.DESCRICAO
FROM	VENDEDOR V
		JOIN EQUIPE E
		ON V.CD_EQUIPE = E.CD_EQUIPE
WHERE	E.DESCRICAO = 'KEY-ACCOUNT'

--SELECIONE A DESCRICAO DO PRODUTO E A DESCRI��O DA LINHA DE TODOS OS PRODUTOS ATIVOS
SELECT	P.DESCRICAO, 
		L.DESCRICAO
FROM	PRODUTO P
		JOIN LINHA L
		ON P.CD_LINHA = L.CD_LINHA
WHERE	P.ATIVO = 1


--SELECIONE A DESCRI��O DO PRODUTO, A DESCRI��O DA UNIDADE E O FATOR DA UNIDADE DE TODAS AS UNIDADES DISPON�VEIS PARA O 
--PRODUTO DE C�DIGO 1083
SELECT	P.DESCRICAO,
		U.DESCRICAO,
		UP.FATOR
FROM	PRODUTO P
		JOIN UNID_PROD UP
			JOIN UNIDADE U
			ON UP.UNIDADE = U.UNIDADE
		ON P.CD_PROD = UP.CD_PROD
WHERE	P.CD_PROD = 1083

--SELECIONE A DESCRI��O DO PRODUTO, A DESCRI��O DA UNIDADE E O FATOR DA UNIDADE DE TODOS OS PRODUTOS QUE POSSUEM A LINHA COM
--DESCRI��O "APERITIVOS". BUSQUE APENAS AS QUANTIDADES DA UNIDADE CAIXA.
SELECT	P.DESCRICAO,
		U.DESCRICAO,
		UP.FATOR
FROM	PRODUTO P
		JOIN UNID_PROD UP
			JOIN UNIDADE U
			ON UP.UNIDADE = U.UNIDADE
		ON P.CD_PROD = UP.CD_PROD
		JOIN LINHA L
		ON P.CD_LINHA = L.CD_LINHA
WHERE	L.DESCRICAO = 'APERITIVOS'
		AND U.UNIDADE = 'CX'


--SELECIONE O NOME DO CLIENTE, O TIPO DO TELEFONE, E O N�MERO DO TELEFONE DO CLIENTE DE C�DIGO 1
SELECT	C.NOME,
		T.TP_TEL,
		T.NUMERO
FROM	CLIENTE C
		JOIN TELEFONE T
		ON C.CD_CLIEN = T.CD_CLIEN
WHERE	C.CD_CLIEN = 1

--SELECIONE O NOME DO CLIENTE E O N�MERO DO FAX DO CLIENTE DE C�DIGO 1
SELECT	C.NOME,
		T.NUMERO
FROM	CLIENTE C
		JOIN TELEFONE T
		ON C.CD_CLIEN = T.CD_CLIEN
WHERE	C.CD_CLIEN = 1
		AND T.TP_TEL = 'FX'



--SELECIONE O N�MERO DA NOTA FISCAL, O NOME DO CLIENTE E O NOME DO VENDEDOR DA NOTA FISCAL DE N�MERO 285136
SELECT	N.NU_NF, C.NOME, V.NOME
FROM	NOTA N
		JOIN CLIENTE C
		ON N.CD_CLIEN = C.CD_CLIEN

		JOIN VENDEDOR V
		ON N.CD_VEND = V.CD_VEND
WHERE	N.NU_NF = 285136


--SELECIONE O N�MERO DA NOTA FISCAL, O NOME DO CLIENTE, O NOME DO VENDEDOR E A DESCRI��O DA EQUIPE DO VENDEDOR DA NOTA FISCAL DE N�MERO 285136
SELECT	N.NU_NF, C.NOME, V.NOME, E.DESCRICAO
FROM	NOTA N
		JOIN CLIENTE C
		ON N.CD_CLIEN = C.CD_CLIEN

		JOIN VENDEDOR V
			JOIN EQUIPE E
			ON V.CD_EQUIPE = E.CD_EQUIPE
		ON N.CD_VEND = V.CD_VEND
WHERE	N.NU_NF = 285136

--SELECIONE A DATA DE EMISS�O DA NOTA, O NOME DO VENDEDOR, A DESCRI��O DE SUA EQUIPE E O NOME DO CLIENTE DE TODAS AS NOTAS FISCAIS
SELECT	N.DT_EMISSAO, V.NOME, E.DESCRICAO, C.NOME
FROM	NOTA N
		JOIN VENDEDOR V
			JOIN EQUIPE E
			ON V.CD_EQUIPE = E.CD_EQUIPE
		ON N.CD_VEND = V.CD_VEND

		JOIN CLIENTE C
		ON N.CD_CLIEN = C.CD_CLIEN

--LEFT JOIN: SELECIONE O NOME DE TODOS OS CLIENTES E A QUANTIDADE TOTAL DE COMPRAS. SE O CLIENTE NUNCA COMPROU NADA, MESMO ASSIM SELECIONE SEU NOME
--E O VALOR 0 (ZERO) DEVE SER APRESENTADO COMO QUANTIDADE DE COMPRAS.

SELECT	C.NOME,
		ISNULL(SUM (VL_TOTAL), 0)
FROM	CLIENTE C
		LEFT JOIN NOTA N
		ON C.CD_CLIEN = N.CD_CLIEN
GROUP BY C.NOME

--SELECIONE O NOME DO CLIENTE E A QUANTIDADE TOTAL DE TELEFONES DE TODOS OS CLIENTES. SE UM CLIENTE N�O POSSUIR NENHUM TELEFONE, SEU NOME DEVE SER
--RETORNADO E QUANTIDADE DE TELEFONES DEVE SER IGUAL A ZERO
SELECT	C.NOME,
		ISNULL(COUNT (*), 0)
FROM	CLIENTE C
		LEFT JOIN TELEFONE T
		ON C.CD_CLIEN = T.CD_CLIEN
GROUP BY C.NOME
		
--SELECIONE A DESCRI��O DA EQUIPE E A QUANTIDADE DE VENDEDORES DE CADA EQUIPE
SELECT	E.DESCRICAO,
		COUNT (*)
FROM	EQUIPE E
		JOIN VENDEDOR V
		ON E.CD_EQUIPE = V.CD_EQUIPE
GROUP BY 
		E.DESCRICAO
		
--SELECIONE A DESCRICAO DA LINHA E A QUANTIDADE DE PRODUTOS ATIVOS DE TODAS AS LINHAS ATIVAS
--ORDENE O RESULTADO PELO TOTAL DE PRODUTOS EM ORDEM DECRESCENTE (DAS LINHAS QUE POSSUEM MAIS PRODUTOS PARA AS QUE POSSUEM MENOS)
SELECT	L.DESCRICAO,
		COUNT (*) AS TOTAL
FROM	LINHA L
		JOIN PRODUTO P
		ON L.CD_LINHA = P.CD_LINHA
WHERE	L.ATIVO = 1
		AND P.ATIVO = 1
GROUP BY 
		L.DESCRICAO
ORDER BY 
		TOTAL DESC





--PROBLEMA: O DEPARTAMENTO DE VENDAS REPORTOU UMA INCONSIST�NCIA NO SISTEMA INTERNO DE VENDAS: SEMPRE QUE SOLICITAM UM 
--RELAT�RIO DE VENDAS DO PRODUTO DE C�DIGO 1103 ANALISADO POR TOTAL DE D�ZIAS VENDIDAS, A INFORMA��O N�O BATE COM A QUANTIDADE
--TOTAL DE UNIDADES VENDIDAS / 12. POR EXEMPLO: NO DIA 01/10 FORAM VENDIDAS 24 UNIDADES, QUANDO ESTA INFORMA��O � AGRUPADA 
--EM D�ZIA, � EXIBIDO O VALOR 2.18, QUANDO O CORRETO SERIA 2 (2*12 = 24).
--VOC� DESCONFIA QUE TRATA-SE DE UM PROBLEMA DE CADASTRO. 
--ANALISE O MODELO DE DADOS DO SISTEMA E INFORME QUAL � O PROBLEMA. ESCREVA O COMANDO SELECT NECESS�RIO PARA EXIBIR A EVID�NCIA
--DO ERRO.

SELECT * FROM UNID_PROD WHERE CD_PROD = 1103


--SELECIONE O NOME DO CLIENTE E A SOMA DE TODAS AS VENDAS DO CLIENTE DE C�DIGO 45
SELECT	C.NOME,
		SUM (N.VL_TOTAL)
FROM	CLIENTE C
		JOIN NOTA N
		ON C.CD_CLIEN = N.CD_CLIEN
WHERE	C.CD_CLIEN = 45
GROUP BY 
		C.NOME

--SELECIONE O NOME DO CLIENTE, SOMA DE TODAS SUAS VENDAS, A MENOR COMPRA, A MAIOR COMPRA, A M�DIA DE COMPRAS 
--E A QUANTIDADE TOTAL DE COMPRAS DO CLIENTE DE C�DIGO 45
--(ANALISE O RESULTADO E VEJA SE FAZ SENTIDO. DEPOIS NAVEGUE NA TABELA DE NOTAS RESTRINGINDO PELO C�DIGO DO CLIENTE PARA ENTENDER MELHOR O RESULTADO DA SUA QUERY)
SELECT	C.NOME,
		SUM (N.VL_TOTAL),
		MIN (N.VL_TOTAL),
		MAX (N.VL_TOTAL),
		AVG(N.VL_TOTAL),
		COUNT (N.VL_TOTAL)
FROM	CLIENTE C
		JOIN NOTA N
		ON C.CD_CLIEN = N.CD_CLIEN
WHERE	C.CD_CLIEN = 45
GROUP BY 
		C.NOME

--SELECIONE A DESCRI��O DO PRODUTO E A SOMA TOTAL DE VENDAS DO PRODUTO
SELECT	P.DESCRICAO,
		SUM (IT.VL_UNIT * IT.QTDE)
FROM	PRODUTO P
		JOIN IT_NOTA IT
		ON P.CD_PROD = IT.CD_PROD
GROUP BY P.DESCRICAO

--SELECIONE A DESCRI��O DA LINHA DO PRODUTO E A SOMA TOTAL DE VENDAS DA LINHA
SELECT	L.DESCRICAO,
		SUM (IT.VL_UNIT * IT.QTDE)
FROM	PRODUTO P
		JOIN IT_NOTA IT
		ON P.CD_PROD = IT.CD_PROD
	
		JOIN LINHA L
		ON P.CD_LINHA = L.CD_LINHA
GROUP BY L.DESCRICAO


--DESAFIO: FA�A UM RELAT�RIO DE TOTAL DE VENDAS POR ESTADO
SELECT	C.UF,
		SUM (VL_TOTAL)
FROM	NOTA N
		JOIN CLIENTE C
		ON N.CD_CLIEN = C.CD_CLIEN
GROUP BY C.UF

--DESAFIO: SELECIONE A DESCRI��O DO PRODUTO, A QUANTIDADE DE UNIDADES VENDIDAS, E A QUANTIDADE DE CAIXAS VENDIDAS DO PRODUTO DE C�DIGO 135055
SELECT	P.DESCRICAO,
		SUM (QTDE),
		SUM (QTDE) / UP.FATOR
FROM	PRODUTO P
		JOIN IT_NOTA IT
		ON IT.CD_PROD = P.CD_PROD

		JOIN UNID_PROD UP
			JOIN UNIDADE U
			ON U.UNIDADE = UP.UNIDADE
		ON UP.CD_PROD = P.CD_PROD
		AND UP.UNIDADE = 'CX'
WHERE	P.CD_PROD = 135055
GROUP BY P.DESCRICAO, UP.FATOR


--::::UM PASSO ADIANTE:::: PARAB�NS! SE VOC� CHEGOU AT� AQUI, � PORQUE J� CONHECE A ESTRUTURA B�SICA DO COMANDO SELECT, J� CONHECE ALGUMAS FUN��ES E
--J� SABE JUNTAR DADOS DE MAIS DE UMA TABELA. SE AINDA ESTIVER INSEGURO NOS COMANDOS QUE J� APRENDEMOS, VOLTE E FA�A NOVAMENTE.
--SE ESTIVER TUDE BEM, ENT�O VAMOS EVOLUIR UM POUCO, E APLICAR NOSSO CONHECIMENTO EM TABELAS DE SISTEMA DO SQL SERVER!!!

--TAREFAS DBA: CONSTANTEMENTE O DBA DEVE VERIFICAR COMO ANDAM AS CONEX�ES AO BANCO DE DADOS. NOSSA TAREFA AGORA � LISTAR TODAS AS CONEX�ES ATIVAS
--"PENDURADAS" NO BANCO DE DADOS "TESTE". OU SEJA, LISTE O ID DE TODOS OS PROCESSOS CONECTADOS AO NOSSO BANCO DE DADOS.
--DICA: VOC� J� SABE USAR O COMANDO JOIN PARA JUNTAR V�RIAS TABELAS, E TAMB�M J� SABE COMO USAR O COMANDO SELECT DE V�RIAS FORMAS, ENT�O ANALISE A
--ESTRUTURA E DADOS DAS TABELAS "MASTER..SYSPROCESSES" (POSSUI TODOS OS PROCESSOS ATIVOS DO SERVIDOR) E "SYS.DATABASES" (CADASTRO DE TODOS OS BANCOS
--DE DADOS DO SERVIDOR) PARA REALIZAR ESTA TAREFA. VERIFIQUE QUAIS AS CHAVES QUE RELACIONAM ESTAS TABELAS ENTRE SI.
--LEMBRE-SE QUE NO DIA-A-DIA DO TRABALHO, VOC� TER� QUE PENSAR BASTANTE PARA RESOLVER ESTE TIPO DE PROBLEMA, PORTANTO TENTE FAZ�-LO ANTES DE 
--PEDIR AJUDA!

SELECT	DB.NAME, 
		DB.CREATE_DATE, 
		DB.COLLATION_NAME,
		P.SPID
FROM	MASTER..SYSPROCESSES P
		JOIN SYS.DATABASES DB
		ON P.DBID = DB.DATABASE_ID
WHERE	DB.NAME = 'TESTE'

--TAREFAS DE DBA: MONTE UM COMANDO PARA RETORNAR O NOME DAS COLUNAS E SEUS RESPECTIVOS TIPOS DE DADOS DA TABELA "CLIENTE" DO NOSSO MODELO DE DADOS
--DICA: USE AS TABELAS SYSOBJECTS (POSSUI TODAS AS TABELAS DO NOSSO MODELO), SYSCOLUMNS (POSSUI TODAS AS COLUNAS DAS TABELAS DO NOSSO MODELO),
--E SYS.TYPES (POSSUI O NOME DE TODOS OS TIPOS DE DADOS DO BANCO DE DADOS). ESTUDE A ESTRUTURA DESTAS TABELAS E DESCUBRA QUAIS AS CHAVES QUE AS
--RELACIONAM.
--O RESULTADO FINAL DEVE SER:

CAMPO		TIPO
--------	--------
cd_clien	int
nome		varchar
uf			char
cidade		varchar
bairro		varchar
endereco	varchar
tp_pes		char
ativo		bit

