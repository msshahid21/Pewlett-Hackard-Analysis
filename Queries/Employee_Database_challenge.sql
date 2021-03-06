-- Deliverable 1
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- Number of Employees by most recent job title (about to retire)
SELECT title, COUNT(emp_no) as count
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC

-- Deliverable 2
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date, 
	de.from_date, 
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_employee as de
ON de.emp_no = e.emp_no
INNER JOIN titles as t
ON t.emp_no = e.emp_no
WHERE de.to_date = '9999-01-01'
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no ASC, to_date DESC

-- Additional Tables

-- Query for Mentorship Spread
SELECT title, COUNT(emp_no)
FROM mentorship_eligibilty
GROUP BY 1
ORDER BY 2 DESC;

-- Create Table for Departments of Retiring Employees
SELECT DISTINCT ON (de.emp_no) de.emp_no, e.birth_date, d.dept_name
INTO retirement_departments
FROM dept_employee AS de
INNER JOIN departments AS d
ON d.dept_no = de.dept_no
INNER JOIN employees as e
ON e.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01'
	AND e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY de.emp_no ASC;

-- Get Count of Retiring Employees by Department
SELECT dept_name, COUNT(emp_no)
FROM retirement_departments
GROUP BY 1
ORDER BY 2 DESC;
