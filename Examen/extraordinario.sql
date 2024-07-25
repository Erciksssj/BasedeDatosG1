use BDEJEMPLO2

select * from Clientes
select * from Oficinas
select * from Pedidos
select * from Productos
select * from Representantes
go

create or alter view hola
as
select * from Clientes
go
select* from hola
go
create or alter proc spu_realizar_pedido
	@numeroPed int,
	@fecha date,
	@cliente int,
	@repre int,
	@fab char(3),
	@prodc char(5),
	@cantidad int,
	@mensaje nchar(50) output

as
	begin

		declare @stock int
		declare @precio money

		select @stock=Stock,@precio=Precio
		from Productos
		where Id_fab=@fab
		and Id_producto=@prodc

		if @stock>=@cantidad
			begin

				insert into Pedidos
				values (@numeroPed,@fecha,@cliente,@repre,@fab,@prodc,@cantidad,(@cantidad * @precio))

				update Productos
				set Stock=Stock-@cantidad
				where Id_fab=@fab and Id_producto=@prodc

				set @mensaje='Se inserto'
			end
		else
			begin
				set @mensaje='No existe suficiente stock'
			end
end
go
declare @salida nvarchar(50)
declare @fecha date
set @fecha=(select getdate())

exec spu_realizar_pedido 11307,@fecha,2108,106,'REI','2A44L',20,@mensaje=@salida output

print @salida
go
CREATE PROCEDURE cliente
    @ClientId INT
AS
BEGIN
    SELECT Cliente, COUNT(*) as TotalPedidos 
    FROM Pedidos 
    WHERE Cliente = @ClientId
    GROUP BY Cliente 
    ORDER BY TotalPedidos DESC;
END;
go
exec cliente 2101
go
create or ALTER PROCEDURE hola
--parametros de entrada
@radio float,
--Parametro de salida
@area float OUTPUT
as
BEGIN
 set @area=PI()*@radio*@radio
END
go

declare @resp float	
exec calcula_area @radio=22.3, @area=@resp output
print 'El area es: '+ cast(@resp as varchar)
go

SELECT COUNT(*) AS total_registros
FROM Clientes;


SELECT departamento, COUNT(*) AS total_empleados
FROM empleados
GROUP BY departamento;
go
CREATE PROCEDURE VerificarJefe
    @JefeID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Oficinas WHERE Jef = @JefeID)
	IF EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @fab AND Id_producto = @prod)
	  DELETE FROM Productos
        WHERE Id_fab = @fab
        AND Id_producto = @prod

    BEGIN
        SELECT * FROM Representantes WHERE Jefe = @JefeID;
    END
    ELSE
    BEGIN
        PRINT 'No existe jef';
    END
END 
go
ALTER PROC Spu_actualizar_producto
    @fab CHAR(3),           -- Identificador de la fábrica del producto
    @prod CHAR(5),          -- Identificador del producto
    @nuevo_precio MONEY,    -- Nuevo precio que se desea asignar al producto
    @nuevo_stock INT,       -- Nuevo stock que se desea asignar al producto
    @mensaje VARCHAR(50) OUTPUT  -- Variable de salida que proporciona el resultado de la operación
AS
BEGIN
    -- Verifica si el producto existe en la tabla 'Productos'
    IF EXISTS (
        SELECT 1 
        FROM Productos 
        WHERE Id_fab = @fab    -- Filtro por identificador de fábrica
        AND Id_producto = @prod  -- Filtro por identificador del producto
    )
    BEGIN
        -- Si el producto existe, actualiza el precio y el stock
        UPDATE Productos
        SET Precio = @nuevo_precio,   -- Establece el nuevo precio
            Stock = @nuevo_stock      -- Establece el nuevo stock
        WHERE Id_fab = @fab
        AND Id_producto = @prod

        -- Si la actualización se realiza correctamente, establece un mensaje de éxito
        SET @mensaje = 'Producto actualizado correctamente'
    END
    ELSE
    BEGIN
        -- Si el producto no existe, establece un mensaje de error
        SET @mensaje = 'El producto no existe'
    END
END
GO
exec VerificarJefe 

ALTER PROC Spu_eliminar_producto
    @fab CHAR(3),
    @prod CHAR(5),
    @mensaje VARCHAR(50) OUTPUT
AS
BEGIN
    -- Verifica si el producto existe antes de intentar eliminarlo
    IF EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @fab AND Id_producto = @prod)
    BEGIN
        -- Elimina el producto
        DELETE FROM Productos
        WHERE Id_fab = @fab
        AND Id_producto = @prod

        -- Establece mensaje de éxito
        SET @mensaje = 'Producto eliminado correctamente'
    END
    ELSE
    BEGIN
        -- Establece mensaje de error si el producto no existe
        SET @mensaje = 'El producto no existe'
    END
END
GO




ALTER PROC Spu_actualizar_producto
    @fab CHAR(3),           -- Identificador de la fábrica del producto
    @prod CHAR(5),          -- Identificador del producto
    @nuevo_precio MONEY,    -- Nuevo precio que se desea asignar al producto
    @nuevo_stock INT,       -- Nuevo stock que se desea asignar al producto
    @mensaje VARCHAR(50) OUTPUT  -- Variable de salida que proporciona el resultado de la operación
AS
BEGIN
    -- Verifica si el producto existe en la tabla 'Productos'
    IF EXISTS (
        SELECT 1 
        FROM Productos 
        WHERE Id_fab = @fab    -- Filtro por identificador de fábrica
        AND Id_producto = @prod  -- Filtro por identificador del producto
    )
    BEGIN
        -- Si el producto existe, actualiza el precio y el stock
        UPDATE Productos
        SET Precio = @nuevo_precio,   -- Establece el nuevo precio
            Stock = @nuevo_stock      -- Establece el nuevo stock
        WHERE Id_fab = @fab
        AND Id_producto = @prod

        -- Si la actualización se realiza correctamente, establece un mensaje de éxito
        SET @mensaje = 'Producto actualizado correctamente'
    END
    ELSE
    BEGIN
        -- Si el producto no existe, establece un mensaje de error
        SET @mensaje = 'El producto no existe'
    END
END
GO