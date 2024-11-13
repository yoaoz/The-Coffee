---Permisos a nivel de roles del DBMS:
CREATE LOGIN sofia WITH PASSWORD = '1234';
CREATE LOGIN maria WITH PASSWORD = '1234';

-- Crear usuarios en la base de datos
CREATE USER sofia FOR LOGIN sofia;
CREATE USER maria FOR LOGIN maria;

--- Paso 3: Crear un rol que solo permita la lectura de la tabla
CREATE ROLE rol_lectura;

-- Conceder permisos de solo lectura al rol
GRANT SELECT ON Mesa TO rol_lectura;

-- Paso 4: Darle permiso a uno de los usuarios sobre el rol creado
EXEC sp_addrolemember 'rol_lectura', 'sofia';

-- Paso 5: Verificar el comportamiento de ambos usuarios

-- Conectarse como sofia (con permisos)
-- Este bloque se ejecutaría como una sesión diferente
-- \c -U sofia
SELECT * FROM Mesa;

-- Conectarse como maria (sin permisos)
-- Este bloque se ejecutaría como una sesión diferente
-- \c -U maria
SELECT * FROM Mesa; -- Debería fallar

-- Conclusiones
-- El usuario1 sofia, que tiene asignado el rol de lectura, puede ver el contenido de la tabla.
-- El usuario2 maria, que no tiene permisos, recibirá un error de acceso denegado al intentar leer la tabla.
