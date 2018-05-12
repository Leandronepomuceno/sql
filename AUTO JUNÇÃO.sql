/*****************************************************************************************
AUTO JUNÇÃO
*****************************************************************************************/

--CRIA TABELA
create table funcionario
(
	cod_func INT NOT NULL,
	nome varchar(50),
	cod_chefe INT
)
go

--POPULA TABELA
insert into funcionario values (1, 'Maria', 2)
insert into funcionario values (2, 'José', 4)
insert into funcionario values (3, 'João', 2)
insert into funcionario values (4, 'Pedro', 5)
insert into funcionario values (5, 'Matheus', null)
go

--EXEMPLO DE AUTO JOIN -> SELECIONA O NOME DO FUNCIONÁRIO E O NOME DO CHEFE
select	f.nome as func,
		c.nome as chefe
from	funcionario f
		JOIN funcionario as c
		ON f.cod_chefe = c.cod_func
