DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Dept_emp;
DROP TABLE IF EXISTS Dept_manager;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS titles;

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE Departments (
    "dept_no" VARCHAR  NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE Dept_emp (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE Dept_manager (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE Employees (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE Salaries (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE titles (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");


	
SELECT*
FROM Departments;

SELECT*
FROM Dept_emp

SELECT*
FROM Dept_manager

SELECT*
FROM Employees

SELECT*
FROM Salaries

SELECT*
FROM titles

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no AS "employee number",e.last_name AS "last name",e.first_name AS "first name",e.gender,s.salary
FROM Employees AS e
JOIN Salaries AS s ON
e.emp_no=s.emp_no
ORDER BY "employee number";

--2. List employees who were hired in 1986.

SELECT*
FROM Employees
WHERE hire_date >= '1986-01-01'
	AND hire_date <= '1986-12-31'
ORDER BY hire_date; 



--3 List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT Departments.dept_no AS "department number",Departments.dept_name AS "department name",Employees.emp_no AS "the managers employee number",Employees.last_name AS "last name",Employees.first_name AS "first name",Dept_manager.from_date AS "start employment date",Dept_manager.to_date AS "end employment date"
FROM Departments
JOIN Dept_manager ON
Departments.dept_no=Dept_manager.dept_no
JOIN Employees ON
Dept_manager.emp_no=Employees.emp_no;


--4. List the department of each employee with the following information: employee number, last name, first name, and department name.


SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", Employees.first_name AS "first name",Departments.dept_name AS "department name"
FROM Employees
JOIN Dept_emp ON
Employees.emp_no=Dept_emp.emp_no
JOIN Departments ON
Dept_emp.dept_no=Departments.dept_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT *
FROM Employees
WHERE first_name like 'Hercules'
AND last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.


SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", Employees.first_name AS "first name", Departments.dept_name AS "department name"
FROM Employees
INNER JOIN Dept_emp on 
Employees.emp_no = Dept_emp.emp_no
INNER JOIN Departments on
Dept_emp.dept_no=Departments.dept_no
WHERE Departments.dept_name = 'Sales'
ORDER BY "employee number";


--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.



SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", Employees.first_name AS "first name", Departments.dept_name AS "department name"
FROM Employees
INNER JOIN Dept_emp on 
Employees.emp_no = Dept_emp.emp_no
INNER JOIN Departments on
Dept_emp.dept_no=Departments.dept_no
WHERE Departments.dept_name = 'Sales' or Departments.dept_name = 'Development'
ORDER BY "employee number";

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name,COUNT(last_name) AS "Frequency"
from Employees
GROUP BY last_name
ORDER BY "Frequency" DESC;

