CREATE TABLE "titles" (
	"title_id" varchar(250) NOT NULL,
	"title" varchar(250) NOT NULL,
	CONSTRAINT "pk_titles" PRIMARY KEY ("title_id")
);

CREATE TABLE "employees" (
	"emp_no" int NOT NULL,
	"emp_title_id" varchar(250) NOT NULL,
	"birth_date" date NOT NULL,
	"first_name" varchar(250) NOT NULL,
	"last_name" varchar(250) NOT NULL,
	"sex" varchar(250) NOT NULL,
	"hire_date" date NOT NULL,
	CONSTRAINT "pk_employees" PRIMARY KEY("emp_no"),
	CONSTRAINT "fk_emp_title" FOREIGN KEY ("emp_title_id") REFERENCES "titles"("title_id")
);

CREATE TABLE "salaries" (
	"emp_no" int NOT NULL,
	"salary" int NOT NULL,
	CONSTRAINT "pk_salaries" PRIMARY KEY ("emp_no"),
	CONSTRAINT "fk_salaries_emp" FOREIGN KEY ("emp_no") REFERENCES "employees"("emp_no")
);

CREATE TABLE "departments" (
	"dept_no" varchar(250) NOT NULL,
	"dept_name" varchar(250) NOT NULL,
	CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
);

CREATE TABLE "dept_emp" (
	"emp_no" int NOT NULL,
	"dept_no" varchar(250) NOT NULL,
	CONSTRAINT "pk_dept_emp" PRIMARY KEY ("emp_no","dept_no"),
	CONSTRAINT "fk_dept_emp_emp" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no"),
	CONSTRAINT "fk_dept_emp_dept" FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no")
);

CREATE TABLE "dept_manager" (
	"dept_no" varchar(250) NOT NULL,
	"emp_no" int NOT NULL,
	CONSTRAINT "pk_dept_manager" PRIMARY KEY ("dept_no", "emp_no"),
	CONSTRAINT "fk_dept_manager_emp" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no"),
	CONSTRAINT "fk_dept_manager_dept" FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no")
);

SELECT * FROM "titles"
SELECT * FROM "employees"
SELECT * FROM "salaries"
SELECT * FROM "departments"
SELECT * FROM "dept_emp"
SELECT * FROM "dept_manager"

--DATA ANALYSIS

--1.List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp, e.last_name, e.first_name, e.sex, e.salary
FROM employees e
JOIN salaries s  ON e.emp_no = s.emp_no;

--2.List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.emp_no, e.last_name, e.first_name, dm.dept_no, d.dept_name
FROM dept_namanger dm
JOIN employees e ON dm.emp_no = e.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, e.emp_no, e.last_name, e.first-name, d.dept_name
FROM dept_emp de
JOIN emplyees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no;

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM dept emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = dept_no
WHERE d.dept_name = 'Sales';

--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;