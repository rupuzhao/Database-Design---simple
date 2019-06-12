/*
	Task 4 of Final Project (30%)

	6 points each query
*/

use OurCompany;

/* Query 1
Display the total number of jobs by department name by job title.
*/

SELECT dept_name, job_title, Count(*) AS TotalJobs
  FROM Employees JOIN Departments ON
	Employees.dept_no = Departments.dept_no
	JOIN Jobs ON Employees.emp_no = Jobs.emp_no
  GROUP BY job_title, dept_name
  HAVING job_title <> 'N/A'
  ORDER BY TotalJobs DESC


result:
  dept_name	job_title	TotalJobs
----------  ----------  ---------
Accounting	Analyst		2
Accounting	Engineer	2
Accounting	Manager		1
Accounting	Programmer	1
Marketing	Analyst		1
Marketing	Engineer	1
Marketing	Manager		1
R&D			Driver		1
R&D			Engineer	1





/* Query 2
Which departments that have no employees? Display their dept_no. Solve 
this query three times: first use only a subquery, the second use only 
an outer join, and the third use only a set operator like UNION, EXCEPT, 
or INTERSECT.
*/

--1. subquery:
SELECT dept_no
FROM Departments
WHERE dept_no NOT IN (SELECT dept_no FROM Employees WHERE dept_no IS NOT NULL)


--2. outer join:
SELECT Departments.dept_no
FROM Departments LEFT JOIN Employees
	ON Employees.dept_no = Departments.dept_no
WHERE Employees.dept_no IS NULL



--3. set operator:
SELECT Departments.dept_no
FROM Departments
EXCEPT
SELECT Employees.dept_no
FROM Employees




/* Query 3
Display the total number of each job title assigned to a project 
in 2015 and the project has a budget. Do not include a null job 
title in the output.
*/

SELECT job_title, COUNT(*) AS TotalJobs
FROM Jobs JOIN Projects ON Jobs.proj_no = Projects.proj_no
WHERE YEAR(job_begin) = '2015' AND Projects.proj_budget IN 
	(SELECT proj_budget FROM Projects WHERE proj_no IS NOT NULL)
GROUP BY job_title
HAVING job_title IS NOT NULL;


result:
job_title	TotalJobs
---------	---------
Analyst		1
Driver		1
Engineer	2
Manager		1





/* Query 4
Update the budget of a project if it has three or more jobs. The budget
should be increased by $1.00 if its current value is above $250,000.00.
It should be increased by $2.00 if its current value is above $150,000.00
but not above $250,000.00. It should be increased by $3.00 if its current 
value is above $50,000.00 but not above $150,000.00. Projects of all
other budgets should be increased by $4.00.
*/

begin tran

UPDATE Projects
SET proj_budget = (CASE
	WHEN proj_budget BETWEEN 50000.00 AND 150000.00 THEN proj_budget + 3.00
	WHEN proj_budget BETWEEN 150000.00 AND 250000.00 THEN proj_budget + 2.00
	WHEN proj_budget > 250000.00 THEN proj_budget + 1.00
	ELSE proj_budget + 4.00
END)
OUTPUT deleted.proj_no, deleted.proj_budget AS budget_before_update, 
	inserted.proj_budget AS budget_after_update
WHERE proj_no IN (SELECT proj_no FROM Jobs GROUP BY proj_no HAVING COUNT(*) >= 3);



rollback



result:

proj_no	  budget_before_update	budget_after_update
-------	  --------------------	-------------------
p1 		  120000.00				120003.00
p2 		  95000.00				95003.00
p3 		  186500.00				186502.00




/* Query 5
There are departments that either have no employees (e.g., Shipping) or none
of their employees worked in a project (e.g., Sales).

Without considering the above two types of departments, which department(s) 
has the least number of employees who worked in projects? Display department
number, name, and the total employees worked in projects. 
*/

SELECT TOP 1 WITH TIES Departments.dept_no, dept_name, COUNT(*) AS TotalEmpWithProj
FROM Departments JOIN Employees ON Departments.dept_no = Employees.dept_no
	JOIN Jobs ON Employees.emp_no = Jobs.emp_no
	JOIN Projects ON Jobs.proj_no = Projects.proj_no
GROUP BY Departments.dept_no, dept_name
ORDER BY COUNT(*) ASC;




result:

dept_no	 dept_name	TotalEmpWithProj
-------  ---------  ----------------
d1 		 R&D		3
d3 		 Marketing	3
