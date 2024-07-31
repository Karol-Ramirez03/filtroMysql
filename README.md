## Consultas Básicas
### Consultar todos los productos y sus categorías
```sql

SELECT nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado
FROM productos;

```


### Consultar todas las compras y los clientes que las realizaron

```sql
SELECT c.id_cliente,cl.nombre, c.fecha, c.medio_pago
FROM compras c
JOIN clientes cl ON cl.id = c.id_cliente;


```
### Consultar los productos comprados en una compra específica

```sql
 SELECT p.nombre
 FROM compras_productos cp
 JOIN productos p ON  p.id_producto = cp.id_producto
 WHERE id_compra = 1;


```
### Agregar un nuevo producto

```sql
INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado) 
VALUES ('teclado', 1, '345567282', 20000.00, 10, 'Activo');


```
### Actualizar el stock de un producto
```sql
UPDATE productos
SET cantidad_stock = 15
WHERE id_producto = 3;

```
Consultar todas las compras de un cliente específico
```sql
SELECT cl.nombre, p.nombre, cp.cantidad
FROM compras_productos cp
JOIN productos p ON  p.id_producto = cp.id_producto
JOIN compras c ON cp.id_compra = c.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
WHERE cl.id = '001';

```
Consultar todos los clientes y sus correos electrónicos
```sql
SELECT nombre, apellidos , correo_electronico
FROM clientes;

```
Consultar la cantidad total de productos comprados en cada compra
```sql
SELECT SUM(cp.cantidad)
FROM compras_productos cp
GROUP BY cp.id_compra;

```
Consultar las compras realizadas en un rango de fechas
```sql
SELECT id_cliente,fecha, medio_pago
FROM compras
WHERE fecha BETWEEN '2024-01-01' AND '2024-12-31';

```

## Consultas usando funciones agregadas

Contar la cantidad de productos por categoría

```sql
SELECT COUNT(id_producto) AS productos_categoria
FROM productos 
GROUP BY id_categoria;

```
Calcular el precio total de ventas por cada cliente
```sql
SELECT SUM(cp.total) AS precio_total, c.id_cliente
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
GROUP BY c.id_cliente;
```
Calcular el precio promedio de los productos por categoría
```sql
SELECT AVG(precio_venta) AS productos_categoria
FROM productos 
GROUP BY id_categoria;
```
Encontrar la fecha de la primera y última compra registrada
```sql
SELECT MIN(fecha) AS primera_compra, MAX(fecha) AS ultima_compra 
FROM compras;

```
Calcular el total de ingresos por ventas
```sql
SELECT SUM(total) AS total
FROM compras_productos
GROUP BY id_compra;
```
Contar la cantidad de compras realizadas por cada medio de pago
```sql
SELECT COUNT(id_cliente) AS total, medio_pago
FROM compras
GROUP BY medio_pago;

```
Calcular el total de productos vendidos por cada producto
```sql
SELECT COUNT(total) AS total
FROM compras_productos
GROUP BY id_producto;

```
Obtener el promedio de cantidad de productos comprados por compra
```sql
SELECT AVG(cantidad) AS total
FROM compras_productos
GROUP BY id_compra;

```
Encontrar los productos con el stock más bajo
```sql

SELECT MIN(cantidad_stock) AS stockMin, nombre
FROM productos
GROUP BY nombre
ORDER BY stockMin ASC
LIMIT 2;
```
Calcular el total de productos comprados y el total gastado por cliente
```sql
SELECT SUM(cp.total) AS ingreso,SUM(cp.cantidad) AS total_productos, cl.id,cl.nombre
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.id, cl.nombre;

```


## Consultas usando join

### Consultar todos los productos con sus categorías 

```sql

SELECT p.nombre, c.descripcion AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria;

```


Consultar todas las compras y los clientes que las realizaron
```sql

SELECT cl.nombre, c.fecha,c.id_compra, c.medio_pago
FROM compras c
JOIN clientes cl ON cl.id = c.id_cliente;

```

Consultar los productos comprados en cada compra
```sql
SELECT p.nombre, cp.id_compra 
FROM compras_productos cp
JOIN productos p ON p.id_producto = cp.id_producto;  

```
Consultar las compras realizadas por un cliente específico
```sql

SELECT cl.nombre, c.fecha,c.id_compra, c.medio_pago
FROM compras c
JOIN clientes cl ON cl.id = c.id_cliente
WHERE c.id_cliente = '001';

```
Consultar el total gastado por cada cliente
```sql
SELECT SUM(cp.total) AS total_gastado, cl.nombre
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.id , cl.nombre;

```
Consultar el stock disponible de productos y su categoría
```sql
SELECT p.nombre, p.cantidad_stock, c.descripcion AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria;

```
Consultar los detalles de compras junto con la información del cliente y el producto
```sql

SELECT c.id_compra, cl.nombre,cl.apellidos,p.nombre, cp.cantidad, c.fecha 
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
JOIN productos p ON p.id_producto = cp.id_producto;


```
Consultar los productos que han sido comprados por más de una cantidad específica
```sql

SELECT p.nombre, cp.cantidad
FROM compras_productos cp
JOIN productos p ON p.id_producto = cp.id_producto
WHERE cantidad > 5;

```
### Consultar la cantidad total de productos vendidos por categoría
```sql

SELECT p.nombre, c.descripcion, SUM(cp.cantidad) AS totalproductosCategoria
FROM compras_productos cp
JOIN productos p ON p.id_producto = cp.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY p.id_producto, p.nombre, c.descripcion;

```
### Consultar los clientes que han realizado compras en un rango de fechas específico
```sql
SELECT c.id_cliente,c.fecha,c.medio_pago, cl.nombre, cl.apellidos, cl.celular
FROM compras c
JOIN clientes cl ON cl.id = c.id_cliente
WHERE c.fecha BETWEEN '2024-01-01' AND '2024-12-31';
```
Consultar el total gastado por cada cliente junto con la cantidad total de productos comprados

```sql

SELECT SUM(cp.total) AS total_gastado, cl.nombre, SUM(cp.cantidad) AS TotalPRODUCT
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.id , cl.nombre;

```
Consultar los productos que nunca han sido comprados
```sql

SELECT p.nombre
FROM compras_productos cp
RIGHT JOIN productos p ON p.id_producto = cp.id_producto
WHERE cp.total IS NULL;

```
Consultar los clientes que han realizado más de una compra y el total gastado por ellos
```sql
SELECT SUM(cp.total) AS total_gastado, cl.nombre,COUNT(c.fecha) AS compras_hechas
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY c.id_compra, cl.nombre
HAVING COUNT(c.fecha) > 1;

```
Consultar los productos más vendidos por categoría
```sql

SELECT p.nombre, c.descripcion, SUM(cp.cantidad) AS totalproductosCategoria
FROM compras_productos cp
JOIN productos p ON p.id_producto = cp.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.descripcion, p.nombre
ORDER BY totalproductosCategoria DESC
LIMIT 3;

```

## Subconsultas

### Consultar los productos que tienen un precio de venta superior al precio promedio de todos los productos

```sql
SELECT nombre
FROM productos
WHERE precio_venta > (
    SELECT AVG(precio_venta)
    FROM productos
);


```
Consultar los clientes que han gastado más del promedio general en sus compras

```sql
SELECT cl.nombre,  SUM(cp.total) AS totali
FROM compras_productos cp
JOIN compras c ON cp.id_compra = c.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.id
HAVING totali > (SELECT AVG(total)
FROM compras_productos cp);

```

Consultar las categorías que tienen más de 5 productos

```sql

SELECT descripcion
FROM categorias c
WHERE id_categoria = (
    SELECT id_categoria
    FROM productos
    GROUP BY id_categoria
    HAVING COUNT(id_producto) > 5
);

```


Consultar los productos más vendidos (top 5) por categoría

```sql
SELECT p.nombre
FROM productos p
JOIN (
    SELECT cp.id_producto
    FROM compras_productos cp
    GROUP BY cp.id_producto
    ORDER BY SUM(cp.total) DESC
    LIMIT 5
) cp ON p.id_producto = cp.id_producto;



```

Consultar los clientes que han realizado compras en los últimos 30 días
```sql

SELECT c.nombre
FROM clientes c
WHERE c.id IN (
    SELECT co.id_cliente 
    FROM compras co
    WHERE co.fecha BETWEEN DATE_SUB(NOW(), INTERVAL 30 DAY) AND NOW()
);

```