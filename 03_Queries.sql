-- ============================================================
-- CMPE343 - Airport Management Information System
-- 15 Statistical / Management Queries
-- ============================================================

USE airport_management;

-- ============================================================
-- Query 1: List all airplanes with their model details and
--           current status
-- ============================================================
SELECT
    a.plane_no,
    a.registration_code,
    pm.manufacturer,
    pm.model_no,
    pm.aircraft_type,
    a.capacity,
    a.year_manufactured,
    a.status,
    a.last_service_date
FROM airplane a
JOIN plane_model pm ON a.model_no = pm.model_no
ORDER BY pm.manufacturer, a.plane_no;

-- ============================================================
-- Query 2: List all technicians along with the plane models
--           they are certified to service
-- ============================================================
SELECT
    e.ssn,
    CONCAT(e.first_name, ' ', e.last_name) AS technician_name,
    t.certification_level,
    pm.model_no,
    pm.manufacturer,
    te_exp.expertise_level,
    te_exp.certified_date
FROM technician t
JOIN employee e        ON t.ssn = e.ssn
JOIN technician_expertise te_exp ON t.ssn = te_exp.ssn
JOIN plane_model pm    ON te_exp.model_no = pm.model_no
ORDER BY technician_name, pm.model_no;

-- ============================================================
-- Query 3: Show which airplanes are CURRENTLY in a hangar
--           (out_datetime IS NULL)
-- ============================================================
SELECT
    a.plane_no,
    a.registration_code,
    pm.model_no,
    h.hangar_no,
    h.location,
    h.hangar_type,
    ah.in_datetime,
    TIMESTAMPDIFF(HOUR, ah.in_datetime, NOW()) AS hours_in_hangar,
    ah.notes
FROM airplane_hangar ah
JOIN airplane a    ON ah.plane_no  = a.plane_no
JOIN plane_model pm ON a.model_no  = pm.model_no
JOIN hangar h      ON ah.hangar_no = h.hangar_no
WHERE ah.out_datetime IS NULL
ORDER BY ah.in_datetime;

-- ============================================================
-- Query 4: Average test score per airplane
--           (best to worst performers)
-- ============================================================
SELECT
    a.plane_no,
    a.registration_code,
    pm.model_no,
    COUNT(te.event_id)                  AS total_tests,
    ROUND(AVG(te.score), 2)             AS avg_score,
    MIN(te.score)                       AS min_score,
    MAX(te.score)                       AS max_score,
    SUM(CASE WHEN te.pass_fail = 'fail' THEN 1 ELSE 0 END) AS failed_tests
FROM airplane a
JOIN plane_model pm ON a.model_no = pm.model_no
LEFT JOIN test_event te ON a.plane_no = te.plane_no
GROUP BY a.plane_no, a.registration_code, pm.model_no
ORDER BY avg_score DESC;

-- ============================================================
-- Query 5: Technician workload report:
--           total hours spent and number of tests performed
-- ============================================================
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS technician_name,
    t.certification_level,
    COUNT(te.event_id)          AS tests_performed,
    ROUND(SUM(te.hours_spent), 1) AS total_hours_spent,
    ROUND(AVG(te.hours_spent), 2) AS avg_hours_per_test,
    ROUND(AVG(te.score), 2)     AS avg_score_given
FROM technician t
JOIN employee e ON t.ssn = e.ssn
LEFT JOIN test_event te ON t.ssn = te.technician_ssn
GROUP BY t.ssn, technician_name, t.certification_level
ORDER BY total_hours_spent DESC;

-- ============================================================
-- Query 6: Traffic controllers whose annual medical exam
--           is overdue (more than 365 days ago)
-- ============================================================
SELECT
    CONCAT(e.first_name, ' ', e.last_name)         AS controller_name,
    tc.controller_license_no,
    tc.tower_assignment,
    tc.last_medical_exam_date,
    DATEDIFF(CURDATE(), tc.last_medical_exam_date)  AS days_since_exam,
    CASE
        WHEN DATEDIFF(CURDATE(), tc.last_medical_exam_date) > 365
            THEN 'OVERDUE - Must not work'
        WHEN DATEDIFF(CURDATE(), tc.last_medical_exam_date) > 300
            THEN 'WARNING - Schedule exam soon'
        ELSE 'OK'
    END AS exam_status
FROM traffic_controller tc
JOIN employee e ON tc.ssn = e.ssn
ORDER BY days_since_exam DESC;

-- ============================================================
-- Query 7: Most frequently used tests across the airport
-- ============================================================
SELECT
    t.test_id,
    t.test_name,
    t.test_category,
    t.frequency_days,
    COUNT(te.event_id)              AS times_performed,
    ROUND(AVG(te.score), 2)         AS avg_score,
    ROUND(AVG(te.hours_spent), 2)   AS avg_hours,
    SUM(CASE WHEN te.pass_fail = 'fail' THEN 1 ELSE 0 END) AS total_failures
FROM test t
LEFT JOIN test_event te ON t.test_id = te.test_id
GROUP BY t.test_id, t.test_name, t.test_category, t.frequency_days
ORDER BY times_performed DESC;

-- ============================================================
-- Query 8: Airplanes that have NEVER been tested
-- ============================================================
SELECT
    a.plane_no,
    a.registration_code,
    pm.manufacturer,
    pm.model_no,
    a.status,
    a.last_service_date
FROM airplane a
JOIN plane_model pm ON a.model_no = pm.model_no
WHERE a.plane_no NOT IN (
    SELECT DISTINCT plane_no FROM test_event
)
ORDER BY a.plane_no;

-- ============================================================
-- Query 9: Number of technicians certified per plane model,
--           grouped by expertise level
-- ============================================================
SELECT
    pm.model_no,
    pm.manufacturer,
    pm.aircraft_type,
    SUM(CASE WHEN te.expertise_level = 'advanced'     THEN 1 ELSE 0 END) AS advanced_count,
    SUM(CASE WHEN te.expertise_level = 'intermediate' THEN 1 ELSE 0 END) AS intermediate_count,
    SUM(CASE WHEN te.expertise_level = 'basic'        THEN 1 ELSE 0 END) AS basic_count,
    COUNT(te.ssn) AS total_certified_technicians
FROM plane_model pm
LEFT JOIN technician_expertise te ON pm.model_no = te.model_no
GROUP BY pm.model_no, pm.manufacturer, pm.aircraft_type
ORDER BY total_certified_technicians DESC;

-- ============================================================
-- Query 10: Monthly test activity summary for the current year
-- ============================================================
SELECT
    DATE_FORMAT(te.test_date, '%Y-%m')  AS year_month,
    COUNT(te.event_id)                  AS tests_conducted,
    COUNT(DISTINCT te.plane_no)         AS distinct_planes_tested,
    COUNT(DISTINCT te.technician_ssn)   AS distinct_technicians,
    ROUND(AVG(te.score), 2)             AS avg_score,
    SUM(te.hours_spent)                 AS total_hours,
    SUM(CASE WHEN te.pass_fail = 'fail' THEN 1 ELSE 0 END) AS failures
FROM test_event te
WHERE YEAR(te.test_date) = YEAR(CURDATE())
GROUP BY DATE_FORMAT(te.test_date, '%Y-%m')
ORDER BY year_month;

-- ============================================================
-- Query 11: All employees with their union membership details,
--           ordered by department type and salary
-- ============================================================
SELECT
    e.ssn,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.employee_type,
    e.hire_date,
    DATEDIFF(CURDATE(), e.hire_date) / 365 AS years_of_service,
    FORMAT(e.salary, 2)                    AS salary,
    u.union_name,
    e.union_membership_no
FROM employee e
JOIN union_tbl u ON e.union_id = u.union_id
ORDER BY e.employee_type, e.salary DESC;

-- ============================================================
-- Query 12: Hangar utilisation report – how many planes are
--           currently in each hangar vs its capacity
-- ============================================================
SELECT
    h.hangar_no,
    h.location,
    h.hangar_type,
    h.status,
    h.capacity,
    COUNT(ah.record_id)                             AS planes_currently_stored,
    h.capacity - COUNT(ah.record_id)                AS available_slots,
    ROUND(COUNT(ah.record_id) / h.capacity * 100, 1) AS utilisation_pct
FROM hangar h
LEFT JOIN airplane_hangar ah
       ON h.hangar_no = ah.hangar_no
      AND ah.out_datetime IS NULL
GROUP BY h.hangar_no, h.location, h.hangar_type, h.status, h.capacity
ORDER BY utilisation_pct DESC;

-- ============================================================
-- Query 13: Top-performing airplane per test category
--           (highest average score in each category)
-- ============================================================
SELECT
    t.test_category,
    a.plane_no,
    a.registration_code,
    pm.model_no,
    ROUND(AVG(te.score), 2) AS avg_score
FROM test_event te
JOIN test t        ON te.test_id  = t.test_id
JOIN airplane a    ON te.plane_no = a.plane_no
JOIN plane_model pm ON a.model_no = pm.model_no
GROUP BY t.test_category, a.plane_no, a.registration_code, pm.model_no
HAVING AVG(te.score) = (
    SELECT MAX(inner_avg)
    FROM (
        SELECT AVG(te2.score) AS inner_avg
        FROM test_event te2
        JOIN test t2 ON te2.test_id = t2.test_id
        WHERE t2.test_category = t.test_category
        GROUP BY te2.plane_no
    ) sub
)
ORDER BY t.test_category;

-- ============================================================
-- Query 14: Total repair cost and hours spent per airplane,
--           ranked by total repair cost
-- ============================================================
SELECT
    a.plane_no,
    a.registration_code,
    pm.manufacturer,
    pm.model_no,
    a.status,
    COUNT(rr.repair_id)             AS number_of_repairs,
    ROUND(SUM(rr.cost), 2)          AS total_repair_cost,
    ROUND(SUM(rr.hours_spent), 1)   AS total_repair_hours,
    ROUND(AVG(rr.cost), 2)          AS avg_cost_per_repair
FROM airplane a
JOIN plane_model pm ON a.model_no = pm.model_no
LEFT JOIN repair_record rr ON a.plane_no = rr.plane_no
GROUP BY a.plane_no, a.registration_code, pm.manufacturer, pm.model_no, a.status
ORDER BY total_repair_cost DESC;

-- ============================================================
-- Query 15: Flight operations summary – controller workload,
--           on-time performance and passenger statistics
-- ============================================================
SELECT
    CONCAT(e.first_name, ' ', e.last_name)     AS controller_name,
    tc.tower_assignment,
    COUNT(f.flight_id)                         AS flights_managed,
    SUM(CASE WHEN f.status = 'arrived'   THEN 1 ELSE 0 END) AS completed_flights,
    SUM(CASE WHEN f.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_flights,
    SUM(CASE WHEN f.status = 'delayed'   THEN 1 ELSE 0 END) AS delayed_flights,
    IFNULL(SUM(f.passenger_count), 0)          AS total_passengers,
    ROUND(
        SUM(CASE WHEN f.status = 'arrived' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(f.flight_id), 0) * 100
    , 1)                                       AS completion_rate_pct
FROM traffic_controller tc
JOIN employee e ON tc.ssn = e.ssn
LEFT JOIN flight f ON tc.ssn = f.controller_ssn
GROUP BY tc.ssn, controller_name, tc.tower_assignment
ORDER BY flights_managed DESC;
