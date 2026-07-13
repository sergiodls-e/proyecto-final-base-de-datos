CREATE DATABASE IF NOT EXISTS tienda_electronica;
USE tienda_electronica;

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    CONSTRAINT PK_Categorias PRIMARY KEY (id_categoria),
    CONSTRAINT UQ_Categoria_Nombre UNIQUE (nombre)
) ENGINE=InnoDB;

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    CONSTRAINT PK_Clientes PRIMARY KEY (id_cliente),
    CONSTRAINT UQ_Cliente_Correo UNIQUE (correo)
) ENGINE=InnoDB;

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) UNSIGNED NOT NULL,
    stock INT UNSIGNED NOT NULL DEFAULT 0,
    CONSTRAINT PK_Productos PRIMARY KEY (id_producto),
    CONSTRAINT FK_Productos_Categorias FOREIGN KEY (id_categoria)
        REFERENCES Categorias (id_categoria)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'enviado', 'entregado') NOT NULL DEFAULT 'pendiente',
    CONSTRAINT PK_Pedidos PRIMARY KEY (id_pedido),
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Detalles_Pedido (
    id_detalle INT AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT UNSIGNED NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) UNSIGNED NOT NULL,
    CONSTRAINT PK_Detalles_Pedido PRIMARY KEY (id_detalle),
    CONSTRAINT FK_Detalles_Pedidos FOREIGN KEY (id_pedido)
        REFERENCES Pedidos (id_pedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Detalles_Productos FOREIGN KEY (id_producto)
        REFERENCES Productos (id_producto)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Reseñas (
    id_reseña INT AUTO_INCREMENT,
    id_producto INT NOT NULL,
    id_cliente INT NOT NULL,
    calificacion INT UNSIGNED NOT NULL,
    comentario TEXT,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Reseñas PRIMARY KEY (id_reseña),
    CONSTRAINT FK_Reseñas_Productos FOREIGN KEY (id_producto)
        REFERENCES Productos (id_producto)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Reseñas_Clientes FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CK_Calificacion CHECK (calificacion BETWEEN 1 AND 5)
) ENGINE=InnoDB;

CREATE INDEX idx_productos_precio ON Productos(precio);
CREATE INDEX idx_pedidos_fecha_estado ON Pedidos(fecha_pedido, estado);
CREATE INDEX idx_reseñas_producto_fecha ON Reseñas(id_producto, fecha);
