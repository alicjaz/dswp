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