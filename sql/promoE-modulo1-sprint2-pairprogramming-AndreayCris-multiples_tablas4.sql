/* 1. Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un
 tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages". 
 Devuelve el ID del producto, el nombre del producto y su ID de categoría. */

	SELECT *
		FROM products
		WHERE category_id IN (SELECT category_id
		FROM categories
		WHERE category_name ="Beverages");

/* 2. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse 
a estos países para buscar proveedores adicionales.*/

SELECT DISTINCT (country)
FROM customers
		WHERE country NOT IN (
        SELECT country
		FROM suppliers
        );

/* 3. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto 
"Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.*/

SELECT order_id, customer_id
FROM orders
	WHERE order_id IN (
    SELECT order_id
    FROM order_details
    WHERE product_id = 6 AND quantity > 20)
ORDER BY customer_id;

/* 4. Extraed los 10 productos más caros
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son 
los 10 productos más caros. */ 

SELECT product_name AS "ProductosMásCaros", unit_price AS "Precio"
FROM products
ORDER BY unit_price DESC
LIMIT 10;

/* Qué producto es más popular
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró. */

SELECT products.product_name, SUM(order_details.quantity)
FROM products
INNER JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY product_name
ORDER BY SUM(order_details.quantity) DESC
LIMIT 1;


