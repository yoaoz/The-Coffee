# Tema: Índices columnares en SQL server
## **Índice Columnstore:**
En SQL Server, los índices columnares guardan la información por columnas en vez de filas, lo que incrementa notablemente el desempeño de las consultas. Este tipo de índice es perfecto para situaciones en las que se llevan a cabo operaciones de lectura intensiva, como agregaciones y filtrados de grandes cantidades de datos, dado que facilita el acceso únicamente a las columnas requeridas y optimiza la compresión de los datos.

En SQL Server tenemos el índice Columnstore.

**Ejemplo de como crear un índice Columnstore:**

`CREATE CLUSTERED COLUMNSTORE INDEX idx_columnstore ON NuevaTabla;`

**Ejempo de como borrar un índice creado:**

`DROP INDEX idx_columnstore ON NuevaTabla;` 

**Ventajas**:

-   Mejora el rendimiento de consultas analíticas complejas.
-   Reduce el espacio en disco debido a la alta tasa de compresión de datos.
-   Optimiza la velocidad de las consultas de agregación y filtrado, especialmente en grandes volúmenes de datos.

**Desventajas**:

-   No es adecuado para cargas de trabajo con muchas actualizaciones, inserciones o eliminaciones, ya que los índices Columnstore son más adecuados para consultas de solo lectura.

## Tareas
> Ver el script para entender más [script.sql]()

## Conclusiones
En la tabla `Venta_con_IC`, el índice columnar mejoró considerablemente el tiempo de respuesta de las consultas analíticas en comparación con `Venta_sin_IC y Venta_con_AC`. Esto demuestra que los índices columnares son ideales para consultas que requieren un análisis intensivo de datos en grandes volúmenes.
