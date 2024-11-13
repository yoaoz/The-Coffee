# PRESENTACIÓN (The Coffee)

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:
 - Coronel, Juan De La Cruz
 - Espinola Rivero, Emilia
 - Kallus, Clarisa
 - Ozuna, Joaquín

**Profesores**:
 - Lic. Dario O. Villegas
 - Lic. Walter O. Vallejos
 - Exp. Juan Jose Cuzziol
 - Lic. Numa Badaracco

**Año**: 2024

## CAPÍTULO I: INTRODUCCIÓN

### Caso de estudio

El presente documento aborda el diseño y desarrollo de un sistema de gestión para una cafetería. Este sistema incluirá la gestión de clientes, ventas, productos, pagos, meseros y permisos de usuario, entre otras cosas. Este sistema tiene como objetivo mejorar el proceso de atención al cliente y la gestión interna de la cafetería, lo que permite un manejo más eficiente y ágil de los datos relacionados con las operaciones diarias.

El sistema está diseñado para controlar una amplia gama de actividades comerciales, desde la creación de productos y categorías hasta la gestión de ventas y pagos. El sistema se enfocará en la facilidad de uso y la accesibilidad para brindar a los empleados las herramientas necesarias para mejorar la experiencia del cliente y maximizar la eficiencia operativa.

### Definición o planteamiento del problema

El objetivo principal del sistema es resolver una serie de problemas que la cafetería actualmente enfrenta en su operación diaria. A continuación se enumeran los problemas encontrados:

Falta de un sistema integrado: la cafetería no tiene un sistema unificado para administrar las ventas, los pagos y la información del cliente de manera eficiente. Esto conduce a un manejo de información desorganizado y a una experiencia de cliente insatisfactoria.

Problemas con el seguimiento de las ventas: si la cafetería no tiene un registro adecuado de las ventas, tiene problemas para analizar su rendimiento diario, semanal o mensual. La toma de decisiones sobre la gestión de inventarios, las promociones y el servicio al cliente se ve obstaculizada por la falta de datos precisos.

Gestión ineficiente de clientes: la atención al cliente es un aspecto crucial del sector gastronómico. La personalización del servicio es difícil sin un sistema que registre la información del cliente y sus preferencias, lo que podría mejorar la satisfacción del cliente y fomentar la fidelización.

Control insuficiente de permisos de usuario: Cuando hay muchos usuarios en un sistema, como meseros, gerentes o administradores, es crucial tener un control de permisos que limite el acceso a ciertas funciones del sistema según el rol del usuario. Los errores y los problemas de seguridad pueden resultar de la falta de esta funcionalidad.

Gestión de pagos poco clara: si no hay un sistema claro para administrar los pagos y su estado, se corre el riesgo de errores en la contabilización de ingresos y la conciliación de cuentas. Esto puede tener un impacto en la rentabilidad y la viabilidad de la empresa.

### Objetivos Del Trabajo Practico ###

El objetivo principal del trabajo es desarrollar un sistema de gestión para una cafetería que solucione los problemas actuales relacionados con la gestión de clientes, ventas, productos, pagos, meseros, y permisos de usuario. El sistema está diseñado para mejorar tanto la atención al cliente como la eficiencia operativa interna, proporcionando una herramienta que permita gestionar y analizar los datos de manera integrada y accesible.

**Objetivos Generales**

El objetivo general de este Trabajo Práctico es la creación de un sistema unificado que permita la administración eficiente de las operaciones diarias de la cafetería, mejorando la experiencia del cliente y optimizando los procesos internos.

**Objetivos Específicos**

 **1)** Integrar la gestión de ventas, pagos y clientes en una única plataforma para evitar la desorganización de datos y mejorar la    
   experiencia del cliente.
   
 **2)** Facilitar el seguimiento y análisis de las ventas mediante reportes precisos que permitan una mejor toma de decisiones en áreas 
   como inventarios y promociones.
   
 **3)** Implementar un control de permisos de usuarios para garantizar que cada empleado acceda solo a las funciones necesarias según 
   su rol, mejorando la seguridad y reduciendo errores.
   
 **4)** Optimizar la gestión de pagos, proporcionando un registro claro de transacciones para mejorar la contabilidad y la conciliación 
   de cuentas.

## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

**TEMA 1 "  Manejo de permisos a nivel de usuarios de base de datos  "**

> Acceder a la siguiente carpeta para ver el desarrollo del tema [Manejo de permisos a nivel de usuarios de base de datos](https://github.com/yoaoz/The-Coffee/blob/main/script/Tema01_Manejo_De_Permisos_A_Nivel_De_Usuarios/tema_01_Manejo_De_Permisos_A_Nivel_De_Usuarios.md)

**TEMA 2 " Procedimientos y funciones almacenadas "** 

> Acceder a la siguiente carpeta para ver el desarrollo del tema [Procedimientos y funciones almacenadas](https://github.com/yoaoz/The-Coffee/blob/main/script/Tema02_Procedimientos_Y_Funciones_Almacenadas/tema_02_Procedimientos_Y_Funciones_Almacenadas.md)

**TEMA 3 " Optimización de consultas a través de índices "** 

> Acceder a la siguiente carpeta para ver el desarrollo del tema [Optimización de consultas a través de índices](https://github.com/yoaoz/The-Coffee/blob/main/script/Tema_03_Optimizaci%C3%B3n_de_consultas_a_trav%C3%A9s_de_%C3%ADndices/Optimizaci%C3%B3n_de_consultas_a_trav%C3%A9s_de_%C3%ADndices.md)

**TEMA 4 " Índices columnares en SQL server "**  

> Acceder a la siguiente carpeta para ver el desarrollo del tema [Índices columnares en SQL server](https://github.com/yoaoz/The-Coffee/blob/main/script/Tema_04_%C3%8Dndices_columnares_en_SQL_server/%C3%8Dndices_columnares_en_SQL_server.md)

## CAPÍTULO III: METODOLOGÍA SEGUIDA 


 **a) Cómo se realizó el Trabajo Práctico**
Lo primero que hicimos fue decidir el caso estudio, cada uno propuso sus ideas y se terminó votando por el actual que nos pareció más idóneo.
Luego se creó el diseño del Modelo Entidad-Relacion (ER), y posteriormente se hizo la carga de datos y a continuación el diccionario de datos.

Luego de la primera entrega cada uno procedió a seleccionar un tema y desarrollarlo:
- Manejo de permisos a nivel de usuarios de base de datos.
- Procedimientos y funciones almacenadas.
- Optimización de consultas a través de índices.
- Índices columnares en SQL Server.

 **b) Herramientas (Instrumentos y procedimientos)**

Utilizamos las siguientes herramientas:

- ERD Plus es una herramienta intuitiva y efectiva para el modelado de bases de datos, que permite crear diagramas relacionales y conceptuales, además de generar código SQL. Con ERD Plus, logramos diseñar el esquema conceptual de nuestro proyecto.

- SQL Server Management Studio 20 es un software de administración de bases de datos creado por Microsoft, diseñado principalmente para trabajar con SQL Server y otros lenguajes de consulta, allí desarrollamos las consultas para los temas individuales y carga de datos.

- Excel se utilizó para elaborar el diccionario de datos de la base de datos.

## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 
### Diagrama relacional
![diagrama_relacional](https://github.com/yoaoz/The-Coffee/blob/main/doc/modelo_relacional.png)

### Diccionario de datos

Acceso al documento [PDF](doc/Diccionario_de_Datos.pdf) del diccionario de datos.

### Desarrollo TEMA 1 "Manejo de permisos a nivel de usuarios de base de datos"
> Acceder a la siguiente carpeta para ver el desarrollo del script [Manejo de permisos a nivel de usuarios de base de datos](https://github.com/yoaoz/The-Coffee/tree/main/script/Tema01_Manejo_De_Permisos_A_Nivel_De_Usuarios)

### Desarrollo TEMA 2 "Procedimientos y funciones almacenadas"
> Acceder a la siguiente carpeta para ver el desarrollo del script [Procedimientos y funciones almacenadas](https://github.com/yoaoz/The-Coffee/blob/main/script/Tema02_Procedimientos_Y_Funciones_Almacenadas/procedimientosYFuncionesAlmacenadas_script.sql)

### Desarrollo TEMA 3 "Optimización de consultas a través de índices"
> Acceder a la siguiente carpeta para ver el desarrollo del script [Optimización de consultas a través de índices](https://github.com/yoaoz/The-Coffee/blob/main/script/Tema_03_Optimizaci%C3%B3n_de_consultas_a_trav%C3%A9s_de_%C3%ADndices/script.sql)

### Desarrollo TEMA 4 "Índices columnares en SQL server"
> Acceder a la siguiente carpeta para ver el desarrollo del script [Índices columnares en SQL server](https://github.com/yoaoz/The-Coffee/blob/main/script/Tema_04_%C3%8Dndices_columnares_en_SQL_server/script.sql)

## CAPÍTULO V: CONCLUSIONES

Este trabajo práctico nos facilitó comprender la relevancia de una estructura y diseño apropiados de las bases de datos para la adecuada administración de la información. En el transcurso de este proyecto, logramos todos los objetivos establecidos, resaltando la optimización en la gestión de datos fundamentales como: la gestión de permisos a nivel de usuario, la mejora de consultas y la optimización del rendimiento mediante el uso de índices columnares para el manejo de grandes volúmenes de información.
La gestión de los permisos a nivel de usuarios es crucial para la protección de la información, proporcionando un control sobre las actividades que cada usuario puede llevar a cabo en la base de datos.

Respecto a la mejora de las consultas, la aplicación de índices convencionales incrementó de manera notable el desempeño, acelerando los tiempos de respuesta durante las búsquedas y accesos a la información.
El uso de procesos y funciones guardadas posibilitó la modularización de la realización de tareas reiterativas y complejas.
Los índices en columna en SQL server han probado ser esenciales para gestionar grandes volúmenes de datos, dado que optimizan el desempeño en la lectura y el análisis de la información.
La adecuada aplicación de estos principios facilitó la obtención de una solución eficaz y segura, en concordancia con los objetivos establecidos. Este proyecto no solo nos facilitó la comprensión de los conocimientos obtenidos y la adquisición de nuevos saberes, sino que también nos demostró la importancia de una gestión meticulosa y organizada de las bases de datos en contextos prácticos.

## BIBLIOGRAFÍA DE CONSULTA

 1. - Procedimientos almacenados: https://learn.microsoft.com/es-es/sql/relational-databases/stored-procedures/stored-procedures-database-engine?view=sql-server-ver16
 2. - Create Function (Transact-SQL): https://learn.microsoft.com/es-es/sql/t-sql/statements/create-function-transact-sql?view=sql-server-ver16
 3. - Roles en el nivel de base de datos: https://learn.microsoft.com/es-es/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16
 4. - Índices columnares en SQL server: https://learn.microsoft.com/es-es/sql/relational-databases/indexes/columnstore-indexes-overview?view=sql-server-ver16
 5. - Referencia: Medina, B. (2019, octubre 16). Diseño efectivo de índices agrupados SQL Server. SQLShack en Español. https://www.sqlshack.com/es/diseno-efectivo-de-indices-agrupados-sql-server/
 6. - Referencia: Medina, B. (2019, octubre 9). ¿Cuál es la diferencia entre índices agrupados y no agrupados en SQL Server? SQLShack en Español. https://www.sqlshack.com/es/cual-es-la-diferencia-entre-indices-agrupados-y-no-agrupados-en-sql-server/
 7. - Referencia: Listopro Community. (n.d.). Índices y optimización en SQL. Listopro Community. https://community.listopro.com/indices-y-optimizacion-en-sql/

