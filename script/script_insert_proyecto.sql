-- SCRIPT "TheCoffee"
-- INSERCIÓN DEL LOTE DE DATOS

—------LOTE DE DATOS

-- Insertar roles
INSERT INTO rol_usuario (descripcion) VALUES
 ('Administrador'),
('Cajero');

-- Insertar categorías
INSERT INTO Categoria (descripcion) VALUES
 ('Café'),
('Tortas');

-- Insertar meseros
INSERT INTO Mesero (nombre, apellido, hora_entrada, hora_salida, dni, telefono) 
VALUES 
('Juan', 'Pérez', 8, 16, 32345678, 123456789),
('Ana', 'Gómez', 9, 17, 87654321, 987654321);

-- Insertar mesas
INSERT INTO Mesa (nro_mesa, cantidad_sillas) VALUES
(1, 4),
(2,2);

-- Insertar clientes
INSERT INTO Cliente (cuit, nombre, apellido, domicilio, localidad, provincia, email, telefono) 
VALUES
 (20304050, 'Luis', 'Martínez', 'Calle Falsa 123', 'Ciudad', 'Provincia', 'luis@email.com', 111222333);

-- Insertar productos
INSERT INTO Producto (nombre, descripcion, precio, imagen, id_categoria) VALUES 
('Café', 'Café recién hecho', 2.50, 'cafe.jpg', 1),
('Sándwich', 'Sándwich de jamón y queso', 5.00, 'sandwich.jpg', 2);

-- Insertar medio de pago
INSERT INTO Medio_Pago (nombre) VALUES 
('Efectivo'),
('Tarjeta de Crédito');

-- Insertar caja
INSERT INTO Caja (nro_caja, estado) VALUES
(1),
(2);

-- Insertar permisos
INSERT INTO Permiso (descripcion) VALUES 
('Agregar Producto'),
 ('Eliminar Producto');

-- Insertar roles y permisos
INSERT INTO Rol_Permiso (id_permiso, id_rol) VALUES 
(1, 1),
(2, 1);

-- Insertar usuarios
INSERT INTO Usuario (nombre, contraseña, usuario, telefono, apellido, id_rol) 
VALUES ('Emilia', 'EmiliaEspinola1234', 'emilia', 123456789, ‘Espinola’', 1);

-- Insertar turno de caja
INSERT INTO Turno_Caja (monto_inicial, monto_cierre, observaciones, id_caja, id_usuario) 
VALUES (1000.00, 1000000.00, 'Apertura de caja', 1, 1);

-- Insertar venta
INSERT INTO Venta (monto_total, id_mesero, id_mesa, id_cliente, id_turno, id_caja) 
VALUES (20.00, 1, 1, 1, 1, 1);

-- Insertar detalles de venta
INSERT INTO Venta_Detalle (cantidad, subtotal, precio_unitario, id_producto, id_ventas) 
VALUES (2, 5.00, 2.50, 1, 1);

-- Insertar pago
INSERT INTO Pago (id_ventas, id_medio_pago) VALUES (1, 1);



—-----LOTE DE PRUEBA

-- Insertar meseros
INSERT INTO Mesero (nombre, apellido, hora_entrada, hora_salida, dni, telefono) 
VALUES 
('Maria', 'Pérez', 8, 22, 45939582, 1234567892421); —---- No se cumple con la restricción CK_Diferencia_Horas.

-- Insertar meseros
INSERT INTO Mesero (nombre, apellido, hora_entrada, hora_salida, dni, telefono) 
VALUES 
('Maria', 'Pérez', 8, 22, 4593958212, 1234567892421); —---- DNI supera los 8 dígitos.

-- Insertar meseros
INSERT INTO Mesero (nombre, apellido, hora_entrada, hora_salida, dni, telefono) 
VALUES 
('Sofia', ‘Martinez', 50, 20, 323456, 12345678921); —----la hora_entrada supera el número 24.

-- Insertar mesas
INSERT INTO Mesa (nro_mesa, cantidad_sillas) VALUES
(1, 4);  —---- Mesa repetida.

-- Insertar meseros
INSERT INTO Mesero (nombre, apellido, hora_entrada, hora_salida, dni, telefono) 
VALUES 
('Maria', 'Pérez', 8, 20, 32345678454545, 4567892421); —- DNI repetido

