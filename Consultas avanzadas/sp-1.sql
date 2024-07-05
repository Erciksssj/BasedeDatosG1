--Store procedures
USE NORTHWND
CREATE PROCEDURE sp_prueba_g1
as
BEGIN
    PRINT 'HolaMundo';
END

--Ejecutar store procedure
EXEC sp_prueba_g1

--Declarar variable en transac
DECLARE @n INT
DECLARE @i INT

SET @n = 5
SET @i = 1

PRINT('El valor de n es : ' + cast(@n as varchar))
PRINT('El valor de i es : ' + cast(@i as varchar))

--store procedure
CREATE database prueba_sp
use prueba_sp


CREATE proc sp_1
as
BEGIN

    DECLARE @n INT
    DECLARE @i INT

    SET @n = 5
    SET @i = 1

    PRINT('El valor de n es : ' + cast(@n as varchar))
    PRINT('El valor de i es : ' + cast(@i as varchar))
END

EXEC sp_1

--Ejecuatar 10 veces sp_1 solamente si el centinela es 1

declare @n as int = 10, @i INT=1
WHILE @i<=@n
BEGIN
    PRINT(@i)
    SET @i+=1
--set @@i=@+1
END
--Store precedure con parametros de entrada
CREATE proc sp_2
as
BEGIN
    declare @n as int = 10, @i INT=1
    WHILE @i<=@n
BEGIN
        PRINT(@i)
        SET @i+=1
    END
END

EXECUTE sp_2

--Store precedure con parametros de entrada
create PROC sp_3
    @n INT--parametro de entrada
as
BEGIN
    declare @i int=1
    if @n>0
   
BEGIN
        WHILE @i<=@n
 BEGIN
            PRINT(@i)
            SET @i+=1
        END
    END
ELSE
BEGIN
        PRINT('El valor de n debe ser mayor a 0')
    END
END

EXEC sp_3 -1

create or ALTER PROC sp_4
    @n INT--parametro de entrada
as
BEGIN
    declare @i int=1, @r int=0
    if @n>0
   
BEGIN
        WHILE @i<=@n
 BEGIN
            SET @r=@r+@i

            SET @i+=1
        END
        PRINT('La suma de los numeros es '+ cast( @r as varchar))
    END
ELSE
BEGIN
        PRINT('El valor de n debe ser mayor a 0')
    END
END

EXEC sp_4 10
drop PROC sp_4

--seleccionar de la base de datos nortwind todas las ordenes de compra para un ano determinado

use NORTHWND
SELECT *
from Orders
where YEAR(OrderDate)=1996

create or ALTER PROC sp_5
    @n INT--parametro de entrada
as
BEGIN
    SELECT *
    from Orders
    where YEAR(OrderDate)=@n
END
SELECT  sum(Quantity+UnitPrice) as 'total', c.CompanyName
from [Order Details] as od
INNER JOIN Orders as o
ON od.OrderID=o.OrderID
INNER JOIN Customers as c
ON o.CustomerID=c.CustomerID
GROUP BY('total')

EXEC sp_5 

