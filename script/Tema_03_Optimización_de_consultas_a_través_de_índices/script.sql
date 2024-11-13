USE DBTheCoffee;

-- se ejecuta una funci�n automatizada para cargar un mill�n de registros, donde el campo fecha no tiene ning�n �ndice para ver su rendimiento
DECLARE @count INT = 0;

WHILE @count < 1000000
BEGIN
    INSERT INTO Movimiento_Caja (tipo_movimiento, monto, fecha, descripcion, id_turno, id_caja)
    VALUES (
        'Ingreso', 
        RAND() * 1000, 
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE()), 
        'Movimiento generado autom�ticamente', 
        1, 
        1
    );
    SET @count = @count + 1;
END;

-- tiempo de ejecuci�n: 00:02:23

select * from Movimiento_Caja;

-- tiempo de ejecuci�n: 00:00:05
-- 1.041.984 rows

-- se realiza una b�esqueda sin �ndice en la columna fecha para cierto per�odo
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT * 
FROM Movimiento_Caja
WHERE fecha BETWEEN DATEADD(DAY, -300, GETDATE()) AND GETDATE();

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
-- SQL Server Execution Times:
-- CPU time = 0 ms,  elapsed time = 0 ms.

-- (856327 rows affected)
-- Table 'Movimiento_Caja'. Scan count 1, logical reads 11085, physical reads 0, page server reads 0, read-ahead reads 10944, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, 
-- lob read-ahead reads 0, lob page server read-ahead reads 0.

-- SQL Server Execution Times:
-- CPU time = 109 ms,  elapsed time = 4178 ms.

-- Completion time: 2024-11-12T20:31:23.7220848-03:00

-- se crea un �ndice agrupado en la columna fecha y se vuelve a ejecutar la consulta anterior
CREATE CLUSTERED INDEX IDX_MovimientoCaja_Fecha ON Movimiento_Caja (fecha);
-- tiempo de ejecuci�n: 00:00:01


SELECT * 
FROM Movimiento_Caja
WHERE fecha BETWEEN DATEADD(DAY, -300, GETDATE()) AND GETDATE();

-- Se produce el siguiente error: Msg 1902, Level 16, State 3, Line 327
-- Cannot create more than one clustered index on table 'Movimiento_Caja'. Drop the existing clustered index 'PK_Moviento_Caja_id' before creating another.
-- Dado que los �ndices agrupados solo pueden tener un �ndice por tabla, entra en conflicto con la clave primaria, para ello se elimina dicha clave

ALTER TABLE Movimiento_caja
DROP CONSTRAINT PK_Moviento_Caja_id

-- se procede a hacer consulta con �ndice agrupado

-- Respuesta de ejecuci�n: Table 'Movimiento_Caja'. Scan count 1, logical reads 10317, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, 
-- lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- Completion time: 2024-11-12T19:38:36.0510477-03:00

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT * 
FROM Movimiento_Caja
WHERE fecha BETWEEN DATEADD(DAY, -300, GETDATE()) AND GETDATE();

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- SQL Server Execution Times:
--  CPU time = 0 ms,  elapsed time = 0 ms.

-- (856327 rows affected)
-- Table 'Movimiento_Caja'. Scan count 1, logical reads 9139, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, 
-- lob read-ahead reads 0, lob page server read-ahead reads 0.

-- SQL Server Execution Times:
--  CPU time = 312 ms,  elapsed time = 3845 ms.

-- Completion time: 2024-11-12T20:32:53.8823400-03:00


-- Se elimina el �ndice creado anteriormente

DROP INDEX IDX_MovimientoCaja_Fecha ON Movimiento_Caja;

DROP INDEX IDX_MovimientoCaja_Fecha_Incluido  ON Movimiento_Caja;


-- Definir un �ndice no agrupado sobre la columna fecha pero que adem�s incluya las columnas seleccionadas y repetir la consulta anterior. Registrar el plan de ejecuci�n utilizado por el motor y los tiempos de respuesta.
CREATE NONCLUSTERED INDEX IDX_MovimientoCaja_Fecha_Incluido 
ON Movimiento_Caja (fecha) 
INCLUDE (tipo_movimiento, monto, descripcion);

SET STATISTICS TIME ON;
SET STATISTICS IO ON;


SELECT * 
FROM Movimiento_Caja
WHERE fecha BETWEEN DATEADD(DAY, -300, GETDATE()) AND GETDATE();

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- SQL Server Execution Times:
-- CPU time = 0 ms,  elapsed time = 0 ms.

-- (856327 rows affected)
-- Table 'Movimiento_Caja'. Scan count 1, logical reads 11085, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, 
-- lob read-ahead reads 0, lob page server read-ahead reads 0.

-- SQL Server Execution Times:
-- CPU time = 31 ms,  elapsed time = 3783 ms.

-- Completion time: 2024-11-12T20:37:45.0848858-03:00

-- *** CONCLUSIONES FINALES ***
-- Consulta sin �ndice
-- Tiempo de CPU: 109 ms
-- Tiempo transcurrido: 4178 ms
-- Lecturas l�gicas: 11,085
-- Observaci�n: La consulta realiza una exploraci�n completa de la tabla, se puede ver un elevado n�mero de lecturas l�gicas debido a la falta de un �ndice en la columna fecha. Se puede observar en un tiempo de ejecuci�n alto.

-- Consulta con �ndice agrupado en fecha
-- Tiempo de CPU: 312 ms
-- Tiempo transcurrido: 3845 ms
-- Lecturas l�gicas: 9139
-- Lecturas anticipadas: 0
-- Observaci�n: La creaci�n de un �ndice agrupado en fecha reduce considerablemente las lecturas l�gicas y mejora el rendimiento de la consulta.

-- Consulta con �ndice no agrupado en fecha con columnas incluidas (tipo_movimiento, monto, descripcion)
-- Tiempo de CPU: 31 ms
-- Tiempo transcurrido: 3783 ms
-- Lecturas l�gicas: 11,085
-- Lecturas anticipadas: 0
-- Observaci�n: El �ndice no agrupado en fecha, incluyendo las columnas tipo_movimiento, monto y descripcion, reduce notablemente el uso de CPU y mejora el tiempo transcurrido en comparaci�n con la consulta sin �ndices, pero es similar
-- al tiempo de ejecuci�n de la consulta con �ndice agrupado. 
-- Sin embargo, el n�mero de lecturas l�gicas vuelve a ser elevado, similar al de la consulta sin �ndice agrupado.

-- Conclusi�n
-- El uso de un �ndice no agrupado en fecha con columnas incluidas ofrece mejoras en el uso de CPU y reduce el tiempo transcurrido en comparaci�n con la consulta sin �ndice.
-- Se puede observar que la consulta con �ndice agrupado resulta ser la m�s apropiada en cuanto a tiempo de ejecuci�n y lectural l�gicas, ya que si bien la consulta con �ndice no agrupado es similar en cuanto a tiempo de ejecuci�n
-- tiene un costo similar en cuanto a lecturas l�gicas en comparaci�n con la consulta sin �ndices.

