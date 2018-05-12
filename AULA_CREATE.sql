--Exerc�cios CREATE/ALTER TABLE
--Exerc�cios CREATE/ALTER TABLE
- crie uma tabela chamada turma com as seguintes colunas:
nome		tipo		nulo?	PK?
---------	-------		------	----
cod_turma	int			n�o		sim
descricao	varchar(30)	n�o		n�o

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
cod_aluno	int			n�o		sim
nome		varchar(50)	sim		n�o
ativo		bit			sim		n�o
cod_turma	int			sim		n�o (FK para turma.cod_turma)


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
- tente inserir um aluno com um c�digo de turma NULO. O que acontece?
- tente inserir um aluno com um c�digo de turma inexistente. O que acontece?
- tente apagar todos os registros da tabela de turma. O que acontece?
- apague um registro da tabela de aluno

- insira 2 registros na tabela de turma
- insira 5 registros na tabela de alunos
- tente inserir um aluno com um c�digo de turma NULO. O que acontece?
- tente inserir um aluno com um c�digo de turma inexistente. O que acontece?
- tente apagar todos os registros da tabela de turma. O que acontece?
- apague um registro da tabela de aluno