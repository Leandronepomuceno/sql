create table tb_log
(
cd_clien int,
nome_ant varchar(50),
nome_atu varchar(50)
)

drop trigger tg_cliente
go
create trigger tg_cliente on cliente for update
as
insert into tb_log 
select i.cd_clien, d.nome as nome_antigo, i.nome as nome_novo
from inserted i
	join deleted d
	on i.cd_clien = d.cd_clien

update cliente set nome = 'teste' where cd_clien = 1

select * from tb_log