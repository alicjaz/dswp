-- task #1
DECLARE
        number_max  departments.department_id%TYPE;
BEGIN
        SELECT MAX (department_id) + 10 INTO number_max FROM departments;
        INSERT INTO departments (department_id, department_name)
        VALUES (number_max, 'EDUCATION');
END;
/

select * from departments;

-- task #2
BEGIN
    UPDATE departments
    SET location_id=3000 WHERE
    department_id=280;
END;
/

-- task #3
BEGIN
FOR i in 1..10 LOOP
    IF i = 4 or i = 6 THEN
        null;
    ELSE
        INSERT INTO numbers(numbers)
        VALUES (i);
    END IF;
END LOOP;
COMMIT;
END;
/

select * from numbers;

-- task #4
DECLARE
  l_country_record   countries%ROWTYPE;
  l_country_id    VARCHAR2(20)        := 'CA';
BEGIN
  SELECT *
  INTO l_country_record
  FROM countries
  WHERE country_id = UPPER(l_country_id);

  DBMS_OUTPUT.PUT_LINE(
    ' Country Name: ' || l_country_record.country_name ||
    ' Region: ' || l_country_record.region_id
  );
END;
/

-- task #5
DECLARE
    TYPE dept_table_type
      IS TABLE OF departments.department_name%TYPE
        INDEX BY PLS_INTEGER;
    my_dept_table  dept_table_type;
    loop_count     NUMBER(2) := 10;
    deptno         NUMBER(4) := 0;
BEGIN
    FOR i IN 1..loop_count
    LOOP
        deptno := 10 + deptno;
        SELECT department_name
        INTO my_dept_table(i)
        FROM departments
        WHERE department_id = deptno;
    END LOOP;

    FOR j IN 1..loop_count
    LOOP
        DBMS_OUTPUT.PUT_LINE(my_dept_table(j));
    END LOOP;
END;

-- task #6
DECLARE
    TYPE dept_table_type
      IS TABLE OF departments%ROWTYPE
        INDEX BY PLS_INTEGER;
    my_dept_table  dept_table_type;
    loop_count     NUMBER(2) := 10;
    deptno         NUMBER(4) := 0;
BEGIN
    FOR i IN 1..loop_count
    LOOP
        deptno := 10 + deptno;
        SELECT * INTO my_dept_table(i)
        FROM departments
        WHERE department_id = deptno;
    END LOOP;

    FOR j IN 1..loop_count
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        'Department ID: ' || my_dept_table(j).department_id || ';' ||
        ' Department Name: ' || my_dept_table(j).department_name || ';' ||
        ' Manager Id: ' || my_dept_table(j).manager_id || ';' ||
        ' Location Id: ' || my_dept_table(j).location_id
      );
    END LOOP;
END;

-- task #7
DECLARE
  CURSOR c_emp_cursor
  IS
    SELECT salary, last_name
    FROM employees
    WHERE department_id = 50;

BEGIN
    FOR emp_record IN c_emp_cursor

    LOOP
        IF (emp_record.salary>3100) THEN
            DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ' ' || 'nie dawac podwyzki');
        ELSE
            DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ' ' || 'dac podwyzke');
        END IF;
    END LOOP;
END;

-- task #8 a/b
--a
declare
    cursor emp_cursor(dolny int, gorny int, czesc varchar) is
    select salary,first_name, last_name
    from employees
    where lower(first_name) like (lower(czesc)) and salary between dolny and gorny;

begin
    for n in emp_cursor(1000,5000,'%a%')  --dla b wystarczy podstawić inne wartości (5000,20000,'%u%')
    LOOP
        dbms_output.put_line(n.salary ||' '|| n.first_name ||' '|| n.last_name);
    end loop;
end;

--b
declare
    cursor emp_cursor(dolny int, gorny int, czesc varchar) is
    select salary,first_name, last_name
    from employees
    where lower(first_name) like (lower(czesc)) and salary between dolny and gorny;

begin
    for n in emp_cursor(5000,20000,'%u%')
    LOOP
        dbms_output.put_line(n.salary ||' '|| n.first_name ||' '|| n.last_name);
    end loop;
end;

--task #9
--a
create or replace procedure add_jobs(jobid in varchar2,jobname in varchar2) is
begin
    insert into jobs(job_id, job_title) values(jobid,jobname);
exception
    when others then
    dbms_output.put_line('Wyjatek jezeli cos nie dziala');
end;
--b
create or replace PROCEDURE change_jobs (
    jobid   STRING,
    jobtitle STRING
) AS
    not_updated EXCEPTION;
BEGIN
    UPDATE jobs
    SET
        job_title = jobtitle
    WHERE
        job_id = jobid;
    IF( SQL%rowcount = 0 ) THEN
        RAISE not_updated;
    END IF;
EXCEPTION
    WHEN not_updated THEN
        dbms_output.put_line('Nie ma update, error');
    WHEN OTHERS THEN
        dbms_output.put_line('Wyjatek jezeli cos nie dziala');
--c
create or replace PROCEDURE remove_jobs (
    jobid STRING
) AS
    not_deleted EXCEPTION;
BEGIN
    DELETE FROM jobs
    WHERE
        job_id = jobid;

    IF ( SQL%rowcount = 0 ) THEN
        RAISE not_deleted;
    END IF;
EXCEPTION
    WHEN not_deleted THEN
        dbms_output.put_line('nic nie skasowano error');
    WHEN OTHERS THEN
        dbms_output.put_line('nie wiem co ale cos nie dziala');
END;
--d
create or replace PROCEDURE earnings_info (
    employeeid VARCHAR2
) IS
    nazwisko employees.last_name%TYPE;
    zarobki employees.salary%TYPE;
BEGIN
    select employees.last_name, employees.salary into nazwisko, zarobki from employees where(employees.employee_id = employeeid);
    dbms_output.put_line(nazwisko || ' ' || zarobki);
END;
--e
create or replace procedure insert_earnings(
zarobki IN number,
imie IN varchar2 default NULL,
nazwisko IN varchar2 default 'Kowalski',
emaj in varchar2 default 'email@email.nl',
telefon in varchar2 default NULL,
prowizja in number default NULL,
managerID number default NULL,
zatrudnion date default CURRENT_DATE,
jobid varchar2 default 'HR_REP',
depart number default 40)
is
too_much EXCEPTION;
idemp employees.employee_id%type;
BEGIN
IF (zarobki > 20000) then
    raise too_much;
END IF;
select max(employees.employee_id) into idemp from employees;
idemp:=idemp+1;
insert into employees(employee_id,salary, first_name, last_name, email, phone_number,commission_pct,manager_id,hire_date,job_id,department_id) values(idemp,
zarobki,imie,nazwisko,emaj,telefon,prowizja,
managerID,zatrudnion,jobid,depart);
EXCEPTION
    WHEN too_much THEN
        dbms_output.put_line('zarobki ponad 20 tysiecy error');
    WHEN OTHERS THEN
        dbms_output.put_line('nie wiem co ale cos nie dziala');
END;
