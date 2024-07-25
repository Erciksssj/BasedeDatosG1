
use NORTHWND
--Realizar un estore procedure que actualize los precios de un producto
--y que guarde los datos en otra tabla

create table Precioshistoricos(
Id int identity(1,1) not null,
precioAnterior money not null,
precioNuevo money not null,
fechadeCambio datetime not null default getdate(),
constraint pk_Id
primary key (Id) 
)
drop table Precioshistoricos
go
select * from Precioshistoricos
select * from Products
go
create or alter proc actualizar_precio
	@productoId int, 
	@precioNuevo int 
as
begin
	begin try
	 begin transaction;
		declare @precioAnterior money;

		SELECT @precioAnterior = UnitPrice 
		FROM Products
		WHERE ProductID = @productoId;
		
		UPDATE Products 
		SET UnitPrice = @precioNuevo 
		WHERE ProductID = @productoId;
	
		INSERT INTO Precioshistoricos(precioAnterior,precioNuevo)
		VALUES (@precioAnterior,@precioNuevo);
		commit transaction;
	end try
	begin catch
		rollback 
		declare @MensajeError	nvarchar(4000)
			set @MensajeError=ERROR_MESSAGE();
			print @MensajeError
	end catch
end;
go
exec  actualizar_precio -1,80
go
create or alter proc actualizar_precio2
	@productoId int, 
	@precioNuevo int 
as
begin
	UPDATE Products 
    SET UnitPrice = @precioNuevo 
    WHERE ProductID = @productoId;
	
	declare @precioAnterior money;

	SELECT @precioAnterior = UnitPrice 
    FROM Products
    WHERE ProductID = @productoId;

	INSERT INTO Precioshistoricos(precioAnterior,precioNuevo)
    VALUES (@precioAnterior,@precioNuevo);
end;

--Un sp que elimine una orden completa y actualize los estock en producto
go

create or alter proc eliminar
	@idorden int
as
begin
    declare @cantidad int;

	SELECT @cantidad = Quantity 
    FROM [Order Details]
    WHERE ProductID = @idorden;

	print @cantidad
end;

select * from [Order Details] 
select * from Products
go
exec eliminar 10250