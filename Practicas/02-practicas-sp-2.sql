
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

--sp para actualizar el precio de un pruducto y registrar el cambio 
--1:Crear un sp que se llame actualizar_precio_producto
--2:Crear una tabla que se llame cambio_de_precios
--Los campos que tendra cambioid int identity prymary key
--productoid int not null
--precio_anterior money no t null
--precionuevo money not null
--fechadecambio daytime (getdate)
--3: el sp debe aceptar 2 parametros el produto que voy a cambiar y el nuevo precio
--4:El procedimiento tienen que actualizar el procio en la tabla products
--5:El sp debe ingresar un registro en la tabla cambio de precios con los detalles del cambio


create table cambi_de_precios(
cambioId int identity(1,1) not null,
productoId int not null,
precioAnterior money not null,
precioNuevo money not null,
fechadeCambio datetime not null,
constraint pk_cambioId
primary key (cambioId) 
)

select * from cambi_de_precios
go

create or alter proc actualizar_precio_producto
	@id int,
	@np int
as
begin
	update Products
	set 
	
end;
