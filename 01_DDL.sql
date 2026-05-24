-- ============================================================
-- CMPE343 - Database Management Systems and Programming I
-- Airport Management Information System - Ercan Airport
-- DDL: Data Definition Language
-- ============================================================

DROP DATABASE IF EXISTS airport_management;
CREATE DATABASE airport_management;
USE airport_management;

-- -------------------------------------------------------
-- Table 1: union_tbl
-- -------------------------------------------------------
CREATE TABLE union_tbl (
    union_id       INT AUTO_INCREMENT PRIMARY KEY,
    union_name     VARCHAR(100) NOT NULL,
    contact_phone  VARCHAR(20),
    contact_email  VARCHAR(100),
    established_date DATE
);

-- -------------------------------------------------------
-- Table 2: employee  (base entity for ALL workers)
-- -------------------------------------------------------
CREATE TABLE employee (
    ssn                  CHAR(11)      PRIMARY KEY,   -- format: XXX-XX-XXXX
    first_name           VARCHAR(50)   NOT NULL,
    last_name            VARCHAR(50)   NOT NULL,
    birth_date           DATE,
    hire_date            DATE          NOT NULL,
    salary               DECIMAL(10,2) NOT NULL,
    phone                VARCHAR(20),
    email                VARCHAR(100),
    employee_type        ENUM('technician','traffic_controller','general') NOT NULL,
    union_id             INT           NOT NULL,
    union_membership_no  VARCHAR(30)   NOT NULL UNIQUE,
    FOREIGN KEY (union_id) REFERENCES union_tbl(union_id)
);

-- -------------------------------------------------------
-- Table 3: technician  (specialisation of employee)
-- -------------------------------------------------------
CREATE TABLE technician (
    ssn                 CHAR(11)    PRIMARY KEY,
    certification_level ENUM('junior','senior','master') DEFAULT 'junior',
    certification_date  DATE,
    FOREIGN KEY (ssn) REFERENCES employee(ssn) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- Table 4: traffic_controller  (specialisation of employee)
-- -------------------------------------------------------
CREATE TABLE traffic_controller (
    ssn                    CHAR(11)    PRIMARY KEY,
    controller_license_no  VARCHAR(30) NOT NULL UNIQUE,
    last_medical_exam_date DATE        NOT NULL,
    tower_assignment       VARCHAR(50),
    FOREIGN KEY (ssn) REFERENCES employee(ssn) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- Table 5: plane_model
-- -------------------------------------------------------
CREATE TABLE plane_model (
    model_no      VARCHAR(20)  PRIMARY KEY,
    manufacturer  VARCHAR(100) NOT NULL,
    aircraft_type VARCHAR(50),
    max_capacity  INT          NOT NULL,
    max_range_km  INT,
    engine_count  INT          DEFAULT 2,
    description   TEXT
);

-- -------------------------------------------------------
-- Table 6: technician_expertise  (many-to-many)
-- -------------------------------------------------------
CREATE TABLE technician_expertise (
    ssn             CHAR(11)    NOT NULL,
    model_no        VARCHAR(20) NOT NULL,
    expertise_level ENUM('basic','intermediate','advanced') DEFAULT 'basic',
    certified_date  DATE,
    PRIMARY KEY (ssn, model_no),
    FOREIGN KEY (ssn)      REFERENCES technician(ssn)   ON DELETE CASCADE,
    FOREIGN KEY (model_no) REFERENCES plane_model(model_no)
);

-- -------------------------------------------------------
-- Table 7: airplane
-- -------------------------------------------------------
CREATE TABLE airplane (
    plane_no           VARCHAR(20) PRIMARY KEY,
    model_no           VARCHAR(20) NOT NULL,
    capacity           INT         NOT NULL,
    year_manufactured  INT,
    registration_code  VARCHAR(20) UNIQUE,
    status             ENUM('active','maintenance','retired') DEFAULT 'active',
    last_service_date  DATE,
    FOREIGN KEY (model_no) REFERENCES plane_model(model_no)
);

-- -------------------------------------------------------
-- Table 8: hangar
-- -------------------------------------------------------
CREATE TABLE hangar (
    hangar_no   VARCHAR(10)  PRIMARY KEY,
    location    VARCHAR(100) NOT NULL,
    capacity    INT          NOT NULL,
    hangar_type ENUM('storage','maintenance','mixed') DEFAULT 'storage',
    status      ENUM('operational','closed')          DEFAULT 'operational'
);

-- -------------------------------------------------------
-- Table 9: airplane_hangar  (tracks IN / OUT dates)
-- -------------------------------------------------------
CREATE TABLE airplane_hangar (
    record_id   INT AUTO_INCREMENT PRIMARY KEY,
    plane_no    VARCHAR(20) NOT NULL,
    hangar_no   VARCHAR(10) NOT NULL,
    in_datetime  DATETIME    NOT NULL,
    out_datetime DATETIME,
    notes        TEXT,
    FOREIGN KEY (plane_no)  REFERENCES airplane(plane_no),
    FOREIGN KEY (hangar_no) REFERENCES hangar(hangar_no)
);

-- -------------------------------------------------------
-- Table 10: test
-- -------------------------------------------------------
CREATE TABLE test (
    test_id        INT AUTO_INCREMENT PRIMARY KEY,
    test_name      VARCHAR(100) NOT NULL,
    description    TEXT,
    max_score      DECIMAL(5,2) DEFAULT 100.00,
    test_category  ENUM('safety','performance','structural','avionics','engine') NOT NULL,
    frequency_days INT          -- how often this test must be repeated (days)
);

-- -------------------------------------------------------
-- Table 11: test_event  (each testing instance)
-- -------------------------------------------------------
CREATE TABLE test_event (
    event_id       INT AUTO_INCREMENT PRIMARY KEY,
    plane_no       VARCHAR(20) NOT NULL,
    technician_ssn CHAR(11)    NOT NULL,
    test_id        INT         NOT NULL,
    test_date      DATE        NOT NULL,
    hours_spent    DECIMAL(5,2) NOT NULL,
    score          DECIMAL(5,2) NOT NULL,
    pass_fail      ENUM('pass','fail') GENERATED ALWAYS AS (IF(score >= 60,'pass','fail')) STORED,
    notes          TEXT,
    FOREIGN KEY (plane_no)       REFERENCES airplane(plane_no),
    FOREIGN KEY (technician_ssn) REFERENCES technician(ssn),
    FOREIGN KEY (test_id)        REFERENCES test(test_id),
    CHECK (hours_spent > 0),
    CHECK (score >= 0 AND score <= 100)
);

-- -------------------------------------------------------
-- Table 12: repair_record  (real-life extension)
-- -------------------------------------------------------
CREATE TABLE repair_record (
    repair_id      INT AUTO_INCREMENT PRIMARY KEY,
    plane_no       VARCHAR(20)  NOT NULL,
    technician_ssn CHAR(11)     NOT NULL,
    repair_date    DATE         NOT NULL,
    repair_type    VARCHAR(100) NOT NULL,
    description    TEXT,
    cost           DECIMAL(10,2),
    hours_spent    DECIMAL(5,2),
    status         ENUM('completed','in_progress','pending') DEFAULT 'completed',
    FOREIGN KEY (plane_no)       REFERENCES airplane(plane_no),
    FOREIGN KEY (technician_ssn) REFERENCES technician(ssn)
);

-- -------------------------------------------------------
-- Table 13: flight  (real-life extension)
-- -------------------------------------------------------
CREATE TABLE flight (
    flight_id           INT AUTO_INCREMENT PRIMARY KEY,
    plane_no            VARCHAR(20)  NOT NULL,
    flight_no           VARCHAR(10)  NOT NULL,
    departure_airport   VARCHAR(100) NOT NULL,
    arrival_airport     VARCHAR(100) NOT NULL,
    scheduled_departure DATETIME     NOT NULL,
    scheduled_arrival   DATETIME     NOT NULL,
    actual_departure    DATETIME,
    actual_arrival      DATETIME,
    status              ENUM('scheduled','departed','arrived','cancelled','delayed') DEFAULT 'scheduled',
    passenger_count     INT,
    controller_ssn      CHAR(11),
    FOREIGN KEY (plane_no)       REFERENCES airplane(plane_no),
    FOREIGN KEY (controller_ssn) REFERENCES traffic_controller(ssn)
);
