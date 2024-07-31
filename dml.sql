
INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico) VALUES
('001', 'Juan', 'Perez', 1234567890, '123', 'juan.perez@gmail.com'),
('002', 'Maria', 'Gomez', 2345678901, '456', 'maria.gomez@gmail.com');


INSERT INTO categorias (descripcion, estado) VALUES
('computo', 'Activo'),
('vestimenta', 'Activo');


INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado) VALUES
('Laptop', 1, '1234567890123', 1500.00, 10, 'Activo'),
('celular', 1, '394934345', 2000.00, 10, 'Activo'),
('Camiseta', 2, '9876543210987', 20.00, 50, 'Activo');


INSERT INTO compras (id_cliente, fecha, medio_pago, comentario, estado) VALUES
('001', '2024-07-31', 'Tarjeta de Credito', 'Compra de laptop', 'Aprobado'),
('002', '2024-07-31', 'efectivo', 'Compra de camiseta', 'Aprobado');


INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado) VALUES
(1, 1, 1, 1500.00, 'Aprobado'),
(1, 2, 10, 100.00, 'Aprobado'),
(2, 2, 2, 40.00, 'Aprobado');
