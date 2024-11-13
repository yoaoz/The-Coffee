USE DBTheCoffee;

-- Creamos las tablas que utilizaremos para las pruebas.
SELECT * INTO Venta_sin_IC FROM Venta WHERE 1 = 0;
SELECT * INTO Venta_con_IC FROM Venta WHERE 1 = 0;
SELECT * INTO Venta_con_IA FROM Venta WHERE 1 = 0;

-- Cargamos las tres tablas que creamos con 2 millones de registros cada una.
SET NOCOUNT ON;
DECLARE @i INT = 0;
WHILE @i < 2000000
BEGIN
    -- Insertar en Venta_sin_IC
    INSERT INTO Venta_sin_IC (fecha_venta, monto_total, id_mesero, id_mesa, id_cliente, id_turno, id_caja)
    SELECT 
        DATEADD(day, @i % 30, DATEADD(month, @i % 12, DATEADD(year, @i % 5, fecha_venta))),  -- Variación en año, mes y día
        monto_total + (@i % 100),             -- Variación en monto_total
        id_mesero + (@i),
        id_mesa,
        id_cliente,
        id_turno,
        id_caja
    FROM Venta;

    -- Insertar en Venta_con_IC
    INSERT INTO Venta_con_IC (fecha_venta, monto_total, id_mesero, id_mesa, id_cliente, id_turno, id_caja)
    SELECT 
        DATEADD(day, @i % 30, DATEADD(month, @i % 12, DATEADD(year, @i % 5, fecha_venta))),  -- Variación en año, mes y día
        monto_total + (@i % 100),             -- Variación en monto_total
        id_mesero + (@i),
        id_mesa,
        id_cliente,
        id_turno,
        id_caja
    FROM Venta;

    -- Insertar en Venta_con_IA
    INSERT INTO Venta_con_IA (fecha_venta, monto_total, id_mesero, id_mesa, id_cliente, id_turno, id_caja)
    SELECT 
        DATEADD(day, @i % 30, DATEADD(month, @i % 12, DATEADD(year, @i % 5, fecha_venta))),  -- Variación en año, mes y día
        monto_total + (@i % 100),             -- Variación en monto_total
        id_mesero + (@i),
        id_mesa,
        id_cliente,
        id_turno,
        id_caja
    FROM Venta;

    SET @i = @i + 1;
END;

-- Revisamos que se hayan cargado correctamente los registros
SELECT COUNT(*) as 'Venta sin indice columnar cantidad' FROM Venta_sin_IC;
SELECT COUNT(*) as 'Venta con indice columnar cantidad' FROM Venta_con_IC;
SELECT COUNT(*) as 'Venta con indice agrupado cantidad' FROM Venta_con_IA;

-- Creamos el índice de tipo columnar en la tabla Venta_con_IC
CREATE COLUMNSTORE INDEX IDX_Venta_con_IC_Columnstore ON Venta_con_IC (fecha_venta, monto_total);

-- Creamos un índice de tipo agrupado en la tabla Venta_con_IA
CREATE CLUSTERED INDEX IDX_Venta_con_IA_Aggregate ON Venta_con_IA (fecha_venta, monto_total);

-- Consulta para la tabla sin índices columnares en Venta_sin_IC
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT 
    id_mesero,
    YEAR(fecha_venta) AS Año,
    MONTH(fecha_venta) AS Mes,
    SUM(monto_total) AS Total_Ventas
FROM Venta_sin_IC
WHERE fecha_venta BETWEEN '2024-01-01' AND '2030-12-31'  -- Filtra directamente por rango de fecha
GROUP BY id_mesero, YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY Total_Ventas DESC;
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- Consulta para la tabla con índice columnar en Venta_con_IC
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT 
    id_mesero,
    YEAR(fecha_venta) AS Año,
    MONTH(fecha_venta) AS Mes,
    SUM(monto_total) AS Total_Ventas
FROM Venta_con_IC
WHERE fecha_venta BETWEEN '2024-01-01' AND '2030-12-31'  -- Filtra directamente por rango de fecha
GROUP BY id_mesero, YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY Total_Ventas DESC;
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- Consulta para la tabla con índice agrupado en Venta_con_IA
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT 
    id_mesero,
    YEAR(fecha_venta) AS Año,
    MONTH(fecha_venta) AS Mes,
    SUM(monto_total) AS Total_Ventas
FROM Venta_con_IA
WHERE fecha_venta BETWEEN '2024-01-01' AND '2030-12-31'  -- Filtra directamente por rango de fecha
GROUP BY id_mesero, YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY Total_Ventas DESC;
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- Comenzamos las pruebas de rendimiento: --
---------------------------------------------------------------
-- Tanda 1:
--
-- Primero los resultados de la tabla sin indices columnares:
-- Table 'Venta_sin_IC'. Scan count 1, logical reads 11429, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 2453 ms,  elapsed time = 11371 ms.

-- Ahora los resultados de la tabla con indices columnares:
-- Table 'Venta_con_IC'. Scan count 1, logical reads 11429, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 969 ms,  elapsed time = 9532 ms.

-- Y por ultimo una comparación con índices tradicionales, en este caso el índice agrupado
-- Table 'Venta_con_IA'. Scan count 1, logical reads 13211, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 1875 ms,  elapsed time = 10198 ms.
--
---------------------------------------------------------------
-- Tanda 2:
--
-- Primero los resultados de la tabla sin indices columnares:
-- Table 'Venta_sin_IC'. Scan count 1, logical reads 11429, physical reads 0, page server reads 0, read-ahead reads 11429, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 1609 ms,  elapsed time = 10521 ms.

-- Ahora los resultados de la tabla con indices columnares:
-- Table 'Venta_con_IC'. Scan count 1, logical reads 11429, physical reads 0, page server reads 0, read-ahead reads 11429, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 797 ms,  elapsed time = 7870 ms.

-- Y por ultimo una comparación con índices tradicionales, en este caso el índice agrupado
-- Table 'Venta_con_IA'. Scan count 1, logical reads 13211, physical reads 3, page server reads 0, read-ahead reads 13207, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 2000 ms,  elapsed time = 15655 ms.
---------------------------------------------------------------
-- Tanda 3:
--
-- Primero los resultados de la tabla sin indices columnares:
-- Table 'Venta_sin_IC'. Scan count 1, logical reads 11429, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 2359 ms,  elapsed time = 10152 ms.

-- Ahora los resultados de la tabla con indices columnares:
-- Table 'Venta_con_IC'. Scan count 1, logical reads 11429, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 891 ms,  elapsed time = 7665 ms.

-- Y por ultimo una comparación con índices tradicionales, en este caso el índice agrupado
-- Table 'Venta_con_IA'. Scan count 1, logical reads 13211, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- SQL Server Execution Times:
-- CPU time = 2422 ms,  elapsed time = 9273 ms.
---------------------------------------------------------------

-- Conclusiones finales: --
--------------------------------------------------------------
--|Tandas |--|Ventas_sin_IC|-|Ventas_con_IC|-|Ventas_con_IA|--
--|Tanda 1|--|   11371ms   |-|   9532ms    |-|   10198ms   |--
--|Tanda 2|--|   10521ms   |-|   7870ms    |-|   15655ms   |--
--|Tanda 3|--|   10152ms   |-|   7665ms    |-|   9273ms    |--
--------------------------------------------------------------
-- En tareas de análisis de información en tablas grandes, los índices columnares suelen ser la alternativa más eficaz para disminuir los 
-- tiempos de ejecución y potenciar la eficiencia de la consulta como se puede observar en el cuadro comparativo. 
-- Los índices agrupados pueden resultar beneficiosos en actividades que necesitan acceso directo a registros completos, pero no resultan 
-- tan eficaces para consultas analíticas.



