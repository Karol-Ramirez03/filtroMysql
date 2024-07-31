CREATE DATABASE comprafiltro;
USE comprafiltro;

CREATE TABLE clientes (
    id VARCHAR(20) ,
    nombre VARCHAR(40),
    apellidos VARCHAR(40),
    celular DECIMAL(10,0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70),
    CONSTRAINT pk_clientes_id PRIMARY KEY (id)
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT,
    descripcion VARCHAR(45),
    estado VARCHAR(30),
    CONSTRAINT pk_categoria_id PRIMARY KEY (id_categoria)
); 


CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(45),
    id_categoria INT,
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(16,2),
    cantidad_stock INT,
    estado VARCHAR(30),
    CONSTRAINT pk_producto_id PRIMARY KEY (id_producto),
    CONSTRAINT fk_categoria_producto FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
    
);


CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT,
    id_cliente VARCHAR(20),
    fecha DATE,
    medio_pago VARCHAR(30),
    comentario VARCHAR(300),
    estado VARCHAR(30),
    CONSTRAINT pk_compras_id PRIMARY KEY (id_compra),
    CONSTRAINT fk_clientes_compras FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE compras_productos (
    id_compras_productos INT AUTO_INCREMENT,
    id_compra INT,
    id_producto INT,
    cantidad INT,
    total DECIMAL(16,2),
    estado VARCHAR(30),
    CONSTRAINT pk_compras_productos_id PRIMARY KEY (id_compras_productos),
    CONSTRAINT fk_compras_productos_compra FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    CONSTRAINT Fk_compras_productos_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
