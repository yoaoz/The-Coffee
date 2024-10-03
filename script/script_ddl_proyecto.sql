-- SCRIPT TEMA "TheCoffee"
-- DEFINNICIÓN DEL MODELO DE DATOS

Create DataBase DBTheCoffee

Use DBTheCoffee 

CREATE TABLE rol_usuario
(
  id_rol INT NOT NULL IDENTITY(1,1),
  descripcion VARCHAR(50) NOT NULL,
  estado BIT CONSTRAINT DF_rol_usuario_estado DEFAULT 1 NOT NULL ,
  CONSTRAINT PK_Rol_id  PRIMARY KEY (id_rol),
  CONSTRAINT UQ_Rol_descripcion UNIQUE (descripcion)
);

CREATE TABLE Categoria
(
  id_categoria INT NOT NULL IDENTITY(1,1),
  descripcion VARCHAR(50) NOT NULL,
  estado BIT CONSTRAINT DF_Categoria_estado DEFAULT 1 NOT NULL,
  CONSTRAINT PK_Categoria_id  PRIMARY KEY (id_categoria),
  CONSTRAINT UQ_Categoria_descripcion UNIQUE (descripcion)
);

CREATE TABLE Mesero
(
  id_mesero INT NOT NULL IDENTITY(1,1),
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  hora_entrada INT NOT NULL,
  hora_salida INT NOT NULL,
  dni INT NOT NULL,
  telefono INT NOT NULL,
  estado BIT CONSTRAINT DF_Mesero_estado DEFAULT 1 NOT NULL,
  CONSTRAINT PK_Mesero_id  PRIMARY KEY (id_mesero),
  CONSTRAINT UQ_Mesero_dni UNIQUE (dni),
  CONSTRAINT UQ_Mesero_telefono UNIQUE (telefono),
  CONSTRAINT CK_Horario CHECK (hora_entrada < hora_salida),
  CONSTRAINT CK_hora CHECK (hora_entrada BETWEEN 1 AND 24 AND hora_salida BETWEEN 1 AND  24),
CONSTRAINT CK_Diferencia_Horas CHECK (hora_salida - hora_entrada <= 8),
CONSTRAINT CK_DNI CHECK (dni BETWEEN 0 AND 99999999)
);

CREATE TABLE Mesa
(
  id_mesa INT NOT NULL IDENTITY(1,1),
  nro_mesa INT NOT NULL,
  cantidad_sillas INT NOT NULL,
  estado BIT CONSTRAINT DF_Mesa_estado DEFAULT 1 NOT NULL,
  CONSTRAINT PK_Mesa_id  PRIMARY KEY (id_mesa),
  CONSTRAINT UQ_Mesa_nro_mesa UNIQUE (nro_mesa)
);



CREATE TABLE Cliente
(
  id_cliente INT IDENTITY(1,1) NOT NULL,
  cuit INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  domicilio VARCHAR(100) NOT NULL,
  localidad VARCHAR(100) NOT NULL,
  provincia VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  telefono INT,
  CONSTRAINT PK_Cliente_id PRIMARY KEY (id_cliente),
  CONSTRAINT UQ_Cliente_cuit UNIQUE (cuit),
  CONSTRAINT UQ_Cliente_email UNIQUE (email)
);

CREATE TABLE Producto
(
  id_producto INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255) NOT NULL,
  precio FLOAT NOT NULL,
  imagen VARCHAR(150) NOT NULL,
  estado BIT CONSTRAINT DF_Producto_estado DEFAULT 1 NOT NULL,
  id_categoria INT NOT NULL,
  CONSTRAINT PK_Producto_id PRIMARY KEY (id_producto),
  CONSTRAINT FK_Producto_Categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Medio_Pago
(
  id_medio_pago INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_medio_pago_id PRIMARY KEY (id_medio_pago)
);

CREATE TABLE Caja
(
  id_caja INT IDENTITY(1,1) NOT NULL,
  nro_caja INT NOT NULL,
  estado BIT CONSTRAINT DF_Caja_estado DEFAULT 1 NOT NULL,
  disponible BIT CONSTRAINT DF_Caja_disponible DEFAULT 1 NOT NULL,
  CONSTRAINT PK_Caja_id PRIMARY KEY (id_caja),
  CONSTRAINT UQ_Caja_nro_caja UNIQUE (nro_caja)
);


CREATE TABLE Permiso
(
  id_permiso INT IDENTITY(1,1) NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  CONSTRAINT PK_Permiso_id PRIMARY KEY (id_permiso),
  CONSTRAINT UQ_Permisol_descripcion UNIQUE (descripcion)
);



CREATE TABLE Rol_Permiso
(
  id_permiso INT NOT NULL,
  id_rol INT NOT NULL,
  CONSTRAINT PK_Rol_Permiso_id_rol_id_permiso  PRIMARY KEY (id_permiso, id_rol),
  CONSTRAINT FK_Rol_Permiso_id_permiso FOREIGN KEY (id_permiso) REFERENCES Permiso(id_permiso),
  CONSTRAINT FK_Rol_Permiso_id_rol FOREIGN KEY (id_rol) REFERENCES rol_usuario(id_rol)
);

CREATE TABLE Usuario
(
  id_usuario INT IDENTITY(1,1)  NOT NULL,
  nombre VARCHAR(90) NOT NULL,
  contraseña VARCHAR(100) NOT NULL,
  usuario VARCHAR(50) NOT NULL,
  telefono INT NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  estado BIT CONSTRAINT DF_Usuario_estado DEFAULT 1 NOT NULL,
  id_rol INT NOT NULL,
  CONSTRAINT PK_Usuario_id  PRIMARY KEY (id_usuario),
  CONSTRAINT FK_Usuario_id_rol FOREIGN KEY (id_rol) REFERENCES rol_usuario(id_rol),
  CONSTRAINT UQ_Usuario_usuario  UNIQUE (usuario),
  CONSTRAINT UQ_Usuario_telefono UNIQUE (telefono)
);

CREATE TABLE Turno_Caja
(
  id_turno INT IDENTITY(1,1) NOT NULL,
  fecha_apertura DATE CONSTRAINT DF_Turno_Caja_fecha_apertura DEFAULT GETDATE(),
  monto_inicial FLOAT NOT NULL,
  monto_cierre FLOAT NOT NULL,
  observaciones VARCHAR(255) NOT NULL,
  fecha_cierre DATE CONSTRAINT DF_Turno_Caja_fecha_cierre DEFAULT GETDATE(),
  id_caja INT NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT PK_Turno_Caja_id_turno_id_caja  PRIMARY KEY (id_turno, id_caja),
  CONSTRAINT FK_Turno_Caja_id_caja  FOREIGN KEY (id_caja) REFERENCES Caja(id_caja),
  CONSTRAINT FK_Turno_Caja_id_usuario  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Movimiento_Caja
(
  id_movimiento INT IDENTITY(1,1) NOT NULL,
  tipo_movimiento VARCHAR(50) NOT NULL,
  monto FLOAT NOT NULL,
  fecha DATE CONSTRAINT DF_Movimiento_Caja_fecha DEFAULT GETDATE(),
  descripcion VARCHAR(255) NOT NULL,
  id_turno INT NOT NULL,
  id_caja INT NOT NULL,
  CONSTRAINT PK_Moviento_Caja_id  PRIMARY KEY (id_movimiento),
  CONSTRAINT FK_Movimiento_Caja_id_turno_id_caja FOREIGN KEY (id_turno, id_caja) REFERENCES Turno_Caja(id_turno, id_caja)
);

CREATE TABLE Venta
(
  id_ventas INT IDENTITY(1,1) NOT NULL,
  fecha_venta DATE CONSTRAINT DF_Venta_fecha DEFAULT GETDATE(),
  monto_total FLOAT NOT NULL,
  id_mesero INT NOT NULL,
  id_mesa INT NOT NULL,
  id_cliente INT,
  id_turno INT NOT NULL,
  id_caja INT NOT NULL,
  CONSTRAINT PK_Venta_id  PRIMARY KEY (id_ventas),
  CONSTRAINT FK_Venta_id_mesero FOREIGN KEY (id_mesero) REFERENCES Mesero(id_mesero),
  CONSTRAINT FK_Venta_id_mesa FOREIGN KEY (id_mesa) REFERENCES Mesa(id_mesa),
  CONSTRAINT FK_Venta_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  CONSTRAINT FK_Venta_id_turno_id_caja FOREIGN KEY (id_turno, id_caja) REFERENCES Turno_Caja(id_turno, id_caja)
);

CREATE TABLE Venta_Detalle
(
  id_detalle INT IDENTITY(1,1) NOT NULL,
  cantidad INT NOT NULL,
  subtotal FLOAT NOT NULL,
  precio_unitario FLOAT NOT NULL,
  id_producto INT NOT NULL,
  id_ventas INT NOT NULL,
  CONSTRAINT PK_Venta_Detalle_id  PRIMARY KEY (id_detalle),
  CONSTRAINT FK_Venta_Detalle_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  CONSTRAINT FK_Venta_Detalle_Venta FOREIGN KEY (id_ventas) REFERENCES Venta(id_ventas)
);

CREATE TABLE Pago
(
  id_pago INT IDENTITY(1,1) NOT NULL,
  estado VARCHAR(50) CONSTRAINT DF_Pago_estado DEFAULT 'en proceso'  ,
  id_ventas INT NOT NULL,
  id_medio_pago INT NOT NULL,
  CONSTRAINT PK_Pago_id  PRIMARY KEY (id_pago),
  CONSTRAINT FK_Pago_Venta FOREIGN KEY (id_ventas) REFERENCES Venta(id_ventas),
  CONSTRAINT FK_Pago_Medio_pago FOREIGN KEY (id_medio_pago) REFERENCES Medio_Pago(id_medio_pago),
  CONSTRAINT CK_Pago_Estado CHECK (estado IN ('en proceso', 'rechazado', 'finalizado'))	
);
