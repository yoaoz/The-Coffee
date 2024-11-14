# Tema 2 Funciones y Procedimientos almacenados

## Introducción
Un procedimiento almacenado y una función son ambos objetos de base de datos que contienen bloques de código SQL que pueden ser ejecutados por el sistema de gestión de bases de datos (SGBD). Aunque ambos sirven para encapsular lógica que puede ser reutilizada, tienen algunas diferencias clave en cuanto a su propósito, comportamiento y características.

## Procedimientos almacenadados

**Definición**: Un procedimiento almacenado en SQL Server es un conjunto de instrucciones SQL precompiladas que se almacenan en la base de datos y se pueden ejecutar como una unidad. Estos procedimientos encapsulan operaciones de consulta y manipulación de datos, lo que permite ejecutar comandos complejos y repetitivos de forma eficiente y organizada.

**Características**: Puede realizar operaciones de modificación de datos, como INSERT, UPDATE y DELETE. No devuelve un valor directo (aunque puede devolver un valor de estado o código de error a través de parámetros de salida). Puede aceptar parámetros de entrada y parámetros de salida. Es posible realizar transacciones dentro del procedimiento. Puede no devolver nada explícitamente, aunque puede generar resultados a través de un conjunto de resultados, o también puede retornar un código de estado.

### Tipos de procedimientos almacenados
Los procedimientos almacenados pueden clasificarse en varios tipos, según su propósito y características.
Los Principales son:
### 1. Definidos por el Usuario
Estos son procedimientos almacenados que los desarrolladores crean para realizar operaciones específicas en la base de datos, como insertar, actualizar, eliminar o consultar datos.
```sql
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
```
### 2. Del Sistema
Proporcionados por SQL Server, estos procedimientos almacenados se utilizan para realizar tareas administrativas y de mantenimiento en la base de datos. Por ejemplo, sp_help devuelve información sobre un objeto de base de datos, y sp_rename se usa para renombrar tablas o columnas.
```sql
EXEC sp_help 'Meseros';
```
### 3. Temporales
Se crean para su uso en una sesión específica y se eliminan automáticamente al cerrar la conexión. Se nombran con un único signo de almohadilla (#).
```sql
CREATE PROCEDURE #MiProcedimientoTemporal
AS
BEGIN
    SELECT 'Este es un procedimiento temporal local';
END;
```
## Ventajas de Usar Procedimientos Almacenados
1. **Mejora del rendimiento:**
  - **Precompilación:** Los procedimientos almacenados se compilan una vez y se almacenan en la base de datos, lo que reduce el tiempo de     ejecución en consultas subsecuentes, ya que no es necesario recompilar cada vez.
  - **Menor tráfico de red:** Al enviar solo el nombre del procedimiento y los parámetros, en lugar de enviar consultas SQL completas, se         reduce el tráfico de datos entre la aplicación y la base de datos.
2. **Modularidad y reutilización de código:**
  - Permiten encapsular la lógica de operaciones complejas (como inserciones, actualizaciones o consultas) en un solo lugar, lo que hace      que el código sea más organizado y reutilizable.
  - Se pueden reutilizar en diferentes partes de la aplicación sin necesidad de reescribir el mismo código una y otra vez
3. **Facilita la gestión y mantenimiento:**
  - Los procedimientos almacenados centralizan la lógica de negocios en la base de datos, lo que facilita la actualización y                  mantenimiento de la lógica, ya que solo se necesita modificar el procedimiento en lugar de buscar y actualizar múltiples fragmentos       de código en la aplicación.
  - Cambios en la lógica de la base de datos (como agregar nuevos campos a una consulta o cambiar un algoritmo) no requieren                  modificaciones en la aplicación cliente.
4. **Seguridad mejorada:**
  - **Control de acceso:** Los permisos para ejecutar procedimientos almacenados pueden ser gestionados de manera más detallada,              permitiendo que los usuarios ejecuten el procedimiento sin necesidad de otorgar acceso directo a las tablas subyacentes.
5. **Desacoplamiento de la lógica de negocios:**
  - Los procedimientos almacenados permiten desacoplar la lógica de negocios de la aplicación, lo que facilita la gestión de la base de       datos y la aplicación de manera independiente. La aplicación puede centrarse solo en la presentación de los datos, mientras que la        base de datos se encarga de la lógica.
## Funciones 
**Definición:** Una función es un conjunto de instrucciones SQL que también se almacena en la base de datos, pero a diferencia de un procedimiento, una función siempre devuelve un valor. Este valor se puede utilizar en una expresión SQL o como parte de una consulta.

**Características:** Siempre devuelve un valor (puede ser un valor simple, como un número o una cadena, o incluso un conjunto de resultados en algunos SGBD). No debe realizar modificaciones en la base de datos (no debe tener operaciones de tipo INSERT, UPDATE o DELETE). Su uso principal es el cálculo o la obtención de valores a partir de los datos. Puede aceptar parámetros de entrada. Se utiliza principalmente en consultas SELECT o en expresiones.

### Tipos de funciones
Las funciones pueden clasificarse de varias maneras, según su propósito y características.
Las Principales son:

### 1. Funciones escalares:
Estas funciones devuelven un único valor de un tipo de datos determinado (como INT, VARCHAR, DATETIME, etc.). Son utilizadas para realizar cálculos o manipulaciones de datos y devolver un resultado.
```sql
CREATE FUNCTION CalcularEdad (@FechaNacimiento DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @FechaNacimiento, GETDATE());
END;
```
Para ejecutarla:
```sql
SELECT dbo.CalcularEdad('1990-05-15');
```
### 2. Funciones de tabla (o funciones con valor de tabla):
Estas funciones devuelven un conjunto de resultados en forma de tabla, lo que permite utilizarlas como si fueran una tabla normal en una consulta SELECT. Se pueden utilizar para encapsular lógicas complejas que devuelvan varias filas y columnas.
```sql
CREATE FUNCTION ObtenerProductosActivos()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Productos
    WHERE Activo = 1
);
```
Para ejecutarla: 
```sql
SELECT * FROM dbo.ObtenerProductosActivos();
```
### 3. Funciones agregadas:
Estas funciones operan sobre un conjunto de datos y devuelven un único valor agregado, como la suma (SUM), el promedio (AVG), el máximo (MAX), o el mínimo (MIN). Son muy útiles para realizar cálculos sobre columnas de una tabla.

# Conclusiones
### 1. Objetivo y Propósito
- **Funciones:** Están diseñadas principalmente para devolver un valor calculado o un conjunto de resultados (en el caso de funciones de tabla). Se utilizan para calcular valores o realizar operaciones sobre los datos y devolver un resultado que se puede usar dentro de una consulta. Son ideales para operaciones reutilizables dentro de consultas.
- **Procedimientos:** Su objetivo es ejecutar un conjunto de instrucciones SQL, como consultas o modificaciones de datos, sin necesariamente devolver un valor. Son más versátiles y pueden realizar tareas más complejas, como la manipulación de datos, la ejecución de transacciones o la invocación de otras funciones y procedimientos.
### 2. Retorno de Resultados
- **Funciones:** Deben devolver un valor (ya sea un solo valor o una tabla de resultados). Su uso está limitado a devolver un único valor calculado o un conjunto de datos.
- **Procedimientos:** No están limitados a un solo tipo de retorno. Pueden devolver valores a través de parámetros de salida, manejar errores, o simplemente realizar operaciones sin devolver un valor. Son más flexibles en cuanto a la manipulación y control de datos.
### 3. Utilización dentro de Consultas
- **Funciones:** Se pueden usar directamente dentro de consultas SELECT, WHERE, HAVING o JOIN, ya que pueden devolver un valor o conjunto de resultados que se integra fácilmente en el flujo de la consulta.
- **Procedimientos Almacenados:** No pueden ser llamados directamente desde una consulta SELECT. Se ejecutan como comandos separados, fuera del flujo de la consulta principal. Para interactuar con los resultados, necesitarías usar parámetros de salida o procesar los resultados en la aplicación.
### 4. Control de Errores y Flujo
- **Funciones:** Tienen un control limitado de errores. No pueden usar estructuras como TRY CATCH para manejar excepciones. Su flujo es más simple y orientado a la obtención de resultados.
- **Procedimientos Almacenados:** Pueden manejar errores con TRY CATCH y tienen un control más completo del flujo de ejecución, lo que los hace adecuados para operaciones más complejas.
