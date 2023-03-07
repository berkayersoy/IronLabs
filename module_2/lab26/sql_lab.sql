USE employees_mod;

# QUESTION 2 Create a procedure that will provide the average salary of all employees.

DROP PROCEDURE IF EXISTS avg_salary;
DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
	SELECT AVG(salary)
	FROM t_salaries;
END $$
DELIMITER ;

SELECT * FROM t_employees;

# QUESTION 3 Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.

DROP PROCEDURE IF EXISTS emp_info;
DELIMITER $$
CREATE PROCEDURE emp_info(first_name VARCHAR(50), last_name VARCHAR(50))
BEGIN
	SELECT te.emp_no FROM t_employees te
    WHERE te.first_name = first_name AND te.last_name = last_name;
END $$
DELIMITER ;

# QUESTION 4
CALL avg_salary();
CALL emp_info("Patricio", "Bridgland");

# QUESTION 5 Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee. Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.
DROP FUNCTION IF EXISTS emp_info2;
SET GLOBAL log_bin_trust_function_creators=1;
## FUNCTIONS
DELIMITER $$
CREATE FUNCTION emp_info2(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE salary111 DECIMAL(10,2);
    DECLARE max_date DATE;
    
    SELECT MAX(from_date) INTO max_date
    FROM t_salaries ts
    INNER JOIN t_employees te ON te.emp_no = ts.emp_no
    WHERE te.first_name = first_name AND te.last_name = last_name;
    
	SELECT salary INTO salary111
	FROM t_salaries ts
    INNER JOIN t_employees te
    ON te.emp_no=ts.emp_no
	WHERE te.first_name=first_name AND te.last_name=last_name AND ts.from_date = max_date;
    
	RETURN salary111;
END $$ 
DELIMITER ;
#
SET GLOBAL log_bin_trust_function_creators=0;
SELECT emp_info2("Patricio", "Bridgland");

# QUESTION 6 Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)
USE employees_mod;
	DELIMITER $$
CREATE TRIGGER hiring_date_fix
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > CURDATE() THEN SET NEW.hire_date = CURDATE();
	END IF;
END $$ DELIMITER ;

INSERT
	t_employees
VALUES
	('999999', '1998-10-10', 'Jonathon', 'Clegglife', 'M', '2025-01-01');
    
SELECT first_name, hire_date FROM t_employees
WHERE first_name="Jonathon";

# QUESTION 7 Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.
CREATE INDEX i_hire_date ON t_employees (hire_date);

DROP INDEX i_hire_date ON t_employees;

# QUESTION 8 Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum. Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
CREATE INDEX i_salary ON t_salaries(salary);
SELECT emp_no, salary FROM t_salaries
WHERE salary>89000;

# QUESTION 9 Use Case statement and obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee.
SELECT e.emp_no, e.first_name, e.last_name, 
    CASE WHEN dm.emp_no IS NULL THEN 'Regular Employee' ELSE 'Manager' END AS employee_type
FROM t_employees e
LEFT JOIN t_dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990;

# QUESTION 10 Extract a dataset containing the following information about the managers: employee number, first name, and last name. Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, and another one saying whether this salary raise was higher than $30,000 or NOT.
SELECT emp_no, (MAX(salary)-MIN(salary)) AS max_min_salary_difference,
	CASE WHEN ((MAX(salary)-MIN(salary))>30000) THEN 'salary raise higher than 30000' ELSE 'peasant' END AS salary_raise
FROM t_salaries
GROUP BY emp_no;

# QUESTION 11 Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t. Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.
SELECT e.emp_no, e.first_name, e.last_name,
    CASE WHEN de.to_date >= CURDATE() THEN 'Is still employed' ELSE 'Not an employee anymore' END AS current_employee
FROM t_employees e
LEFT JOIN t_dept_emp de ON e.emp_no = de.emp_no
ORDER BY e.emp_no
LIMIT 100;

SELECT * FROM t_employees;-



	