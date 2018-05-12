SELECT * FROM cliente ORDER BY NEWID()

DECLARE @var VARCHAR(10)
DECLARE cur_unidade CURSOR FOR
	SELECT	
		unidade
	FROM	
		unidade

OPEN cur_unidade
FETCH NEXT FROM cur_unidade INTO @var

WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT 'Unidade: ' + @var
			--fetch no cursor
			FETCH NEXT FROM cur_unidade INTO @var
			print @@FETCH_STATUS
		END
	print @@FETCH_STATUS
	CLOSE cur_unidade
	DEALLOCATE cur_unidade
GO


DECLARE @spid VARCHAR(10)
DECLARE cur_processos CURSOR FOR
	select	p.spid
	from	sys.databases d
			join master..sysprocesses p
			on d.database_id = p.dbid
	where	d.name = 'teste'
			and p.spid <> @@spid

OPEN cur_processos
FETCH NEXT FROM cur_processos INTO @spid

WHILE @@FETCH_STATUS = 0
		BEGIN
			exec ('kill  ' + @spid )
			--fetch no cursor
			FETCH NEXT FROM cur_processos INTO @spid
			print @@FETCH_STATUS
		END
	print @@FETCH_STATUS
	CLOSE cur_processos
	DEALLOCATE cur_processos
GO

