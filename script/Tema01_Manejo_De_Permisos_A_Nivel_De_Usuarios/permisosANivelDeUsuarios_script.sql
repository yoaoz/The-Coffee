---- Procedimiento para insertar una Mesa
GO
CREATE PROCEDURE sp_InsertarMesa
    @NroMesa INT,
    @CantSillas INT
AS
BEGIN
    -- Realizar el INSERT en la tabla Empleados
    INSERT INTO Mesa(nro_mesa,cantidad_sillas)
    VALUES (@NroMesa, @CantSillas);
END
GO
--- Permisos a nivel de usuarios ---

-- Crear dos usuarios de base de datos
CREATE LOGIN emi WITH PASSWORD = '1234';
CREATE LOGIN jose WITH PASSWORD = '1234';

CREATE USER emilia FOR LOGIN emi;
CREATE USER josefina FOR LOGIN jose;

-- Dar permisos de administrador al usuario_admin
EXEC sp_addrolemember 'db_owner', 'emilia';

-- Dar solo permiso de lectura al usuario_read
EXEC sp_addrolemember 'db_datareader', 'josefina';

-- Dar permiso de ejecución sobre el procedimiento almacenado al usuario_read
GRANT EXECUTE ON sp_insertarMesa TO josefina;

-- Realizar un INSERT utilizando el usuario_admin
-- Conectar como usuario_admin
INSERT INTO  Mesa (nro_mesa, cantidad_sillas) VALUES (1, 4);

-- Realizar un INSERT utilizando el usuario_read (esto no debería funcionar directamente)
-- Conectar como usuario_read
INSERT INTO  Mesa (nro_mesa, cantidad_sillas) VALUES (2, 6);  -- Esto fallará

-- Realizar un INSERT a través del procedimiento almacenado con el usuario_read
-- Conectar como usuario_read
EXEC sp_insertarMesa 3,4;
