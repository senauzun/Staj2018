--SENA UZUN
--08.07.2018
--This SQL statements catch exceptions  

-- 
DECLARE 

v_fname varchar2(100);

BEGIN
SELECT first_name INTO v_fname FROM employees WHERE employee_id=90;

 EXCEPTION

  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO DATA');
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Hata'|| '-' || sqlerrm || '-' || dbms_utility.format_error_backtrace);
    RAISE;

END;
/
DECLARE 

v_fname varchar2(100);

BEGIN
SELECT first_name INTO v_fname FROM employees WHERE employee_id=90;

 EXCEPTION

  WHEN zero_divide THEN
    DBMS_OUTPUT.PUT_LINE('NO DATA');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Hata'|| '-' || sqlerrm || '-' || dbms_utility.format_error_backtrace);
                RAISE;

END;
/
CREATE OR REPLACE PACKAGE pkg1 AS
 PROCEDURE print_employe_name(pin_EmployeeID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE );

END;
/
CREATE OR REPLACE function get_employe_name(pin_EmployeeID IN hr.EMPLOYEES.EMPLOYEE_ID%TYPE ) 
      RETURN HR.EMPLOYEES.FIRST_NAME%TYPE
    IS
     vs_EmployeeName  HR.EMPLOYEES.FIRST_NAME%TYPE;
    BEGIN
      SELECT first_name INTO vs_EmployeeName 
        FROM employees 
      WHERE employee_id = pin_EmployeeID;
      RETURN vs_EmployeeName;
      
    END get_employe_name;

/

CREATE OR REPLACE PACKAGE BODY pkg1 AS

procedure print_employe_name(pin_EmployeeID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE ) 
    IS
     vs_EmployeeName  HR.EMPLOYEES.FIRST_NAME%TYPE;
    BEGIN
      vs_EmployeeName := get_employe_name(pin_EmployeeID);
      dbms_output.put_line(vs_EmployeeName);      
 
      
    EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA');
            WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Hata'|| '-' || sqlerrm || '-' || dbms_utility.format_error_backtrace);
                RAISE;
      
     END print_employe_name;
     END pkg1;
/

BEGIN

pkg1.print_employe_name(1000);

END;
/
