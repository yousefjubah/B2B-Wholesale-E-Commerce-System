
 CREATE DATABASE company;
 USE company;
CREATE TABLE DEPARTMENT (

 Dname VARCHAR(15) NOT NULL,
 Dnumber INT NOT NULL,
 Mgr_ssn CHAR(9),
 Mgr_start_date DATE,
 PRIMARY KEY (Dnumber),
 UNIQUE (Dname)
);
CREATE TABLE EMPLOYEE (

 Fname VARCHAR(15) NOT NULL,
 Minit CHAR(1),
 Lname VARCHAR(15) NOT NULL,
 Ssn CHAR(9) NOT NULL,
 Bdate DATE,
 Address VARCHAR(50),
 Sex CHAR(1),
 Salary DECIMAL(10,2) DEFAULT 30000.00,
 Super_ssn CHAR(9),
 Dno INT NOT NULL DEFAULT 1,
 PRIMARY KEY (Ssn)
);
--
CREATE TABLE DEPT_LOCATIONS (

 Dnumber INT NOT NULL,
 Dlocation VARCHAR(15) NOT NULL,
 PRIMARY KEY (Dnumber, Dlocation)
);
--
CREATE TABLE PROJECT (

 Pname VARCHAR(15) NOT NULL,
 Pnumber INT NOT NULL,
 Plocation VARCHAR(15),
 Dnum INT NOT NULL,
 PRIMARY KEY (Pnumber),
 UNIQUE (Pname)
);
--
CREATE TABLE WORKS_ON (

 Essn CHAR(9) NOT NULL,
 Pno INT NOT NULL,
 Hours DECIMAL(3,1) DEFAULT 0.0,
 PRIMARY KEY (Essn, Pno)
);
--
CREATE TABLE DEPENDENT (

 Essn CHAR(9) NOT NULL,
 Dependent_name VARCHAR(15) NOT NULL,
 Sex CHAR(1),
 Bdate DATE,
 Relationship VARCHAR(8),
 PRIMARY KEY (Essn, Dependent_name)
);


ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_emp_super
FOREIGN KEY (Super_ssn)
REFERENCES EMPLOYEE(Ssn)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_emp_dept
FOREIGN KEY (Dno)
REFERENCES DEPARTMENT(Dnumber)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE DEPARTMENT
ADD CONSTRAINT fk_dept_mgr
FOREIGN KEY (Mgr_ssn)
REFERENCES EMPLOYEE(Ssn)
ON DELETE SET NULL
ON UPDATE CASCADE;
--
ALTER TABLE DEPT_LOCATIONS
ADD CONSTRAINT fk_dept_locations
FOREIGN KEY (Dnumber)
REFERENCES DEPARTMENT(Dnumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE PROJECT
ADD CONSTRAINT fk_project_dept
FOREIGN KEY (Dnum)
REFERENCES DEPARTMENT(Dnumber)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE WORKS_ON
ADD CONSTRAINT fk_works_emp
FOREIGN KEY (Essn)
REFERENCES EMPLOYEE(Ssn)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE WORKS_ON
ADD CONSTRAINT fk_works_project
FOREIGN KEY (Pno)
REFERENCES PROJECT(Pnumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE DEPENDENT
ADD CONSTRAINT fk_dependent_emp
FOREIGN KEY (Essn)
REFERENCES EMPLOYEE(Ssn)
ON DELETE CASCADE
ON UPDATE CASCADE;

----------------------------------------------------------------------------------------------

INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES ('Headquarters', 1, NULL, '1981-06-19');
INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES ('Administration', 4, NULL, '1995-01-01');
INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES ('Research', 5, NULL, '1988-05-22');


-- Insert EMPLOYEE
-- Step 1 — Insert the top manager first (no supervisor)
INSERT INTO EMPLOYEE
VALUES ('James', 'E', 'Borg', '888665555',
'1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);
-- Step 2 — Insert employees whose supervisor is James
INSERT INTO EMPLOYEE VALUES
('Franklin', 'T', 'Wong', '333445555', '1955-12-08',
'638 Voss, Houston, TX', 'M', 40000, '888665555', 5),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20',
'291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4);
-- Step 3 — Insert remaining employees
INSERT INTO EMPLOYEE VALUES
('John', 'B', 'Smith', '123456789', '1965-01-09',
'731 Fondren, Houston, TX', 'M', 30000, '333445555', 5),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15',
'975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31',
'5631 Rice, Houston, TX', 'F', 25000, '333445555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19',
'3321 Castle, Spring, TX', 'F', 25000, '987654321', 4),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29',
'980 Dallas, Houston, TX', 'M', 25000, '987654321', 4);
-- 3) Update department managers after employees exist
UPDATE DEPARTMENT
SET Mgr_ssn = '888665555'
WHERE Dnumber = 1;
--
UPDATE DEPARTMENT
SET Mgr_ssn = '987654321'
WHERE Dnumber = 4;
--
UPDATE DEPARTMENT
SET Mgr_ssn = '333445555'
WHERE Dnumber = 5;
--
-- -----------------------------------------
-- 4) Insert DEPT_LOCATIONS
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (1, 'Houston');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (4, 'Stafford');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (5, 'Bellaire');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (5, 'Sugarland');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (5, 'Houston');
-- ----------------------------------------------------
-- 5) Insert PROJECT
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum)
VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum)
VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum)
VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum)
VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum)
VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum)
VALUES ('Newbenefits', 30, 'Stafford', 4);
-- -----------------------------------------------
-- 6) Insert WORKS_ON
INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.5);
INSERT INTO WORKS_ON VALUES ('123456789', 2, 7.5);
INSERT INTO WORKS_ON VALUES ('666884444', 3, 40.0);
INSERT INTO WORKS_ON VALUES ('453453453', 1, 20.0);
INSERT INTO WORKS_ON VALUES ('453453453', 2, 20.0);
INSERT INTO WORKS_ON VALUES ('333445555', 2, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 3, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 20, 10.0);
INSERT INTO WORKS_ON VALUES ('999887777', 30, 30.0);
INSERT INTO WORKS_ON VALUES ('999887777', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('987987987', 10, 35.0);
INSERT INTO WORKS_ON VALUES ('987987987', 30, 5.0);
INSERT INTO WORKS_ON VALUES ('987654321', 30, 20.0);
INSERT INTO WORKS_ON VALUES ('987654321', 20, 15.0);
INSERT INTO WORKS_ON VALUES ('888665555', 20, NULL);
-- ---------------------------------------------
-- 7) Insert DEPENDENT
INSERT INTO DEPENDENT VALUES ('333445555', 'Alice', 'F', '1986-04-05', 'Daughter');
INSERT INTO DEPENDENT VALUES ('333445555', 'Theodore', 'M', '1983-10-25', 'Son');
INSERT INTO DEPENDENT VALUES ('333445555', 'Joy', 'F', '1958-05-03', 'Spouse');
INSERT INTO DEPENDENT VALUES ('987654321', 'Abner', 'M', '1942-02-28', 'Spouse');
INSERT INTO DEPENDENT VALUES ('123456789', 'Michael', 'M', '1988-01-04', 'Son');
INSERT INTO DEPENDENT VALUES ('123456789', 'Alice', 'F', '1988-12-30', 'Daughter');
INSERT INTO DEPENDENT VALUES ('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

------------------------------------------------------------------------------------------------

SELECT *
FROM employee;

SELECT Fname , Lname , Salary
FROM employee;

SELECT *
FROM department;

SELECT *
FROM DEPT_LOCATIONS;

SELECT Salary
FROM employee
WHERE Salary>30000;

SELECT *
FROM employee
WHERE Dno=5 ;

SELECT *
FROM employee
JOIN works_on ON ssn =essn
JOIN project ON pno =pnumber
WHERE pname='ProductX';

-- 13 
SELECT e.Fname, e.Lname ,s.ssn , s.Fname , s.Lname 
FROM employee AS e ,employee AS s 
WHERE s.ssn=e.super_ssn;

-- 14 
SELECT *
FROM employee  
WHERE bdate > '1964-12-31';

-- 16
SELECT *
FROM employee  
ORDER BY salary DESC;

-- 17
SELECT *
FROM employee , department  
WHERE employee.dno= department.Dnumber
ORDER BY Dno;

-- 18
SELECT distinct Dno
FROM employee;

-- 19
SELECT *
FROM employee  
WHERE address like '%Houston%';

-- 20
SELECT Fname ,Lname ,Sex , Ssn ,Bdate , Salary
FROM employee  
WHERE salary BETWEEN 25000 and 40000 ;



SELECT Fname ,Lname ,Sex , Ssn ,Bdate , Salary , pname
FROM employee 
JOIN works_on ON essn = ssn
JOIN project ON pnumber= pno
where pname='ProductX';

SELECT *
FROM employee
JOIN works_on ON ssn =essn
JOIN project ON pno =pnumber
WHERE pname='ProductX';

SELECT e.Fname ,e.Lname ,s.Fname ,s.Lname
FROM employee as e ,  employee as s
WHERE e.super_ssn = s.ssn ;



SELECT Fname ,Lname 
FROM employee 
WHERE super_ssn is null;

SELECT e.Fname ,e.Lname , s.fname ,s.Lname , s.ssn
FROM employee as e , employee as s
WHERE e.super_ssn=s.ssn and e.super_ssn is null ;






-- Fname ,Minit ,Lname ,Ssn ,Bdate ,Address ,Sex ,Salary ,Super_ssn ,Dno 

