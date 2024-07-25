use NORTHWND
go
--Crear un sp que como pararmetro de entrada el nombre de un atbla y visualice todos los registros(spu_mostrar_tabla)

create or alter procedure spu_mostrar_tabla
	@tabla varchar(100)
as
begin
	--Sql Dinamico
	declare @sql nvarchar(max);
	set @sql='Select * from '+ @tabla;
	exec (@sql)
end
go

exec spu_mostrar_tabla 'customers'
GO

create or alter procedure spu_mostrar_tabla2
	@tabla varchar(100)
as
begin
	--Sql Dinamico
	declare @sql nvarchar(max);
	set @sql='Select * from '+ @tabla;
	exec sp_executesql @sql;
end
go
exec spu_mostrar_tabla2'customers'
go