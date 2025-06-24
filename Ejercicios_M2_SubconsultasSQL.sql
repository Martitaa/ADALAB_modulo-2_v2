-- 1. Calcula el número de clientes por cada ciudad

SELECT city, COUNT(*) AS total_clientes
FROM customers 
GROUP BY city;

-- 2. Selecciona la ciudad con el mayor número de clientes (usando la consulta anterior como subconsulta)

SELECT city, total_clientes
FROM (
	SELECT city, COUNT(*) AS total_clientes
	FROM customers 
	GROUP BY city) AS clientes_por_ciudad
ORDER BY total_clientes DESC
LIMIT 1;

-- 3.  usa todas las consultas anteriores para seleccionar el customerNumber, nombre y apellido de las clientas asignadas a la ciudad con mayor numero de clientas.

SELECT customer_number, contact_first_name, contact_last_name
FROM customers
WHERE city = (
  SELECT city
  FROM (
    SELECT city, COUNT(*) AS total_clientes
    FROM customers
    GROUP BY city
  ) AS clientes_por_ciudad
  ORDER BY total_clientes DESC
  LIMIT 1
);

-- 4. Ver qué empleados tienen asignado algún cliente

SELECT employee_number AS 'Número empleado',
	first_name AS 'Nombre Empleado',
    last_name AS 'Apellido Empleado'
FROM employees
WHERE employee_number IN (
	SELECT sales_rep_employee_number
    FROM customers
);

-- 5. cuantas ciudades en las cuales tenemos clientes, no tienen una oficina 

SELECT DISTINCT city AS 'ciuedad',
	customer_name AS 'nombre de la empresa'
FROM customers
WHERE city NOT IN (
	SELECT city FROM offices
);

