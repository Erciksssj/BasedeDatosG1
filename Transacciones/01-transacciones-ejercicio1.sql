use NORTHWND

--Transaccion
--Las transacciones en SQL Server son fundamentales par asegurar
--la consistencia y la integridad en una base de datos

--Una transaccion es una unidad de ttrabajo que se ejecuta de manera completamente exitosa
--o no se jecuta en absoluto

--Sigue el principio ACID:
	--Atomicidad: Toda la transaccion se completa o no se realiza nada
	--Consistencia: La transaccion lleva la base de datos de un estado valido
	--a otro
	--Aislamiento:Las transacciones concurrentes no interfieren entre si
	--Durabilidad: Una vez que una transaccion se completa los cambios son permanentes

---Comandos a utilizar:
	--Begin transaction: Inicia una nuema transaccion
	--Commit Transaction: Confirma todos los datos realisados durante la transaccion
	--Rollback transaction: Revierte todos los cambios realizados durante la transaccion


select * from Categories
go
--delete from Categories
--where CategoryID in (10,12)

begin transaction

insert into Categories(CategoryName,Description)
values ('Los remediales', 'No Estara muy bien');
go

rollback transaction
commit transaction

create database pruebatransacciones;
go

use pruebatransacciones
go

create table empleado(
emplid int not null,
nombre varchar(30) not null,
salario money not null,
constraint pk_empleado
primary key (emplid),
constraint chk_salario
check(salario>0.0 and salario<=50000))
go

create or alter procedure spu_agregar_empleado
--paarametros de entrada
@emplid int,
@nombre varchar(30),
@salario money
as
	begin
		begin try
			begin transaction;
			--Inserta en la tabla empleado
			insert into empleado(emplid,nombre,salario)
			values(@emplid,@nombre,@salario);
			--Se confirma la transaccion si todo va bien
			commit transaction;
		end try

		begin catch
			rollback;
			--Obtener el error
			declare @MensajeError	nvarchar(4000)
			set @MensajeError=ERROR_MESSAGE();
			print @MensajeError
		end catch;
	end;
go
exec spu_agregar_empleado 1,'Monico',21000.0

exec spu_agregar_empleado 2,'Toribio',-60000.0

select * from empleado

use NORTHWND