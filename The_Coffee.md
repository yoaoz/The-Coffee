# PRESENTACIÓN (The Coffee)

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:
 - Coronel, Juan
 - Espinola, Emilia
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

**TEMA 1 " ---- "** 
-


**TEMA 2 " ----- "** 
Un procedimiento almacenado y una función almacenada son ambos objetos de base de datos que contienen bloques de código SQL que pueden ser ejecutados por el sistema de gestión de bases de datos (SGBD). Aunque ambos sirven para encapsular lógica que puede ser reutilizada, tienen algunas diferencias clave en cuanto a su propósito, comportamiento y características. Vamos a desglosar cada u

1. Procedimiento almacenado (Stored Procedure)
Definición: Un procedimiento almacenado es un conjunto de instrucciones SQL que se almacenan y se ejecutan en la base de datos. Generalmente, se utilizan para realizar operaciones complejas o repetitivas que implican manipulación de datos o administración de la base de datos.

Características:

Puede realizar operaciones de modificación de datos, como INSERT, UPDATE y DELETE.
No devuelve un valor directo (aunque puede devolver un valor de estado o código de error a través de parámetros de salida).
Puede aceptar parámetros de entrada y parámetros de salida.
Es posible realizar transacciones dentro del procedimiento.
Puede no devolver nada explícitamente, aunque puede generar resultados a través de un conjunto de resultados, o también puede retornar un código de estado.
2. Función almacenada (Stored Function)
Definición: Una función almacenada es un conjunto de instrucciones SQL que también se almacena en la base de datos, pero a diferencia de un procedimiento, una función siempre devuelve un valor. Este valor se puede utilizar en una expresión SQL o como parte de una consulta.

Características:

Siempre devuelve un valor (puede ser un valor simple, como un número o una cadena, o incluso un conjunto de resultados en algunos SGBD).
No debe realizar modificaciones en la base de datos (no debe tener operaciones de tipo INSERT, UPDATE o DELETE). Su uso principal es el cálculo o la obtención de valores a partir de los datos.
Puede aceptar parámetros de entrada.
Se utiliza principalmente en consultas SELECT o en expresiones.

En resumen, la principal diferencia es que las funciones se utilizan cuando necesitamos un valor a ser utilizado en una expresión o consulta, mientras que los procedimientos son más adecuados para realizar acciones complejas dentro de la base de datos sin necesidad de devolver un valor directo.

-

## CAPÍTULO III: METODOLOGÍA SEGUIDA 

-

 **a) Cómo se realizó el Trabajo Práctico**
-

 **b) Herramientas (Instrumentos y procedimientos)**
-


## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 

-
### Diagrama relacional
![diagrama_relacional](https://github.com/yoaoz/The-Coffee/blob/main/doc/modelo_relacional.png)

### Diccionario de datos

Acceso al documento [PDF](doc/Diccionario_de_Datos.pdf) del diccionario de datos.


### Desarrollo TEMA 1 "----"

-

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_1](script/tema01_nombre_tema)

### Desarrollo TEMA 2 "----"

-

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_2](script/tema02_nombre_tema)

... 


## CAPÍTULO V: CONCLUSIONES

-



## BIBLIOGRAFÍA DE CONSULTA

 1. -
 2. -
 3. -
 4. -
 5. -

