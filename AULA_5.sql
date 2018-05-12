--atualize o tipo de pessoa do cliente de código 1 para "F"
update	cliente
set		tp_pes = 'F'
where	cd_clien = 1

--Atualize o cadastro do cliente de código 2 para INATIVO
update cliente
set		ativo = 0
where cd_clien = 2

--retire os acentos do nome do cliente de código 20030
update cliente
set		nome = replace (replace (nome, 'á', 'a'), 'é', 'e')
where	cd_clien = 20030

--apague todos os telefones do cliente de código 3

--apague o telefone de FAX do cliente de código 1

--apague a nota fiscal de código 284564

--apague todos os cliente inativos que nunca realizaram compras
begin tran
delete from telefone
where exists 
(
select 1 from cliente c
where telefone.cd_clien = c.cd_clien and  not exists (select 1 from nota n where n.cd_clien = c.cd_clien)
		and c.ativo = 0
)

delete from cliente
where not exists (select 1 from nota n where n.cd_clien = cliente.cd_clien)
		and ativo = 0



--crie uma coluna na tabela de cliente chamada "possui_venda", do tipo char(1).
--atualize a coluna para "S", se o cliente aparecer na tabela de vendas
--atualize a coluna para "N", se o cliente nunca apareceu na tabela de venda
alter table cliente add possui_venda char(1) default 'N'

update cliente
set		possui_venda = 'S'
where	exists (select 1 from nota n where cliente.cd_clien = n.cd_clien)

--insira 5 registros na tabela de clientes

--insira 5 registros na tabela de vendedor

--Exercícios CREATE/ALTER TABLE
--Exercícios CREATE/ALTER TABLE
- crie uma tabela chamada turma com as seguintes colunas:
nome		tipo		nulo?	PK?
---------	-------		------	----
cod_turma	int			não		sim
descricao	varchar(30)	não		não

CREATE TABLE TURMA 
(
	COD_TURMA INT NOT NULL,
	DESCRICAO VARCHAR(30) NOT NULL
)

ALTER TABLE TURMA
ADD CONSTRAINT PK_TURMA
PRIMARY KEY (COD_TURMA)

- crie uma tabela chamada ALUNO com as seguintes colunas:
nome		tipo		nulo?	PK?
---------	-------		------	----
cod_aluno	int			não		sim
nome		varchar(50)	sim		não
ativo		bit			sim		não
cod_turma	int			sim		não (FK para turma.cod_turma)


CREATE TABLE ALUNO 
(
	COD_ALUNO INT NOT NULL,
	NOME VARCHAR(50) NULL,
	ATIVO BIT NULL,
	COD_TURMA INT NULL
)

ALTER TABLE ALUNO
ADD CONSTRAINT PK_ALUNO
PRIMARY KEY (COD_ALUNO)

ALTER TABLE ALUNO
ADD CONSTRAINT FK_ALUNO_COD_TURMA
FOREIGN KEY (COD_TURMA)
REFERENCES TURMA(COD_TURMA)


- insira 2 registros na tabela de turma
- insira 5 registros na tabela de alunos
- tente inserir um aluno com um código de turma NULO. O que acontece?
- tente inserir um aluno com um código de turma inexistente. O que acontece?
- tente apagar todos os registros da tabela de turma. O que acontece?
- apague um registro da tabela de aluno

- insira 2 registros na tabela de turma
- insira 5 registros na tabela de alunos
- tente inserir um aluno com um código de turma NULO. O que acontece?
- tente inserir um aluno com um código de turma inexistente. O que acontece?
- tente apagar todos os registros da tabela de turma. O que acontece?
- apague um registro da tabela de aluno