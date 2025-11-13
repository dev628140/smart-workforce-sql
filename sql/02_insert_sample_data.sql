-- -----------------------------------------------------------
--  CLEAN + FIXED SAMPLE DATA + STORED PROCEDURES (MySQL 8/9)
-- -----------------------------------------------------------

USE smart_workforce;

-- -----------------------------------------------------------
-- 1) Insert Departments
-- -----------------------------------------------------------

INSERT INTO departments (dept_name, location)
VALUES 
  ('Engineering', 'Building A'),
  ('HR', 'Building B'),
  ('Finance', 'Building C'),
  ('Marketing', 'Building D'),
  ('Operations', 'Building E'),
  ('Data Science', 'Building F')
ON DUPLICATE KEY UPDATE location = VALUES(location);

-- -----------------------------------------------------------
-- 2) Insert Employees
-- -----------------------------------------------------------

INSERT INTO employees
(emp_name, gender, dob, hire_date, dept_id)
VALUES
  ('Amit Verma', 'M', '1990-02-14', '2022-01-10', 1),
  ('Sneha Sharma', 'F', '1994-05-21', '2023-04-12', 2),
  ('Rohan Das', 'M', '1992-11-10', '2021-08-03', 3),
  ('Priya Menon', 'F', '1996-07-09', '2020-09-17', 4),
  ('Vikram Sahu', 'M', '1991-03-12', '2023-10-01', 5),
  ('Neha Patnaik', 'F', '1993-12-03', '2022-05-24', 6)
ON DUPLICATE KEY UPDATE gender = VALUES(gender);

-- -----------------------------------------------------------
-- 3) Insert Projects
-- -----------------------------------------------------------

INSERT INTO projects (project_name, client_name, start_date, budget)
VALUES
  ('Project Phoenix', 'Cognizant Internal', '2024-03-01', 1500000),
  ('DeliveryPlus', 'Retail Client',       '2024-01-10', 1200000),
  ('AI Workforce Analytics', 'TechCorp',  '2024-05-05', 1800000)
ON DUPLICATE KEY UPDATE budget = VALUES(budget);

-- -----------------------------------------------------------
-- 4) Insert Employee–Project Assignments
-- -----------------------------------------------------------

INSERT INTO employee_projects (emp_id, project_id, assigned_on)
VALUES
  (1, 1, '2024-03-10'),
  (2, 2, '2024-04-01'),
  (3, 3, '2024-05-10'),
  (4, 1, '2024-06-01'),
  (5, 2, '2024-06-15'),
  (6, 3, '2024-07-01')
ON DUPLICATE KEY UPDATE assigned_on = VALUES(assigned_on);

-- -----------------------------------------------------------
-- 5) Insert Salaries
-- -----------------------------------------------------------

INSERT INTO salaries (emp_id, month, year, salary_amount)
VALUES
  (1, 1, 2025, 75000),
  (2, 1, 2025, 65000),
  (3, 1, 2025, 55000),
  (4, 1, 2025, 70000),
  (5, 1, 2025, 60000),
  (6, 1, 2025, 80000)
ON DUPLICATE KEY UPDATE salary_amount = VALUES(salary_amount);

-- -----------------------------------------------------------
-- 6) Insert Attendance
-- -----------------------------------------------------------

INSERT INTO attendance (emp_id, date, status)
VALUES
  (1, '2025-01-01', 'Present'),
  (2, '2025-01-01', 'Absent'),
  (3, '2025-01-01', 'Present'),
  (4, '2025-01-01', 'Present'),
  (5, '2025-01-01', 'Absent'),
  (6, '2025-01-01', 'Present')
ON DUPLICATE KEY UPDATE status = VALUES(status);

-- -----------------------------------------------------------
-- 7) Insert Performance Reviews
-- -----------------------------------------------------------

INSERT INTO performance_reviews
(emp_id, review_date, rating, comments)
VALUES
  (1, '2024-12-01', 4, 'Great technical contributions'),
  (2, '2024-12-01', 5, 'Excellent leadership'),
  (3, '2024-12-01', 3, 'Good but needs improvement'),
  (4, '2024-12-01', 4, 'Strong performer'),
  (5, '2024-12-01', 3, 'Average performance'),
  (6, '2024-12-01', 5, 'Outstanding AI expertise')
ON DUPLICATE KEY UPDATE rating = VALUES(rating);

-- -----------------------------------------------------------
--  STORED PROCEDURES (CLEANED + VALIDATED)
-- -----------------------------------------------------------

DELIMITER $$

-- Generate Random Employees
CREATE PROCEDURE gen_employees(IN how_many INT)
BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= how_many DO
    INSERT INTO employees(emp_name, gender, dob, hire_date, dept_id)
    VALUES (
      CONCAT('Employee_', i),
      IF(i % 2 = 0, 'M', 'F'),
      DATE_SUB(CURRENT_DATE, INTERVAL (7000 + i) DAY),
      DATE_SUB(CURRENT_DATE, INTERVAL (100 + i) DAY),
      FLOOR(1 + RAND() * 6)
    );
    SET i = i + 1;
  END WHILE;
END $$

-- Generate Employee Project Assignments
CREATE PROCEDURE gen_employee_projects()
BEGIN
  INSERT INTO employee_projects(emp_id, project_id, assigned_on)
  SELECT e.emp_id, p.project_id, CURRENT_DATE
  FROM employees e
  JOIN projects p
  WHERE e.emp_id NOT IN (SELECT emp_id FROM employee_projects);
END $$

-- Generate Salaries for a Date Range
CREATE PROCEDURE gen_salaries_range(IN yr SMALLINT, IN m1 TINYINT, IN m2 TINYINT)
BEGIN
  INSERT INTO salaries(emp_id, month, year, salary_amount)
  SELECT emp_id, m1, yr, 60000 + FLOOR(RAND() * 20000)
  FROM employees;
END $$

-- Generate Attendance for Jan 2025
CREATE PROCEDURE gen_attendance_jan2025()
BEGIN
  INSERT INTO attendance(emp_id, date, status)
  SELECT emp_id,
         DATE('2025-01-01'),
         IF(RAND() > 0.2, 'Present', 'Absent')
  FROM employees;
END $$

DELIMITER ;

-- -----------------------------------------------------------
-- END OF FILE
-- -----------------------------------------------------------
