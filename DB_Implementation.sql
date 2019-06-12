CREATE DATABASE OurCompany;
GO

USE OurCompany;
CREATE TABLE Departments
(dept_no		VARCHAR(10) NOT NULL PRIMARY KEY,
dept_name		VARCHAR(50)	NOT NULL,
dept_location	VARCHAR(50)	NOT NULL);

CREATE TABLE Employees
(emp_no			INT			NOT NULL PRIMARY KEY,
emp_fname		VARCHAR(50)	NOT NULL,
emp_lname		VARCHAR(50)	NOT NULL,
dept_no			VARCHAR(10) NULL);

CREATE TABLE Projects
(proj_no		VARCHAR(10)	NOT NULL PRIMARY KEY,
proj_name		VARCHAR(50)	NOT NULL,
proj_budget		MONEY		NULL);

CREATE TABLE Jobs
(emp_no			INT			NOT NULL REFERENCES Employees(emp_no),
proj_no			VARCHAR(10)	NOT NULL REFERENCES Projects(proj_no),
job_title		VARCHAR(50)	NULL,
job_begin		DATE NULL,
PRIMARY KEY (emp_no, proj_no));

INSERT INTO Employees
VALUES (18316, 'John', 'Barrimore', 'd1'),
	   (28559, 'Sybill', 'Moser', 'd1'),
	   (33355, 'Peter', 'Fisher', 'd1'),
	   (2581, 'Elke', 'Hansel', 'd2'),
	   (9031, 'Elsa', 'Bertoni', 'd2'),
	   (29346, 'James', 'James', 'd2'),
	   (30606, 'Kathie', 'Wilson', 'd2'),
	   (10102, 'Ann', 'Jones', 'd3'),
	   (25348, 'Matthew', 'Smith', 'd3'),
	   (31189, 'Julia', 'White', 'd5'),
	   (5500, 'Paul', 'Fisher', NULL),
	   (34427, 'Matthew', 'Arrow', NULL)

INSERT INTO Departments
VALUES ('d1', 'R&D', 'Dallas,TX'),
	   ('d2', 'Accounting', 'Tampa,FL'),
	   ('d3', 'Marketing', 'Miami,FL'),
	   ('d4', 'Shipping', 'Atlanta,GA'),
	   ('d5', 'Sales', 'Tampa,FL'),
	   ('d6', 'Customer Services', 'St.Louis,MO')

INSERT INTO Projects
VALUES ('p1', 'Anchor', 120000),
	   ('p2', 'Gemini', 95000),
	   ('p3', 'Jet', 186500),
	   ('p11', 'Sea Star', NULL),
	   ('p14', 'Blue Sky', 300000),
	   ('p15', 'Winner', 300000),
	   ('p20', 'Hunter-II', NULL)

INSERT INTO Jobs
VALUES (18316, 'p2', 'Driver', '2015-06-01'),
       (28559, 'p1', NULL, '2015-08-01'),
	   (28559, 'p2', 'Engineer', '2016-02-01'),
	   (2581, 'p3', 'Analyst', '2015-10-15'),
	   (9031, 'p1', 'Manager', '2015-04-15'),
	   (9031, 'p3', 'Engineer', '2014-11-15'),
	   (29346, 'p1', 'Engineer', '2015-01-04'),
	   (29346, 'p2', NULL, '2014-12-15'),
	   (30606, 'p11', 'Analyst', '2015-09-25'),
	   (30606, 'p20', 'Programmer', NULL),
	   (10102, 'p1', 'Analyst', '2014-10-01'),
	   (10102, 'p3', 'Manager', '2012-01-01'),
	   (25348, 'p2', 'Engineer', '2015-02-15'),
	   (5500, 'p11', 'QA', NULL),
	   (5500, 'p14', 'Programmer', '2016-11-09'),
	   (5500, 'p2', 'QA', '2016-03-22'),
	   (5500, 'p20', 'Manager', '2013-01-18')
	 
