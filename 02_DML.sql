-- ============================================================
-- CMPE343 - Airport Management Information System
-- DML: Data Manipulation Language  (Sample Data)
-- ============================================================

USE airport_management;

-- -------------------------------------------------------
-- 1. Unions
-- -------------------------------------------------------
INSERT INTO union_tbl (union_name, contact_phone, contact_email, established_date) VALUES
('Aviation Workers Union',           '+90-392-111-0001', 'awu@ercanairport.com',   '1985-03-15'),
('Air Traffic Controllers Union',    '+90-392-111-0002', 'atcu@ercanairport.com',  '1990-07-20'),
('Airport General Employees Union',  '+90-392-111-0003', 'ageu@ercanairport.com',  '1995-01-10');

-- -------------------------------------------------------
-- 2. Employees  (SSN format: XXX-XX-XXXX)
-- -------------------------------------------------------
INSERT INTO employee (ssn, first_name, last_name, birth_date, hire_date, salary, phone, email, employee_type, union_id, union_membership_no) VALUES
-- Technicians
('100-01-0001', 'Ali',     'Yilmaz',   '1980-04-10', '2010-06-01', 55000.00, '+90-533-100-0001', 'ali.yilmaz@ercan.com',    'technician',         1, 'AWU-10001'),
('100-01-0002', 'Mehmet',  'Kaya',     '1982-08-22', '2012-03-15', 52000.00, '+90-533-100-0002', 'mehmet.kaya@ercan.com',   'technician',         1, 'AWU-10002'),
('100-01-0003', 'Fatma',   'Demir',    '1990-11-05', '2015-09-01', 48000.00, '+90-533-100-0003', 'fatma.demir@ercan.com',   'technician',         1, 'AWU-10003'),
('100-01-0004', 'Hasan',   'Celik',    '1978-01-30', '2008-01-20', 60000.00, '+90-533-100-0004', 'hasan.celik@ercan.com',   'technician',         1, 'AWU-10004'),
('100-01-0005', 'Zeynep',  'Arslan',   '1985-06-17', '2011-05-10', 53000.00, '+90-533-100-0005', 'zeynep.arslan@ercan.com', 'technician',         1, 'AWU-10005'),
('100-01-0006', 'Emre',    'Ozturk',   '1992-03-28', '2018-07-01', 45000.00, '+90-533-100-0006', 'emre.ozturk@ercan.com',   'technician',         1, 'AWU-10006'),
-- Traffic Controllers
('200-02-0001', 'Murat',   'Sahin',    '1975-09-14', '2005-02-01', 65000.00, '+90-533-200-0001', 'murat.sahin@ercan.com',   'traffic_controller', 2, 'ATCU-20001'),
('200-02-0002', 'Ayse',    'Yildiz',   '1983-12-03', '2009-08-15', 62000.00, '+90-533-200-0002', 'ayse.yildiz@ercan.com',   'traffic_controller', 2, 'ATCU-20002'),
('200-02-0003', 'Ibrahim', 'Koc',      '1979-07-21', '2007-11-01', 63000.00, '+90-533-200-0003', 'ibrahim.koc@ercan.com',   'traffic_controller', 2, 'ATCU-20003'),
('200-02-0004', 'Selin',   'Erdogan',  '1988-02-14', '2014-04-01', 59000.00, '+90-533-200-0004', 'selin.erdogan@ercan.com', 'traffic_controller', 2, 'ATCU-20004'),
-- General Employees
('300-03-0001', 'Burak',   'Acar',     '1991-10-09', '2016-06-01', 40000.00, '+90-533-300-0001', 'burak.acar@ercan.com',    'general',            3, 'AGEU-30001'),
('300-03-0002', 'Elif',    'Guler',    '1994-05-25', '2019-03-01', 38000.00, '+90-533-300-0002', 'elif.guler@ercan.com',    'general',            3, 'AGEU-30002'),
('300-03-0003', 'Serkan',  'Polat',    '1987-08-12', '2013-09-15', 42000.00, '+90-533-300-0003', 'serkan.polat@ercan.com',  'general',            3, 'AGEU-30003');

-- -------------------------------------------------------
-- 3. Technicians
-- -------------------------------------------------------
INSERT INTO technician (ssn, certification_level, certification_date) VALUES
('100-01-0001', 'master',  '2015-06-01'),
('100-01-0002', 'senior',  '2017-03-15'),
('100-01-0003', 'senior',  '2019-09-01'),
('100-01-0004', 'master',  '2013-01-20'),
('100-01-0005', 'senior',  '2016-05-10'),
('100-01-0006', 'junior',  '2020-07-01');

-- -------------------------------------------------------
-- 4. Traffic Controllers
-- -------------------------------------------------------
INSERT INTO traffic_controller (ssn, controller_license_no, last_medical_exam_date, tower_assignment) VALUES
('200-02-0001', 'LIC-TC-001', '2025-01-15', 'Main Tower'),
('200-02-0002', 'LIC-TC-002', '2024-11-20', 'Main Tower'),
('200-02-0003', 'LIC-TC-003', '2024-04-10', 'Ground Control'), -- exam > 1 year ago
('200-02-0004', 'LIC-TC-004', '2025-08-05', 'Approach Control');

-- -------------------------------------------------------
-- 5. Plane Models
-- -------------------------------------------------------
INSERT INTO plane_model (model_no, manufacturer, aircraft_type, max_capacity, max_range_km, engine_count, description) VALUES
('B737-800',  'Boeing',        'Narrow-body',  189, 5765, 2, 'Boeing 737-800 single-aisle commercial jet'),
('A320neo',   'Airbus',        'Narrow-body',  194, 6300, 2, 'Airbus A320neo fuel-efficient narrow-body'),
('B777-300',  'Boeing',        'Wide-body',    396, 13650, 2, 'Boeing 777-300 long-range wide-body'),
('A380-800',  'Airbus',        'Wide-body',    555, 15200, 4, 'Airbus A380 double-deck superjumbo'),
('ATR72-600', 'ATR',           'Turboprop',    78,  1528, 2, 'Regional turboprop for short-haul routes'),
('ERJ-145',   'Embraer',       'Regional jet', 50,  2873, 2, 'Embraer ERJ-145 regional jet'),
('C-130H',    'Lockheed',      'Cargo',        92,  7876, 4, 'Lockheed C-130H military/cargo transport'),
('B787-9',    'Boeing',        'Wide-body',    296, 14140, 2, 'Boeing 787 Dreamliner long-range');

-- -------------------------------------------------------
-- 6. Technician Expertise
-- -------------------------------------------------------
INSERT INTO technician_expertise (ssn, model_no, expertise_level, certified_date) VALUES
('100-01-0001', 'B737-800',  'advanced',     '2015-06-01'),
('100-01-0001', 'A320neo',   'advanced',     '2016-02-10'),
('100-01-0001', 'B777-300',  'intermediate', '2018-05-20'),
('100-01-0002', 'B737-800',  'advanced',     '2017-03-15'),
('100-01-0002', 'ATR72-600', 'intermediate', '2018-09-01'),
('100-01-0003', 'A320neo',   'intermediate', '2019-09-01'),
('100-01-0003', 'A380-800',  'basic',        '2020-03-15'),
('100-01-0004', 'B777-300',  'advanced',     '2013-01-20'),
('100-01-0004', 'B787-9',    'advanced',     '2015-07-01'),
('100-01-0004', 'A380-800',  'intermediate', '2016-11-10'),
('100-01-0005', 'ERJ-145',   'advanced',     '2016-05-10'),
('100-01-0005', 'ATR72-600', 'advanced',     '2017-08-20'),
('100-01-0006', 'B737-800',  'basic',        '2020-07-01'),
('100-01-0006', 'ERJ-145',   'basic',        '2021-01-15');

-- -------------------------------------------------------
-- 7. Airplanes
-- -------------------------------------------------------
INSERT INTO airplane (plane_no, model_no, capacity, year_manufactured, registration_code, status, last_service_date) VALUES
('PLN-001', 'B737-800',  162, 2015, 'TC-ERN001', 'active',      '2025-11-01'),
('PLN-002', 'B737-800',  162, 2017, 'TC-ERN002', 'active',      '2025-10-15'),
('PLN-003', 'A320neo',   150, 2019, 'TC-ERN003', 'active',      '2025-12-01'),
('PLN-004', 'A320neo',   150, 2020, 'TC-ERN004', 'maintenance', '2025-09-20'),
('PLN-005', 'B777-300',  350, 2014, 'TC-ERN005', 'active',      '2025-08-30'),
('PLN-006', 'ATR72-600',  68, 2018, 'TC-ERN006', 'active',      '2025-11-20'),
('PLN-007', 'ERJ-145',    45, 2016, 'TC-ERN007', 'active',      '2025-10-05'),
('PLN-008', 'B787-9',    280, 2021, 'TC-ERN008', 'active',      '2025-12-10'),
('PLN-009', 'A380-800',  500, 2013, 'TC-ERN009', 'retired',     '2024-06-01'),
('PLN-010', 'B737-800',  162, 2010, 'TC-ERN010', 'maintenance', '2025-07-15');

-- -------------------------------------------------------
-- 8. Hangars
-- -------------------------------------------------------
INSERT INTO hangar (hangar_no, location, capacity, hangar_type, status) VALUES
('HGR-A', 'North Apron - Section A', 5, 'storage',     'operational'),
('HGR-B', 'North Apron - Section B', 4, 'maintenance', 'operational'),
('HGR-C', 'South Apron - Section C', 6, 'mixed',       'operational'),
('HGR-D', 'East Apron - Section D',  3, 'storage',     'operational'),
('HGR-E', 'West Apron - Section E',  2, 'maintenance', 'closed');

-- -------------------------------------------------------
-- 9. Airplane Hangar Records  (IN / OUT)
-- -------------------------------------------------------
INSERT INTO airplane_hangar (plane_no, hangar_no, in_datetime, out_datetime, notes) VALUES
('PLN-001', 'HGR-A', '2025-10-01 08:00:00', '2025-10-05 16:00:00', 'Routine overnight storage'),
('PLN-002', 'HGR-A', '2025-10-10 09:00:00', '2025-10-12 10:00:00', 'Weather hold'),
('PLN-003', 'HGR-B', '2025-11-01 07:00:00', '2025-11-07 18:00:00', 'Scheduled maintenance check'),
('PLN-004', 'HGR-B', '2025-09-20 06:00:00', NULL,                   'Ongoing engine maintenance'),
('PLN-005', 'HGR-C', '2025-08-15 12:00:00', '2025-08-20 08:00:00', 'Pre-flight inspection'),
('PLN-006', 'HGR-A', '2025-11-18 14:00:00', '2025-11-21 09:00:00', 'Short-haul turnaround'),
('PLN-007', 'HGR-D', '2025-10-01 10:00:00', '2025-10-03 11:00:00', 'Overnight storage'),
('PLN-008', 'HGR-C', '2025-12-01 08:00:00', NULL,                   'Long-haul pre-departure check'),
('PLN-009', 'HGR-C', '2024-05-01 00:00:00', '2024-06-01 00:00:00', 'Final storage before retirement'),
('PLN-010', 'HGR-B', '2025-07-15 09:00:00', NULL,                   'Major overhaul - frame repair'),
('PLN-001', 'HGR-D', '2025-12-01 08:00:00', '2025-12-02 16:00:00', 'Short storage after landing'),
('PLN-002', 'HGR-C', '2025-12-05 10:00:00', NULL,                   'Current overnight storage');

-- -------------------------------------------------------
-- 10. Tests
-- -------------------------------------------------------
INSERT INTO test (test_name, description, max_score, test_category, frequency_days) VALUES
('Engine Performance Test',       'Full engine run-up and output measurement',           100, 'engine',      180),
('Avionics Systems Check',        'Testing all avionics including nav, comm and radar',  100, 'avionics',     90),
('Structural Integrity Inspection','Visual and instrument check of airframe structure',  100, 'structural',  365),
('Hydraulics & Controls Test',    'Hydraulic systems and flight control surfaces',       100, 'safety',       90),
('Cabin Safety Equipment Check',  'Fire extinguishers, oxygen masks, life vests etc.',  100, 'safety',       30),
('Landing Gear Inspection',       'Full inspection and lubrication of landing gear',     100, 'structural',  180),
('Fuel System Test',              'Fuel tanks, lines, pumps and sensors',                100, 'performance',  90),
('Emergency Systems Test',        'Emergency exits, slides, ELT and transponders',       100, 'safety',       60);

-- -------------------------------------------------------
-- 11. Test Events
-- -------------------------------------------------------
INSERT INTO test_event (plane_no, technician_ssn, test_id, test_date, hours_spent, score, notes) VALUES
-- PLN-001 (B737-800)
('PLN-001', '100-01-0001', 1, '2025-05-10', 4.5, 92.00, 'All engines nominal'),
('PLN-001', '100-01-0001', 2, '2025-08-15', 3.0, 88.00, 'Minor nav calibration needed'),
('PLN-001', '100-01-0002', 4, '2025-09-01', 2.5, 95.00, 'Controls in excellent condition'),
('PLN-001', '100-01-0006', 5, '2025-11-05', 1.5, 100.00,'All safety equipment OK'),
-- PLN-002 (B737-800)
('PLN-002', '100-01-0002', 1, '2025-04-20', 5.0, 78.00, 'One engine slightly below target'),
('PLN-002', '100-01-0001', 3, '2025-07-12', 6.0, 85.00, 'Frame in good condition'),
('PLN-002', '100-01-0006', 5, '2025-10-20', 1.5, 98.00, NULL),
-- PLN-003 (A320neo)
('PLN-003', '100-01-0003', 2, '2025-06-01', 3.5, 91.00, 'Avionics fully functional'),
('PLN-003', '100-01-0001', 7, '2025-09-15', 2.0, 87.00, 'Fuel system checks out'),
('PLN-003', '100-01-0003', 4, '2025-11-20', 2.5, 93.00, NULL),
-- PLN-004 (A320neo - maintenance)
('PLN-004', '100-01-0003', 1, '2025-08-10', 5.5, 55.00, 'Engine #2 requires overhaul - FAIL'),
('PLN-004', '100-01-0001', 6, '2025-09-20', 4.0, 72.00, 'Landing gear repaired and retested'),
-- PLN-005 (B777-300)
('PLN-005', '100-01-0004', 1, '2025-03-15', 6.0, 96.00, 'Excellent engine performance'),
('PLN-005', '100-01-0004', 3, '2025-08-01', 8.0, 90.00, 'Wide-body frame inspection complete'),
('PLN-005', '100-01-0004', 2, '2025-11-10', 4.0, 94.00, 'Avionics suite updated and tested'),
-- PLN-006 (ATR72-600)
('PLN-006', '100-01-0005', 1, '2025-05-25', 3.0, 89.00, NULL),
('PLN-006', '100-01-0005', 5, '2025-11-19', 1.0, 100.00,'All safety equipment OK'),
-- PLN-007 (ERJ-145)
('PLN-007', '100-01-0005', 4, '2025-07-08', 2.0, 82.00, 'Controls slightly stiff - noted'),
('PLN-007', '100-01-0005', 8, '2025-09-25', 3.0, 88.00, NULL),
-- PLN-008 (B787-9)
('PLN-008', '100-01-0004', 2, '2025-10-01', 4.5, 97.00, 'State-of-the-art avionics confirmed'),
('PLN-008', '100-01-0004', 1, '2025-11-15', 5.0, 99.00, 'Dreamliner engines in top condition'),
-- PLN-010 (B737-800 - major overhaul)
('PLN-010', '100-01-0001', 3, '2025-07-15', 7.0, 48.00, 'Structural cracks found - FAIL'),
('PLN-010', '100-01-0004', 6, '2025-08-20', 5.0, 65.00, 'Landing gear overhauled');

-- -------------------------------------------------------
-- 12. Repair Records
-- -------------------------------------------------------
INSERT INTO repair_record (plane_no, technician_ssn, repair_date, repair_type, description, cost, hours_spent, status) VALUES
('PLN-004', '100-01-0001', '2025-09-25', 'Engine Overhaul',       'Complete replacement of engine #2 turbine blades', 125000.00, 48.0, 'completed'),
('PLN-010', '100-01-0004', '2025-08-01', 'Structural Repair',     'Fuselage crack repair and reinforcement',           85000.00, 60.0, 'completed'),
('PLN-010', '100-01-0001', '2025-09-10', 'Landing Gear Overhaul', 'Full landing gear assembly replacement',            42000.00, 24.0, 'completed'),
('PLN-002', '100-01-0002', '2025-04-25', 'Engine Maintenance',    'Engine #1 performance tuning',                      8500.00, 10.0, 'completed'),
('PLN-007', '100-01-0005', '2025-07-10', 'Control Surface Repair','Flight control surfaces lubrication and alignment',  3200.00,  6.0, 'completed'),
('PLN-004', '100-01-0003', '2025-11-01', 'Avionics Upgrade',      'Software update for fly-by-wire systems',           15000.00, 12.0, 'in_progress');

-- -------------------------------------------------------
-- 13. Flights
-- -------------------------------------------------------
INSERT INTO flight (plane_no, flight_no, departure_airport, arrival_airport, scheduled_departure, scheduled_arrival, actual_departure, actual_arrival, status, passenger_count, controller_ssn) VALUES
('PLN-001', 'EC101', 'Ercan International (ECN)', 'Istanbul Ataturk (IST)',  '2025-12-01 06:00:00', '2025-12-01 07:30:00', '2025-12-01 06:05:00', '2025-12-01 07:35:00', 'arrived',   158, '200-02-0001'),
('PLN-001', 'EC102', 'Istanbul Ataturk (IST)',    'Ercan International (ECN)', '2025-12-01 09:00:00', '2025-12-01 10:30:00', '2025-12-01 09:10:00', '2025-12-01 10:40:00', 'arrived',   145, '200-02-0002'),
('PLN-003', 'EC201', 'Ercan International (ECN)', 'Ankara Esenboga (ESB)',   '2025-12-02 08:00:00', '2025-12-02 09:15:00', '2025-12-02 08:00:00', '2025-12-02 09:10:00', 'arrived',   140, '200-02-0001'),
('PLN-005', 'EC301', 'Ercan International (ECN)', 'London Heathrow (LHR)',   '2025-12-03 14:00:00', '2025-12-03 17:30:00', '2025-12-03 14:20:00', NULL,                   'departed',  330, '200-02-0003'),
('PLN-006', 'EC401', 'Ercan International (ECN)', 'Larnaca (LCA)',           '2025-12-04 10:00:00', '2025-12-04 10:30:00', NULL,                  NULL,                   'scheduled',  62, '200-02-0004'),
('PLN-007', 'EC501', 'Ercan International (ECN)', 'Antalya (AYT)',           '2025-12-04 12:00:00', '2025-12-04 13:30:00', NULL,                  NULL,                   'cancelled',  NULL,'200-02-0002'),
('PLN-008', 'EC601', 'Ercan International (ECN)', 'Dubai Intl (DXB)',        '2025-12-05 22:00:00', '2025-12-06 03:00:00', NULL,                  NULL,                   'scheduled', 270, '200-02-0001'),
('PLN-002', 'EC103', 'Ercan International (ECN)', 'Frankfurt (FRA)',         '2025-12-06 07:00:00', '2025-12-06 10:30:00', NULL,                  NULL,                   'scheduled', 150, '200-02-0003');
