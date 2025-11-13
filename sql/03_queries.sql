-- ============================================================
-- 03_queries.sql — HR Analytics & Reporting Queries
-- ============================================================

USE smart_workforce;

-- ------------------------------------------------------------
-- 1) Total Employees
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_employees
FROM employees;

-- ------------------------------------------------------------
-- 2) Employee Count by Department
-- ------------------------------------------------------------
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;

-- ------------------------------------------------------------
-- 3) Highest Salary per Department
-- ------------------------------------------------------------
SELECT d.dept_name, e.emp_name, s.salary_amount
FROM salaries s
JOIN employees e ON s.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE (d.dept_id, s.salary_amount) IN (
    SELECT e2.dept_id, MAX(s2.salary_amount)
    FROM salaries s2
    JOIN employees e2 ON s2.emp_id = e2.emp_id
    GROUP BY e2.dept_id
);

-- ------------------------------------------------------------
-- 4) Project Allocations (Employee–Project Mapping)
-- ------------------------------------------------------------
SELECT e.emp_name, p.project_name, ep.assigned_on
FROM employee_projects ep
JOIN employees e ON ep.emp_id = e.emp_id
JOIN projects p ON ep.project_id = p.project_id
ORDER BY assigned_on DESC;

-- ------------------------------------------------------------
-- 5) Attendance Summary (Present vs Absent)
-- ------------------------------------------------------------
SELECT e.emp_name,
       SUM(status = 'Present') AS days_present,
       SUM(status = 'Absent')  AS days_absent
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
GROUP BY e.emp_name
ORDER BY days_present DESC;

-- ------------------------------------------------------------
-- 6) Monthly Salary Report (Window Function)
-- ------------------------------------------------------------
SELECT 
    e.emp_name,
    s.year,
    s.month,
    s.salary_amount,
    SUM(s.salary_amount) OVER (PARTITION BY s.emp_id ORDER BY s.year, s.month) 
        AS cumulative_salary
FROM salaries s
JOIN employees e ON s.emp_id = e.emp_id
ORDER BY e.emp_name, s.year, s.month;

-- ------------------------------------------------------------
-- 7) Average Performance Rating per Employee
-- ------------------------------------------------------------
SELECT e.emp_name, 
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM performance_reviews r
JOIN employees e ON r.emp_id = e.emp_id
GROUP BY e.emp_name
ORDER BY avg_rating DESC;

-- ------------------------------------------------------------
-- 8) Department-wise Performance Score
-- ------------------------------------------------------------
SELECT d.dept_name,
       ROUND(AVG(r.rating), 2) AS dept_avg_rating
FROM performance_reviews r
JOIN employees e ON r.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY dept_avg_rating DESC;

-- ------------------------------------------------------------
-- 9) Employees Working on Most Projects (Ranked)
-- ------------------------------------------------------------
SELECT emp_name, total_projects
FROM (
    SELECT e.emp_name,
           COUNT(ep.project_id) AS total_projects,
           RANK() OVER (ORDER BY COUNT(ep.project_id) DESC) AS rank_pos
    FROM employees e
    LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
    GROUP BY e.emp_id
) ranked
ORDER BY rank_pos;
