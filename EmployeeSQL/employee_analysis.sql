-- List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no,
       e.last_name,
	   e.hire_date,
	   s.salary
from employees e
join salaries s on e.emp_no = s.emp_no
limit 100;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select e.first_name,
       e.last_name,
	   e.hire_date
from employees e
where hire_date between '01-01-1986' and '12-31-1986';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
select e.first_name || ' ' || e.last_name as manager,
       d.dept_no,
       d.dept_name,
	   e.emp_no,
	   e.last_name,
	   e.first_name
from departments d
join dept_managers dm on dm.dept_no = d.dept_no
join employees e on e.emp_no = dm.emp_no
order by d.dept_name, e.last_name;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select d.dept_no,
	   e.emp_no,
	   e.last_name,
	   e.first_name,
	   d.dept_name
from departments d
join dept_emp de on de.dept_no = d.dept_no
join employees e on e.emp_no = de.emp_no
order by d.dept_name, e.last_name;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select e.first_name,
       e.last_name,
	   e.sex
from employees e
where e.first_name = 'Hercules'
  and substring(e.last_name,1,1) = 'B';

-- List each employee in the Sales department, including their employee number, last name, and first name.
select e.emp_no,
	   e.last_name,
	   e.first_name
from departments d
join dept_emp de on de.dept_no = d.dept_no
join employees e on e.emp_no = de.emp_no
where d.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no,
	   e.last_name,
	   e.first_name,
	   d.dept_name
from departments d
join dept_emp de on de.dept_no = d.dept_no
join employees e on e.emp_no = de.emp_no
where d.dept_name in ('Sales', 'Development');

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select e.last_name,
	   count(*)
from employees e
group by e.last_name
order by e.last_name desc;