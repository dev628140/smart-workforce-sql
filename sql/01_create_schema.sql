-- -----------------------------------------------------------
--  CLEAN SCHEMA FOR smart_workforce (MySQL 8/9 Compatible)
-- -----------------------------------------------------------

DROP DATABASE IF EXISTS smart_workforce;
CREATE DATABASE smart_workforce;
USE smart_workforce;

-- -----------------------------------------------------------
-- 1) Departments
-- -----------------------------------------------------------

CREATE TABLE departments (
  dept_id     INT AUTO_INCREMENT PRIMARY KEY,
  dept_name   VARCHAR(100) UNIQUE NOT NULL,
  location    VARCHAR(100) NOT NULL
);

-- -----------------------------------------------------------
-- 2) Employees
-- -----------------------------------------------------------

CREATE TABLE employees (
  emp_id     INT AUTO_INCREMENT PRIMARY KEY,
  emp_name   VARCHAR(100) NOT NULL,
  gender     ENUM('M','F') NOT NULL,
  dob        DATE NOT NULL,
  hire_date  DATE NOT NULL,
  dept_id    INT,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
    ON DELETE SET NULL
);

-- -----------------------------------------------------------
-- 3) Projects
-- -----------------------------------------------------------

CREATE TABLE projects (
  project_id    INT AUTO_INCREMENT PRIMARY KEY,
  project_name  VARCHAR(150) NOT NULL,
  client_name   VARCHAR(150) NOT NULL,
  start_date    DATE NOT NULL,
  budget        INT NOT NULL
);

-- -----------------------------------------------------------
-- 4) Employee–Project Assignments
-- -----------------------------------------------------------

CREATE TABLE employee_projects (
  emp_id       INT NOT NULL,
  project_id   INT NOT NULL,
  assigned_on  DATE NOT NULL,
  PRIMARY KEY (emp_id, project_id),
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
    ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
    ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- 5) Salaries
-- -----------------------------------------------------------

CREATE TABLE salaries (
  salary_id      INT AUTO_INCREMENT PRIMARY KEY,
  emp_id         INT NOT NULL,
  month          TINYINT NOT NULL,
  year           SMALLINT NOT NULL,
  salary_amount  INT NOT NULL,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
    ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- 6) Attendance
-- -----------------------------------------------------------

CREATE TABLE attendance (
  attendance_id  INT AUTO_INCREMENT PRIMARY KEY,
  emp_id         INT NOT NULL,
  date           DATE NOT NULL,
  status         ENUM('Present','Absent') NOT NULL,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
    ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- 7) Performance Reviews
-- -----------------------------------------------------------

CREATE TABLE performance_reviews (
  review_id    INT AUTO_INCREMENT PRIMARY KEY,
  emp_id       INT NOT NULL,
  review_date  DATE NOT NULL,
  rating       INT CHECK (rating BETWEEN 1 AND 5),
  comments     VARCHAR(255),
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
    ON DELETE CASCADE
);

