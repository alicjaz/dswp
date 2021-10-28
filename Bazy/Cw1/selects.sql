--zadanie 1.
SELECT 
last_name || ' ' || salary AS wynagrodzenie
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
SELECT
    e.first_name
    || ' '
    || e.last_name worker,
    coworkers
FROM
         (
        SELECT
            e.employee_id,
            LISTAGG(coworkers.first_name
                    || ' '
                    || coworkers.last_name, '; ') WITHIN GROUP(
            ORDER BY
                coworkers.last_name
            ) coworkers
        FROM
                 employees e
            JOIN employees manager ON manager.employee_id = e.manager_id
            JOIN employees coworkers ON coworkers.manager_id = manager.employee_id
        WHERE
                e.first_name = 'Jennifer'
            AND coworkers.employee_id NOT IN e.employee_id
        GROUP BY
            e.employee_id
    ) q
    JOIN employees e ON e.employee_id = q.employee_id
--zadanie 8.
SELECT departments.department_name
FROM departments 
WHERE
 NOT EXISTS (SELECT * FROM employees WHERE departments.department_id = employees.department_id)
--zadanie 9.
create table job_grades as select * from hr.job_grades
--zadanie 10.
SELECT e.first_name || ' '  || e.last_name AS name, e.job_id, d.department_name,
    e.salary, jg.grade
FROM employees e
JOIN departments d ON d.department_id = e.department_id
LEFT JOIN job_grades  jg ON e.salary
BETWEEN jg.min_salary AND jg.max_salary WHERE GRADE IS NOT NULL
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