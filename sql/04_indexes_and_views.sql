-- ============================================================
-- 04_indexes_and_views.sql — Indexing + Views
-- ============================================================

USE smart_workforce;

-- ------------------------------------------------------------
-- INDEXES
-- ------------------------------------------------------------

-- Index employees by department
CREATE INDEX idx_employees_dept ON employees(dept_id);

-- Index salaries by emp_id + year + month
CREATE INDEX idx_salaries_emp ON salaries(emp_id, year, month);

-- Index attendance by emp_id + date
CREATE INDEX idx_attendance_emp ON attendance(emp_id, date);

-- Index project assignments
CREATE INDEX idx_emp_proj ON employee_projects(emp_id, project_id);

-- ------------------------------------------------------------
-- VIEWS (Reusable Analytics)
-- ------------------------------------------------------------

-- View: Department headcount
CREATE OR REPLACE VIEW v_dept_headcount AS
SELECT d.dept_name, COUNT(e.emp_id) AS headcount
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- View: Salary summary
CREATE OR REPLACE VIEW v_salary_summary AS
SELECT e.emp_name, s.year, s.month, s.salary_amount
FROM salaries s
JOIN employees e ON s.emp_id = e.emp_id;

-- View: Employee project involvement
CREATE OR REPLACE VIEW v_employee_projects AS
SELECT e.emp_name, p.project_name, ep.assigned_on
FROM employee_projects ep
JOIN employees e ON ep.emp_id = e.emp_id
JOIN projects p ON ep.project_id = p.project_id;

-- View: Performance summary
CREATE OR REPLACE VIEW v_performance_summary AS
SELECT e.emp_name,
       AVG(r.rating) AS avg_rating,
       COUNT(r.review_id) AS total_reviews
FROM performance_reviews r
JOIN employees e ON r.emp_id = e.emp_id
GROUP BY e.emp_name;
