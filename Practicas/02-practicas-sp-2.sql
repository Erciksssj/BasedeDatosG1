
use NORTHWND
--crear un sp que reciba 2 fechas y devuelva una lista de empleados que fueron contratados en ese rango de fechas full name, hire day
select CONCAT(FirstName,' ',LastName) as 'NombreEmpleado'
from Employees
where HireDate between '1992/05/01' and '1993/10/17'
go

create or alter proc sp_empleado
@rango1 date,
@rango2 date
as
begin
select CONCAT(FirstName,' ',LastName) as 'NombreEmpleado'
from Employees
where HireDate between @rango1 and @rango2
end
go

execute sp_empleado '1992/05/01', '1993/10/17'

select * from Employees
go
--===================================================================================================================================================
--sp para actualizar el precio de un pruducto y registrar el cambio 
--1:Crear un sp que se llame actualizar_precio_producto
create or alter proc actualizar_precio_producto
as
begin
end;
go
--==================================================================================================================
--2:Crear una tabla que se llame cambio_de_precios
--Los campos que tendra cambioid int identity prymary key
--productoid int not null
--precio_anterior money no t null
--precionuevo money not null
--fechadecambio datetime (getdate)
create table cambi_de_precios(
cambioId int identity(1,1) not null,
productoId int not null,
precioAnterior money not null,
precioNuevo money not null,
fechadeCambio datetime not null default getdate(),
constraint pk_cambioId
primary key (cambioId) 
)
go
drop table cambi_de_precios
--==================================================================================================================
--3: el sp debe aceptar 2 parametros el produto que voy a cambiar y el nuevo precio
create or alter proc actualizar_precio_producto
	@productoId int, --Id del producto
	@np int --Nuevo precio
as
begin
end;
go
--==================================================================================================================
--4:El procedimiento tienen que actualizar el precio en la tabla products
create or alter proc actualizar_precio_producto
	@productoId int, --Id del producto
	@np int --Nuevo precio
as
begin
	UPDATE Products --actualizar tabla de productos de NORTWND
    SET UnitPrice = @np --colocar en valor de uniteprice en la variable np
    WHERE ProductID = @productoId;-- donde PoductoId sea igual al valor ingresado en la variable productoId
end;
go
--==================================================================================================================
--5:El sp debe ingresar un registro en la tabla cambio de precios con los detalles del cambio
create or alter proc actualizar_precio_producto2
	@productoId int, --Id del producto
	@precioNuevo int --Nuevo precio
as
begin
	UPDATE Products --actualizar tabla de productos de NORTWND
    SET UnitPrice = @precioNuevo --colocar en valor de uniteprice en la variable np
    WHERE ProductID = @productoId;-- donde PoductoId sea igual al valor ingresado en la variable productoId
	
	declare @precioAnterior money;--Declarar una variable para almacenar el precio anterior

	SELECT @precioAnterior = UnitPrice --colocar en valor de uniteprice en la variable pv
    FROM Products --de la tabla Products
    WHERE ProductID = @productoId; --Donde el productoId sea igual igual al valor ingresado en la variable productoId

	INSERT INTO cambi_de_precios(productoId,precioAnterior,precioNuevo)
    VALUES (@productoId,@precioAnterior,@precioNuevo);
end;
go

exec actualizar_precio_producto2 1,45

exec actualizar_precio_producto 1,20

select * from cambi_de_precios

select ProductName,UnitPrice from Products

use NORTHWND