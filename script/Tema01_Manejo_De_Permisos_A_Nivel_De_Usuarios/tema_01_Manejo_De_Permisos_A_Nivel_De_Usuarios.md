# Manejo de permisos a nivel de usuarios de base de datos


## Introducción
El manejo de permisos a nivel de usuarios en una base de datos es un aspecto crucial de la administración de seguridad, ya que define quién puede acceder a los datos y qué acciones pueden realizar sobre ellos. Los permisos se asignan a los usuarios para controlar su capacidad de leer, modificar, insertar o eliminar datos en la base de datos, y se pueden gestionar de manera más eficiente al asignar estos permisos a través de **roles**, grupos de usuarios con permisos similares.

## Permisos a Nivel de Usuarios
Los permisos a nivel de usuarios permiten asignar derechos específicos a individuos dentro del sistema de base de datos. Esto se puede realizar para otorgar acceso a un conjunto limitado de datos o funcionalidades. Por ejemplo, un usuario puede tener permiso solo para consultar ciertas tablas, pero no para modificar datos. Los permisos a nivel de usuario permiten un control granular sobre lo que cada persona o aplicación puede hacer dentro de la base de datos.

#### Crear y asignar permisos a un usuario 

```sql

CREATE LOGIN emi WITH PASSWORD = '1234';
CREATE USER emilia FOR LOGIN emi;

--- Dar solo permiso de lectura al usuario_read
EXEC sp_addrolemember 'db_datareader', 'emilia';
```

## Permisos a Nivel de Roles
Los permisos a nivel de roles son una forma más eficiente de gestionar derechos de acceso, especialmente cuando hay muchos usuarios con necesidades similares. Los roles agrupan varios permisos, y luego estos roles se asignan a los usuarios. Por ejemplo, un rol de "Administrador" puede tener permisos de lectura, escritura y eliminación, mientras que un rol de "Usuario" solo tiene permisos de lectura. Esto simplifica la administración, ya que los permisos no necesitan asignarse a cada usuario individualmente, sino a los roles, y luego los usuarios son añadidos a estos roles según su necesidad.

#### Crear un Rol y Asignar Permisos al Rol

```sql
---  Crear un rol que solo permita la lectura de la tabla
CREATE ROLE rol_lectura;

-- Conceder permisos de solo lectura al rol
GRANT SELECT ON Mesa TO rol_lectura;

-- Paso 4: Darle permiso a uno de los usuarios sobre el rol creado
EXEC sp_addrolemember 'rol_lectura', 'sofia';
```

## Conclusión
El manejo de permisos a nivel de usuarios y roles es esencial para asegurar el acceso adecuado a la base de datos. Mientras que los permisos a nivel de usuarios proporcionan control detallado sobre el acceso de cada individuo, los permisos a nivel de roles permiten una administración más eficiente y escalable al agrupar usuarios con necesidades similares. Ambos mecanismos trabajan juntos para mantener la seguridad y la integridad de los datos, asegurando que solo las personas autorizadas puedan realizar ciertas acciones.
