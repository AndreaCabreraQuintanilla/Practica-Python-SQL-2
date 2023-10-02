/*1.Relación entre número de pedidos y máxima carga:
Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) 
que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso).*/

USE northwind;

SELECT order_id, MAX(freight), employee_id
FROM orders
GROUP BY order_id;

/*2. Descartar pedidos sin fecha y ordénalos:
Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo".
En el resultado anterior se han incluido muchos pedidos cuya fecha de envío estaba vacía, por lo que tenemos que mejorar la consulta en este aspecto. 
También nos piden que ordenemos los resultados según el ID de empleado para que la visualización sea más sencilla.*/

SELECT employee_id, MAX(freight), shipped_date, order_id
FROM orders
WHERE shipped_date != 0000-00-00 
GROUP BY order_id
ORDER BY employee_id DESC;

/*3. Números de pedidos por día:
El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. 
Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, 
mostrando de manera separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).*/

SELECT  shipped_date, order_id, DAY(shipped_date), MONTH(shipped_date), YEAR(shipped_date)
FROM orders
WHERE shipped_date != 0000-00-00 
GROUP BY order_id;

/*4.Número de pedidos por mes y año:
La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. 
Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.*/

SELECT  shipped_date, order_id, DAY(shipped_date), MONTH(shipped_date), YEAR(shipped_date)
FROM orders
WHERE shipped_date != 0000-00-00 
GROUP BY order_id
ORDER BY YEAR(shipped_date), MONTH(shipped_date);

/*5.Seleccionad las ciudades con 4 o más empleadas:
Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas 
de cara a estudiar la apertura de nuevas oficinas.*/

SELECT  COUNT(employee_id), city
FROM employees
GROUP BY city
HAVING COUNT(employee_id) >= 4
;

/*6.Cread una nueva columna basándonos en la cantidad monetaria:
Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la cantidad monetaria total que 
han supuesto:
por encima o por debajo de 2000 euros.*/

SELECT order_id,
CASE
	WHEN SUM(unit_price * quantity)  > 2000 THEN "Alto"
    ELSE "Bajo"
    END AS "categoria"
    FROM order_details
GROUP BY order_id;







