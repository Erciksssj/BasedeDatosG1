create database PruebatriggersG1
GO
use PruebatriggersG1
go

create table Empleado(
Idempleado int not null primary key,
nombreEmpl varchar(30) not null,
apellido1 varchar(15) not null,
apellido2 varchar(15) ,
salario money not null );
go
create or alter trigger tg_1
on Empleado
after insert
as
begin
print'se ejecutyo el triger tg_1, en el evento insert'
end
go

select * from Empleado
go

insert into Empleado
values (1,'Erick','Trejo','Resendiz',1200000);
go

drop trigger tg_1
go

create or alter trigger tg_2
on Empleado
after insert
as
begin
select * from inserted;
select * from deleted;
end
go

insert into Empleado
values (2,'Gael Antonio','Estrada','Cabrera',120000);
go

create or alter trigger tg_3
on Empleado
after delete
as
begin
select * from inserted;
select * from deleted;
end
go

delete Empleado
where Idempleado=2
go

create or alter trigger tg_4
on Empleado
after update
as
begin
select * from inserted;
select * from deleted;
end
go

select * from Empleado 
go

update Empleado
set nombreEmpl='Erick',
	salario=100000000000
	where Idempleado=1;
	go

create or alter trigger tg_5
on Empleado
after insert,delete
as
begin
if exists(select 1 from inserted)
begin
print 'Se relaizo un insert'
end
else if exists (select 1 from deleted) and 
not exists (select 1 from inserted)
begin
print'Se relaizo un delete'
end
end
go

insert into Empleado
values(2,'Pancha','Jimenez','Nery',10)

delete from Empleado
where Idempleado=2

