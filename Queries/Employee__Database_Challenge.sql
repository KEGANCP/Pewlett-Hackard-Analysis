--CHALLENGE
-- Generate table showing employees DOB between 1952 & 1955
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no
;
select * from retirement_titles

-- Use Distinct wiht Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO clean_retirement_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM clean_retirement_titles

-- Count of retirees by title
SELECT COUNT(emp_no), title
INTO retirees_by_titles
FROM clean_retirement_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retirees_by_titles

-- Active employees DOB in 1965
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC
;

SELECT * FROM mentorship_eligibility