--Erick Trejo Resendiz
use BDEJEMPLO2
go
--realiza un store procedure que se llame spu_ObtenerInformacionCliente, debe realizar lo siguiente:
--Se debe regresar el nombre del cliente y el representante mediante parámetros de salida. 
--Se debe enviar al sp el numero de cliente para obtener esta información
--Se debe validar que el cliente tiene representante, si existe entonces regresar el nombre del cliente y el del representante, 
--de lo contrario regresar en el parámetro de salida para el nombre del representante la palabra No asignado
create or alter proc spu_ObtenerInformacionCliente
	@numero int,
	@nombre varchar(20) output,
	@representante varchar(16) output
as
	begin
	select @numero=c.Num_Cli,@nombre=c.Empresa,@representante=r.Nombre
	from Clientes as c
	inner join Representantes as r
	on c.Rep_Cli=r.Num_Empl
end
go
declare @nom varchar(20)
declare @repre varchar(16) 
exec spu_ObtenerInformacionCliente 2102,@nombre=@nom output,@representante=@repre output
print @nom
print @repre
go
create or alter proc spu_realizar_pedido
	@numero int
as
	begin
	declare @rep varchar(16) 
	declare @nombre varchar(20) 

	select @rep=Nombre
	from Representantes
	where Nombre=@rep

		if exit @rep
			begin
			end
		else
			begin
				set @mensaje='No existe suficiente stock'
			end
end
go
--Se debe validar que el cliente tiene representante, si existe entonces regresar el nombre del cliente y el del representante, 
--de lo contrario regresar en el parámetro de salida para el nombre del representante la palabra No asignado
--Realiza un store procedure que se llame spu_ActualizarLimiteCredito, debe realizar lo siguiente:
--El store debe actualizar el límite de crédito de un cliente dado, 
--y regresar como respuesta en un parámetro de salida la sentencia Limite de crédito actualizado correctamente 
--si El límite de crédito actual es menor al nuevo limite, 
--de lo contrario debe regresar la sentencia El nuevo límite de crédito debe ser mayor al actual
create or alter proc spu_ActualizarLimiteCredito
	@nuc int,
	@nc money,
	@mensaje nchar(50) output
as
	begin
	declare @lim int
	SELECT @lim = Limite_Credito
    FROM Clientes
    WHERE Num_Cli = @nuc; 

	if @nc<@lim
			begin
				update Clientes
				set @nc=@lim
				where Num_Cli=@nuc
				set @mensaje='Crédito actualizado correctamente'
			end
		else
			begin
				set @mensaje='El nuevo límite de crédito debe ser mayor al actual'
			end
end

declare @salida nvarchar(50)
exec spu_ActualizarLimiteCredito 2101,666000,@mensaje=@salida output
print @salida