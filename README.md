# Airport Management Information System
**CMPE343 – Database Management Systems and Programming I**
**Due Date:** 24 May 2026

---

## Project Overview

A fully normalised relational database (MySQL 8.0) for **Ercan Airport Management**.
The system stores and retrieves information about aircraft, hangars, employees, airworthiness tests, repairs, and flight operations.

---

## Database Schema (13 Tables)

| Table | Description |
|---|---|
| `union_tbl` | Airport worker unions |
| `employee` | All staff (SSN-identified, union member) |
| `technician` | Technician sub-type – certification level |
| `traffic_controller` | Controller sub-type – annual medical exam date |
| `plane_model` | Aircraft model catalogue |
| `technician_expertise` | Many-to-many: technicians ↔ plane models |
| `airplane` | Individual aircraft records |
| `hangar` | Hangar locations and capacity |
| `airplane_hangar` | IN/OUT datetime history per plane per hangar |
| `test` | Airworthiness test catalogue |
| `test_event` | Each testing instance (plane × technician × test) |
| `repair_record` | Maintenance and repair history |
| `flight` | Flight schedule and operations |

---

## Files

| File | Description |
|---|---|
| `01_DDL.sql` | Database and table creation (with all constraints) |
| `02_DML.sql` | Sample data insertion |
| `03_Queries.sql` | 15 statistical management queries |
| `Airport_Management_Report.docx` | Full project report (Introduction, ER Diagram, Relational Model, DDL, DML, Queries) |
| `README.md` | This file |

---

## How to Run

1. Make sure **MySQL 8.0+** is installed and running.
2. Open a terminal and connect to MySQL:
   ```bash
   mysql -u root -p
   ```
3. Run the DDL to create the database and tables:
   ```sql
   source /path/to/01_DDL.sql
   ```
4. Insert the sample data:
   ```sql
   source /path/to/02_DML.sql
   ```
5. Run the queries:
   ```sql
   USE airport_management;
   source /path/to/03_Queries.sql
   ```

---

## ER Diagram

*(Add your ER Diagram image here as `ER_Diagram.png` and update this section)*

---

## Team Members

| Name | Student ID | Role |
|---|---|---|
| *(Add name)* | *(Add ID)* | *(Add role)* |
| *(Add name)* | *(Add ID)* | *(Add role)* |

---

## Notes

- The `pass_fail` column in `test_event` is auto-computed: score ≥ 60 → **pass**, below 60 → **fail**
- A `NULL` value in `airplane_hangar.out_datetime` means the aircraft is **currently inside** that hangar
- Traffic controllers with `last_medical_exam_date` older than 365 days are flagged as **OVERDUE** in Query 6
