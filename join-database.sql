-- Database of the JOIN demonstration https://en.wikipedia.org/wiki/Join_(SQL)

-- create database 'JOIN_DB', if not exists
CREATE DATABASE IF NOT EXISTS JOIN_DB;
USE JOIN_DB;


-- 'JOIN_DB' schema

CREATE TABLE department(
    DepartmentID INT PRIMARY KEY NOT NULL,
    DepartmentName VARCHAR(20)
);

CREATE TABLE employee (
    LastName VARCHAR(20),
    DepartmentID INT REFERENCES department(DepartmentID)
);


-- 'JOIN_DB' data

INSERT INTO department
VALUES (31, 'Sales'),
       (33, 'Engineering'),
       (34, 'Clerical'),
       (35, 'Marketing');

INSERT INTO employee
VALUES ('Rafferty', 31),
       ('Jones', 33),
       ('Heisenberg', 33),
       ('Robinson', 34),
       ('Smith', 34),
       ('Williams', NULL);


-- 'JOIN_DB' queries

-- -- CROSS JOIN creates full cross product (carthesian product) of the two tables
-- SELECT * FROM employee CROSS JOIN department;
-- SELECT * FROM employee, department;

-- -- INNER JOIN selects rows of matching linkage attributes from both tables omitting other rows
-- SELECT * FROM employee INNER JOIN department ON employee.DepartmentID = department.DepartmentID;
-- SELECT * FROM employee JOIN department ON employee.DepartmentID = department.DepartmentID;
-- SELECT * FROM employee, department WHERE employee.DepartmentID = department.DepartmentID;
-- SELECT * FROM employee JOIN department USING (DepartmentID);
-- SELECT * FROM employee NATURAL JOIN department;

-- -- OUTER JOIN LEFT/RIGHT includes none-matching rows of the LEFT or RIGHT table
-- SELECT * FROM employee LEFT OUTER JOIN department ON employee.DepartmentID = department.DepartmentID;
-- SELECT * FROM employee RIGHT OUTER JOIN department ON employee.DepartmentID = department.DepartmentID;

-- -- FULL OUTER JOIN includes none-matching rows of both tables (not supported by MySQL)
-- SELECT * FROM employee FULL OUTER JOIN department ON employee.DepartmentID = department.DepartmentID;

-- -- FULL OUTER JOIN emulation as UNION of LEFT and RIGHT OUTER joins
-- SELECT * FROM employee
--   LEFT JOIN department ON employee.DepartmentID = department.DepartmentID
--   UNION
--   SELECT * FROM employee
--   RIGHT JOIN department ON employee.DepartmentID = department.DepartmentID;
