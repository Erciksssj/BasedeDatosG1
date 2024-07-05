CREATE OR ALTER TRIGGER trg_UpdateDimEmpleado
ON pruebacargadinamica.dbo.empleado
AFTER INSERT, UPDATE
AS
BEGIN
    MERGE INTO pruebacargadinamica.dbo.dim_empleados AS target
    USING (
        SELECT 
            e.FirstName, e.LastName,
            e.[Address] AS Direccion,
            e.HomePhone AS Telefono,
            e.Country AS Pais
        FROM inserted e
    ) AS source ON target.FirstName = source.FirstName
    WHEN MATCHED THEN
        UPDATE SET
            [Address] = source.Direccion,
            HomePhone = source.Telefono,
            Country=source.Pais
    WHEN NOT MATCHED THEN
        INSERT (FirstName, LastName, [Address], HomePhone, Country)
        VALUES (source.FirstName, source.LastNAme, source.Direccion, source.Telefono, source.Country);
END;