CREATE DATABASE CompanyDB;
GO

USE CompanyDB;
GO

CREATE SCHEMA Sales;
GO

CREATE SEQUENCE Sales.employees_id_seq 
AS INT 
START WITH 1 
INCREMENT BY 1;
GO

CREATE TABLE Sales.employees (
    employee_id INT PRIMARY KEY DEFAULT (NEXT VALUE FOR Sales.employees_id_seq),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2)
);
GO

ALTER TABLE Sales.employees 
ADD hire_date DATE;
GO

CREATE TABLE Sales.departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id INT
);
GO

ALTER TABLE Sales.employees 
ADD department_id INT FOREIGN KEY REFERENCES Sales.departments(department_id);
GO



INSERT INTO Sales.departments (department_id, department_name, manager_id)
VALUES 
    (1, 'Sales', NULL),
    (2, 'IT', NULL),
    (3, 'HR', NULL);
GO




INSERT INTO Sales.employees (first_name, last_name, salary, hire_date, department_id)
VALUES 
    ('John', 'Smith', 52000.00, '2020-03-15', 1),
    ('Jane', 'Doe', 48000.00, '2020-06-10', 2),
    ('Ayman', 'Mansour', 55000.00, '2020-01-20', 1),
    ('Mark', 'Stark', 42000.00, '2021-05-12', 3),
    ('Alice', 'Johnson', 60000.00, '2022-04-18', 2),
    ('Bob', 'Anderson', 45000.00, NULL, NULL),
    ('Charlie', 'Chapman', 51000.00, '2023-01-10', 1),
    ('Diana', 'Prince', 75000.00, '2020-09-01', 3),
    ('Ethan', 'Hunt', 40000.00, '2019-11-05', 2),
    ('Fiona', 'Gallagher', 49000.00, '2020-11-20', 1),
    ('George', 'Clooney', 85000.00, '2021-07-22', 2),
    ('Hannah', 'Abbott', 38000.00, '2022-08-14', NULL);
GO




SELECT employee_id, first_name, last_name, salary, hire_date, department_id 
FROM Sales.employees;

SELECT first_name, last_name 
FROM Sales.employees;

SELECT first_name + ' ' + last_name AS full_name 
FROM Sales.employees;


SELECT AVG(salary) AS average_salary 
FROM Sales.employees;




SELECT * 
FROM Sales.employees 
WHERE salary > 50000;



SELECT * 
FROM Sales.employees 
WHERE YEAR(hire_date) = 2020;



SELECT * 
FROM Sales.employees 
WHERE last_name LIKE 'S%';




-- 8. Display the top 10 highest-paid employees
SELECT TOP 10 * 
FROM Sales.employees 
ORDER BY salary DESC;


SELECT * 
FROM Sales.employees 
WHERE salary BETWEEN 40000 AND 60000;

SELECT * 
FROM Sales.employees 
WHERE first_name LIKE '%man%' OR last_name LIKE '%man%';



SELECT * 
FROM Sales.employees 
WHERE hire_date IS NULL;



SELECT * 
FROM Sales.employees 
WHERE salary IN (40000, 45000, 50000);

SELECT * 
FROM Sales.employees 
WHERE hire_date BETWEEN '2020-01-01' AND '2021-01-01';



SELECT * 
FROM Sales.employees 
ORDER BY salary DESC;

SELECT TOP 5 * 
FROM Sales.employees 
ORDER BY last_name ASC;

SELECT * 
FROM Sales.employees 
WHERE salary > 55000 AND YEAR(hire_date) = 2020;

SELECT * 
FROM Sales.employees 
WHERE first_name IN ('John', 'Jane');

SELECT * 
FROM Sales.employees 
WHERE salary <= 55000 AND hire_date > '2022-01-01';

SELECT * 
FROM Sales.employees 
WHERE salary > (SELECT AVG(salary) FROM Sales.employees);

-- 20. Display the 3rd to 7th highest-paid employees (OFFSET and FETCH)
SELECT * 
FROM Sales.employees 
ORDER BY salary DESC 
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;


SELECT * 
FROM Sales.employees 
WHERE hire_date > '2021-01-01' 
ORDER BY first_name ASC, last_name ASC;


SELECT * 
FROM Sales.employees 
WHERE salary > 50000 AND last_name NOT LIKE 'A%';

SELECT * 
FROM Sales.employees 
WHERE salary IS NOT NULL;

SELECT * 
FROM Sales.employees 
WHERE (first_name LIKE '%e%' OR first_name LIKE '%i%' OR last_name LIKE '%e%' OR last_name LIKE '%i%') 
  AND salary > 45000;

-- 25. Retrieve all employees with their department names (INNER JOIN)
SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name 
FROM Sales.employees e
INNER JOIN Sales.departments d ON e.department_id = d.department_id;

-- 26. Retrieve employees who don’t belong to any department (LEFT JOIN and check for NULL)
SELECT e.employee_id, e.first_name, e.last_name 
FROM Sales.employees e
LEFT JOIN Sales.departments d ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

-- 27. Show all departments and their employee count (JOIN and GROUP BY)
SELECT d.department_name, COUNT(e.employee_id) AS employee_count 
FROM Sales.departments d
LEFT JOIN Sales.employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 28. Retrieve the highest-paid employee salary in each department (JOIN and MAX)
SELECT d.department_name, MAX(e.salary) AS max_salary
FROM Sales.departments d
INNER JOIN Sales.employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;