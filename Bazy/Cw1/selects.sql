--zadanie 1.
SELECT 
CONCAT(last_name, CONCAT(' ', salary)) AS wynagrodzenie
FROM employees
WHERE (department_id = '20' OR department_id  = '50') AND salary BETWEEN 2000 AND 7000
ORDER BY last_name ASC;
--zadanie 2.
SELECT hire_date, last_name, &colmn AS user_column
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = 2005
ORDER BY user_column ASC;
--zadanie 3.
SELECT
    employees.first_name || ' ' || employees.last_name AS razem, employees.phone_number
FROM
    employees
WHERE
    employees.last_name LIKE '__e%'
    AND employees.first_name LIKE '%&user_input%'
ORDER BY
    1 DESC,
    2;
--zadanie 4.
SELECT
  DISTINCT first_name, last_name, ROUND(MONTHS_BETWEEN(TO_DATE('27-Oct-2021',  '%dd-%Mm-%Yyyy'),TO_DATE(hire_date, '%dd-%Mm-%yy')),-1) AS working_months, salary,
  CASE 
    WHEN ROUND(MONTHS_BETWEEN(TO_DATE('27-Oct-2021',  '%dd-%Mm-%Yyyy'),TO_DATE(hire_date, '%dd-%Mm-%yy')),-1) <= 150
    THEN ROUND(salary * 0.1,2) 
    WHEN ROUND(MONTHS_BETWEEN(TO_DATE('27-Oct-2021',  '%dd-%Mm-%Yyyy'),TO_DATE(hire_date, '%dd-%Mm-%yy')),-1) > 150 AND ROUND(MONTHS_BETWEEN(TO_DATE('17-Oct-2021',  '%dd-%Mm-%Yyyy'),TO_DATE(hire_date, '%dd-%Mm-%yy')),-1) < 200
    THEN ROUND(salary * 0.2,2)  
    ELSE ROUND(salary * 0.3,2)  
  END bonus 
FROM
  EMPLOYEES

ORDER BY
3;
--zadanie 5.
SELECT ROUND(SUM(employees.salary),0) as suma,  ROUND(AVG(employees.salary),0) as srednia
FROM employees 
JOIN departments on employees.department_id = departments.department_id
GROUP BY departments.department_name
HAVING min(salary)>5000
--zadanie 6.
SELECT e.last_name, e.job_id,d.department_id,d.department_name,l.city
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id
WHERE CITY = 'Toronto';
--zadanie 7.
SELECT first_name, last_name 
FROM employees  
WHERE department_id IN  
( SELECT department_id  
FROM employees  
WHERE first_name = 'Jennifer')  
OR first_name =  'Jennifer';
--zadanie 8.
SELECT departments.department_name
FROM departments 
WHERE
 NOT EXISTS (SELECT * FROM employees WHERE departments.department_id = employees.department_id)
--zadanie 11.
SELECT employee_id, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY SALARY DESC;
--zadanie 12.
SELECT employee_id, last_name
FROM employees
WHERE department_id IN 
	(SELECT department_id FROM employees WHERE last_name like '%u%');