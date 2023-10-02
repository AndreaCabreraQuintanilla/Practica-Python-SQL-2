/* 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers. */
WITH compañia_clientes AS (
SELECT company_name, customer_id
FROM customers)
SELECT * FROM compañia_clientes;


/* 2. Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar 
al anterior, pero solo queremos los que pertezcan a "Germany". */

WITH compañia_clientes AS (
SELECT company_name, customer_id
FROM customers
WHERE country = "Germany")
SELECT * FROM compañia_clientes;

/* 3. Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha y la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name). */
-- customer_id, company_name, order_id, order_date


SELECT customers.customer_id, customers.company_name, orders.order_id, orders.order_date
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
ORDER BY company_name;




/* 4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente. */

WITH facturas_cliente AS (SELECT customer_id, COUNT(order_id) AS "numero_factura"
							FROM orders
							GROUP BY customer_id
                            ORDER BY customer_id)
		SELECT	customer_id, company_name, numero_factura
        FROM facturas_cliente
        NATURAL JOIN customers
        GROUP BY customer_id, numero_factura;


/* 5. 
Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media. */


WITH suma_cantidad AS (SELECT product_id, AVG(quantity) "suma_pedidos"
						FROM order_details
                        GROUP BY product_id)
	SELECT product_name, suma_pedidos
    FROM suma_cantidad
    NATURAL JOIN products
    ORDER BY product_name;


WITH suma_cantidad AS (SELECT product_id, AVG(quantity) "suma_pedidos"
						FROM order_details
                        GROUP BY product_id)
	SELECT product_name, suma_pedidos
    FROM suma_cantidad
    NATURAL JOIN products
    ORDER BY product_name;

