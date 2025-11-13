📘 Smart Workforce – Complete SQL Project

A fully-designed enterprise-grade Workforce Management Database System featuring schema design, sample data generation, advanced SQL queries, views, indexes, triggers, and analytics.

This project simulates how real HR, Payroll, Project Management, and Attendance systems operate inside a company.
Use it for placements, resume, GitHub portfolio, SQL mastery, and interviews.

🌟 Project Highlights

Normalized 3NF schema with strong referential integrity

Departments → Employees → Projects → Salaries → Attendance → Performance

40+ realistic sample dataset entries

25+ analytics & reporting queries

Indexes & Views for optimization

Stored Procedures for auto-data generation

Clean ER diagram included

Works with MySQL 8+

📁 Folder Structure
smart-workforce-sql/
│
├── sql/
│   ├── 01_create_schema.sql
│   ├── 02_insert_sample_data.sql
│   ├── 03_queries.sql
│   ├── 04_indexes_and_views.sql
│
├── docs/
│   ├── README.md  ← (this file)
│   ├── er_diagram.png
│   └── presentation_script.md
│
└── scripts/
    └── (optional helper scripts)

🧩 Database Schema Overview

    Main Entities
    | Table                   | Description                     |
    | ----------------------- | ------------------------------- |
    | **departments**         | List of company departments     |
    | **employees**           | Employee master records         |
    | **projects**            | Major client/internal projects  |
    | **employee_projects**   | Mapping of employees → projects |
    | **salaries**            | Monthly salary records          |
    | **attendance**          | Day-wise presence logs          |
    | **performance_reviews** | Annual performance evaluation   |

## 📊 ER Diagram

![ER Diagram](./docs/smart_workforce_ERD.png)

🚀 How to Run the Project
✔ Step 1 — Open MySQL terminal
mysql -u root -p

✔ Step 2 — Run Schema
source ./sql/01_create_schema.sql;

✔ Step 3 — Insert Data
source ./sql/02_insert_sample_data.sql;

✔ Step 4 — Run all Queries
source ./sql/03_queries.sql;

✔ Step 5 — Add Indexes + Views
source ./sql/04_indexes_and_views.sql;

📊 Sample Analytics Included
🔹 Employee Analytics

Employees per department

Average salary per department

Top 3 highest-paid employees

🔹 Project Analytics

Project workload per employee

Total active projects

Department-wise project distributions

🔹 Attendance Analytics

Monthly attendance percentage

Identify low attendance employees

🔹 Performance Analytics

Top/Bottom performers

Grade distribution reports

🧠 Technologies Used

MySQL 8+

SQL Views

SQL Indexing

Stored Procedures

Foreign Keys

ER Modeling (Graphviz)

🎯 Purpose of Project

This SQL project is designed for:

✔ Interviews
✔ Resume Portfolio
✔ Internship/Placement Tests
✔ SQL Learning
✔ Real-world case study experience

It demonstrates solid command over database design, data normalization, constraints, and advanced SQL.

❤️ Contribute / Extend

You may enhance this project by adding:

Triggers (auto-updating modified_at)

Login & Accounts table

KPI dashboards

Payroll automation