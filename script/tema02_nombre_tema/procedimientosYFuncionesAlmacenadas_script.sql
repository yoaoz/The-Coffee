
-- Procedimiento para insertar un registro
CREATE PROCEDURE InsertarProducto
    @nombre VARCHAR(100),
    @descripcion NVARCHAR(100),
    @precio float,
    @imagen varchar(150),
    @id_categoria int
    
AS
BEGIN
    INSERT INTO Producto(nombre,descripcion,precio,imagen,id_categoria) 
    VALUES (@nombre, @descripcion, @precio, @imagen,@id_categoria);
END;

GO
-- Procedimiento para modificar un registro
CREATE PROCEDURE ModificarProducto
    @id int,
    @nombre VARCHAR(100),
    @descripcion NVARCHAR(100),
    @precio float,
    @imagen varchar(150),
    @id_categoria int
AS
BEGIN
    UPDATE Producto
    SET nombre = @nombre, descripcion = @descripcion, precio = @precio, imagen = @imagen, id_categoria = @id_categoria 
    WHERE id_producto = @id;
END;
GO

-- Procedimiento para eliminar un registro de manera logica
CREATE PROCEDURE EliminarProducto
    @id INT
AS
BEGIN
    Update Producto  
    set estado = 0 
    WHERE id_producto = @id;
END;

-- Crear el procedimiento almacenado para listar productos activos
GO
CREATE PROCEDURE ListarProductos
AS
BEGIN
    SET NOCOUNT ON; -- Evita el mensaje de número de filas afectadas

    SELECT *
    FROM Producto
    where estado = 1
END;
GO 

-- Procedimiento para eliminar un registro de manera fisica
CREATE PROCEDURE EliminarProductoFisicamente
    @id INT
AS
BEGIN
    DELETE FROM Producto WHERE id_producto = @id;
END;
GO

--Inserta una categoria
insert into Categoria(descripcion) values ('Cafes')
select * from Categoria

--Inserto registro en la tabla producto con la sentencia INSERT
INSERT INTO Producto (nombre, descripcion, precio, imagen, id_categoria) VALUES 
('Torta tofi', 'Masa sable, Chocolate y Dulce de leche', 1000.50, 'tofi.jpg', 2),
('Rogel', 'Masa, Dulce de leche, merenge' , 1500.00, 'rogel.jpg', 2);

Exec InsertarProducto 'Cafe', 'Cafe con leche', 1000, 'cafe.jpg', 1 --Paso por parametro los datos para agregrar un Producto

Exec InsertarProducto 'Cafe frio', 'Cafe con leche frio', 1200, 'cafeFrio.jpg', 1

Exec EliminarProducto 2 --Paso por parametro el id del producto	que quiero eiminar de manera logica (Cambio el estado de 1 a 0)

Exec EliminarProductoFisicamente 2 --Paso por parametro el id del producto	que quiero eiminar de manera fisica

Exec ModificarProducto  1, 'Cafe frio', 'Cafe con leche frio con chocolate', 1200, 'cafeFrio.jpg', 1 --Paso por parametros el id y los datos del producto que quiero modificar

Exec ListarProductos --Lista todos los productos

GO
-- Funcion que cuenta la cantidad de ventas que tiene un Mesero.
CREATE FUNCTION CantVentasPorMesero(@id int)
RETURNS int
AS
BEGIN
    DECLARE @cantidad int;
    SELECT @cantidad = COUNT(*) FROM Venta WHERE id_mesero = @id
    RETURN @cantidad;
END;

GO
--Funcion que devuelve el total de ventas en una determinada fecha
CREATE FUNCTION TotalDeVentas(@fechaDesde DateTime, @fechaHasta DateTime )
RETURNS float
AS
BEGIN
    DECLARE @monto float;
    SELECT @monto = SUM(monto_total) FROM Venta WHERE fecha_venta BETWEEN @fechaDesde and @fechaHasta
    RETURN @monto;
END;

GO
--Función que devuelve el total de ventas de un mesero en una determinada fecha
CREATE FUNCTION TotalDeVentasPorMesero(@fechaDesde DateTime, @fechaHasta DateTIme, @dni int)
RETURNS float
AS
BEGIN
    DECLARE @monto float;
    SELECT @monto = SUM(v.monto_total) 
    FROM Venta v 
    join Mesero m on v.id_mesero = m.id_mesero
    WHERE v.fecha_venta BETWEEN @fechaDesde and @fechaHasta and m.dni = @dni
    
    RETURN @monto;
END;
GO

--Usar la Función en una Consulta Directa
DECLARE @total FLOAT;
SET @total = dbo.TotalDeVentas('20240901', GETDATE());
SELECT @total AS 'Total de ventas';

--Usar la Función en una Consulta Seleccionando de Otras Tablas
--listo por cada mesero el total de ventas en una determinada fecha
SELECT 
    nombre AS Nombre,
    dbo.TotalDeVentasPorMesero('20230101', GETDATE(), dni) AS 'Total de ventas'
FROM 
    Mesero;
   
-- Por cada Mesero muestra su corresponte cantidad de Ventas registradas.    
SELECT 
    *,
    dbo.CantVentasPorMesero(id_mesero) AS 'Cantidad de Ventas'
from Mesero      
    
/* Procedimiento Almacenado
Definición: Es un conjunto de instrucciones SQL que se almacenan en la base de datos y pueden ser ejecutadas cuando se necesiten.
Retorno: No devuelve un valor, aunque puede modificar datos en la base de datos.
Uso: Generalmente se utiliza para realizar operaciones complejas, como inserciones, actualizaciones o eliminaciones.
Llamada: Se invoca con la instrucción CALL o EXECUTE.
Parámetros: Puede aceptar múltiples parámetros de entrada y salida.
Función Almacenada
Definición: Es un conjunto de instrucciones SQL que devuelve un único valor (o un conjunto de valores en algunos casos).
Retorno: Siempre devuelve un valor y puede ser utilizado dentro de expresiones.
Uso: Se utiliza principalmente para cálculos y transformaciones de datos.
Llamada: Se invoca como parte de una consulta SQL, por ejemplo, SELECT nombre_funcion().
Parámetros: Generalmente acepta parámetros de entrada, pero no puede tener parámetros de salida.
Resumen
En resumen, un procedimiento almacenado es más adecuado para operaciones que implican cambios en los datos, mientras que una función almacenada es más útil para realizar cálculos y devolver valores.
*/  
 
----Creo un procedimiento y una funcion para calular la edad----

-- Funcion para calcular la edad   
GO 
    CREATE FUNCTION CalcularEdad(@FechaNacimiento DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Edad INT;

    SET @Edad = DATEDIFF(YEAR, @FechaNacimiento, GETDATE())
                - CASE 
                    WHEN MONTH(@FechaNacimiento) > MONTH(GETDATE())
                         OR (MONTH(@FechaNacimiento) = MONTH(GETDATE()) AND DAY(@FechaNacimiento) > DAY(GETDATE()))
                    THEN 1 
                    ELSE 0 
                  END;

    RETURN @Edad;
END;

GO 
 
 --Procedimiento que muestra la edad
 CREATE PROCEDURE MostrarEdad
    @FechaNacimiento DATE
AS
BEGIN
    DECLARE @Edad INT;

    SET @Edad = DATEDIFF(YEAR, @FechaNacimiento, GETDATE())
                - CASE 
                    WHEN MONTH(@FechaNacimiento) > MONTH(GETDATE())
                         OR (MONTH(@FechaNacimiento) = MONTH(GETDATE()) AND DAY(@FechaNacimiento) > DAY(GETDATE()))
                    THEN 1 
                    ELSE 0 
                  END;

    PRINT 'La edad es: ' + CAST(@Edad AS VARCHAR) + ' años';
END;

Alter table Mesero --Agrego la columna fecha_namcimiento a mi tabla Mesero
add fecha_nacimiento Date

--Inserto nuevos registros de Meseros
INSERT INTO Mesero (nombre, apellido, hora_entrada, hora_salida, dni, telefono, fecha_nacimiento)  
VALUES 
('Juan', 'Pérez', 8, 16, 3345678, 1234569, '2005-06-14'),
('Ana', 'Gómez', 9, 17, 8654321, 9876521, '2004-06-14');

--Paso fecha_nacimiento como parametro a la función para que calcule la edad de cada mesero.
select *, dbo.CalcularEdad(fecha_nacimiento) from Mesero

--Paso por parametro una fecha para que me muestre la edad. 
Exec MostrarEdad '2004-11-30'
