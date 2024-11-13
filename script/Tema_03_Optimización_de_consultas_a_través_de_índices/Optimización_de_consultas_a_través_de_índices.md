# Tema: Optimización de consultas a través de índices
## Introduccion

La optimización de las consultas a través de la utilización de índices es un método esencial en las bases de datos para incrementar el desempeño y la rapidez de la búsqueda, particularmente en consultas complejas o en tablas extensas. 

## ¿Qué es un índice?

Un índice es una estructura de datos adicional que se crea en una tabla para mejorar la velocidad de las consultas, su propósito es encontrar una manera de disminuir el tiempo de respuesta de la consulta, evitando así el consumo excesivo de recursos, recuperar datos más rápido y reducir cuellos de botella. Permite a la base de datos localizar rápidamente las filas que cumplen con los criterios de búsqueda y sirven como técnica de optimización del rendimiento.

## Tipos de índice y sus aplicaciones

* **Índices agrupados (Clustered Index):** 
	Los índices agrupados organizan y guardan las filas de información en la tabla o vista basándose en sus valores claves, define el orden en el cual los datos son físicamente almacenados en una tabla.
En una tabla Agrupada, se utiliza un índice agrupado SQL Server para guardar las filas de información categorizadas en función de los valores clave del índice agrupado. SQL Server nos ofrece la posibilidad de crear únicamente un índice agrupado por cada tabla, dado que los datos pueden ser categorizados en la tabla mediante un criterio de orden.
Guarda los datos de la tabla en el disco duro en la secuencia del índice. Solo puede existir un índice organizado por tabla, dado que establece la secuencia física de los registros.
El índice agrupado se organiza mediante estructuras B-Árbol, con el objetivo de activar el Motor SQL Server para localizar rápidamente las filas necesarias vinculadas a los valores clave de índice. Se percibe cada página en la estructura de índice B-Árbol como un tipo de índice. El nodo superior se conoce como nodo Raíz y los nodos inferiores como nodos Hoja, donde se guardan y categorizan las páginas de las tablas de información según los valores clave de índice.
En las tablas montón (que son aquellas tablas que no tienen un índice agrupado), la ausencia de los índices agrupados significa que la información no es clasificada en la tabla que le sigue.
Ideal para columnas que se emplean a menudo en rangos de búsqueda o en columnas singulares, como una fecha o un identificador singular.

**Ejemplo**
`CREATE CLUSTERED INDEX IDX_Movimiento_Caja_Fecha ON Movimiento_Caja(fecha);`

* **Índices  no agrupados (Non-Clustered Index):** 
Un índice no agrupado no ordena los datos físicos dentro de la tabla. De hecho, un índice no agrupado es agrupado en un solo lugar y los datos de la tabla son almacenados en otro lugar. 
Dentro de la tabla los datos serán ordenados por un índice agrupado. De todos modos, por dentro los datos del índice no agrupado son almacenados en un orden específico. El índice contiene valores de columna en los cuales el índice es creado y la dirección del registro a la que el valor de la columna pertenece.
Cuando una consulta es lanzada contra una columna en la cual el índice es creado, la base de datos primero irá al índice y buscará la dirección de la fila correspondiente en la tabla. Luego, irá a esa dirección de fila y obtendrá otros valores de columna. Es debido a este paso adicional que los índices no agrupados son más lentos que los índices agrupados.
Mantiene una estructura separada, donde se almacena el valor de la clave y un puntero a la fila correspondiente. Esto permite múltiples índices no agrupados en una misma tabla, lo que mejora la flexibilidad para optimizar diferentes consultas.
Útil en columnas que no son clave primaria, pero que se consultan con frecuencia, como columnas en filtros WHERE.
Mejora el rendimiento de búsquedas y consultas en columnas específicas, pero no impacta el orden físico de los datos.
	
**Ejemplo**
`CREATE NONCLUSTERED INDEX IX_Movimiento_Caja_Fecha_TipoMovimiento_Include ON Movimiento_Caja (fecha, tipo_movimiento) INCLUDE (monto, descripcion);`

## Conclusiones

Es esencial el uso de índices en las bases de datos para optimizar la eficacia de las consultas, particularmente en tablas con grandes cantidades de información y en consultas complejas. Los índices facilitan que la base de datos pueda acceder con rapidez a las filas que satisfacen los criterios de búsqueda, reduciendo así el tiempo de respuesta y el uso de recursos, lo que disminuye los atascos y acelera el proceso.
Los índices agrupados son ideales para columnas que se consultan en intervalos determinados y que establecen la secuencia lógica de la tabla, como fechas o identificadores únicos. Al guardar los datos en una secuencia determinada, el acceso resulta más veloz. No obstante, solo se puede tener un índice organizado por tabla, ya que establece la secuencia física de los datos. Al estar directamente ligado a las filas de datos, el índice agrupado no requiere espacio adicional más allá de los datos en sí.
Los índices no agrupados resultan beneficiosos para optimizar el desempeño de las consultas en columnas concretas que no establecen la secuencia de la tabla, pero se realizan a menudo. A pesar de que son más lentos que los índices agrupados por la búsqueda de un puntero extra, facilitan el acceso a columnas adicionales y proporcionan flexibilidad al albergar varios índices en la misma tabla. Requiere espacio adicional en disco, ya que los datos del índice y los datos de la tabla están separados.
