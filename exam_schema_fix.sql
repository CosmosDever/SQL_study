-- CREATE TABLE regions (
-- 	region_id INT (11) AUTO_INCREMENT PRIMARY KEY,
-- 	region_name VARCHAR (25) DEFAULT NULL
-- );

-- CREATE TABLE countries (
-- 	country_id CHAR (2) PRIMARY KEY,
-- 	country_name VARCHAR (40) DEFAULT NULL,
-- 	region_id INT (11) NOT NULL,
-- 	FOREIGN KEY (region_id) REFERENCES regions (region_id) ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- CREATE TABLE locations (
-- 	location_id INT (11) AUTO_INCREMENT PRIMARY KEY,
-- 	street_address VARCHAR (40) DEFAULT NULL,
-- 	postal_code VARCHAR (12) DEFAULT NULL,
-- 	city VARCHAR (30) NOT NULL,
-- 	state_province VARCHAR (25) DEFAULT NULL,
-- 	country_id CHAR (2) NOT NULL,
-- 	FOREIGN KEY (country_id) REFERENCES countries (country_id) ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- CREATE TABLE jobs (
-- 	job_id INT (11) AUTO_INCREMENT PRIMARY KEY,
-- 	job_title VARCHAR (35) NOT NULL,
-- 	min_salary DECIMAL (8, 2) DEFAULT NULL,
-- 	max_salary DECIMAL (8, 2) DEFAULT NULL
-- );

-- CREATE TABLE departments (
-- 	department_id INT (11) AUTO_INCREMENT PRIMARY KEY,
-- 	department_name VARCHAR (30) NOT NULL,
-- 	location_id INT (11) DEFAULT NULL,
-- 	FOREIGN KEY (location_id) REFERENCES locations (location_id) ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- CREATE TABLE employees (
-- 	employee_id INT (11) AUTO_INCREMENT PRIMARY KEY,
-- 	first_name VARCHAR (20) DEFAULT NULL,
-- 	last_name VARCHAR (25) NOT NULL,
-- 	email VARCHAR (100) NOT NULL,
-- 	phone_number VARCHAR (20) DEFAULT NULL,
-- 	hire_date DATE NOT NULL,
-- 	job_id INT (11) NOT NULL,
-- 	salary DECIMAL (8, 2) NOT NULL,
-- 	manager_id INT (11) DEFAULT NULL,
-- 	department_id INT (11) DEFAULT NULL,
-- 	FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON DELETE CASCADE ON UPDATE CASCADE,
-- 	FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE CASCADE ON UPDATE CASCADE,
-- 	FOREIGN KEY (manager_id) REFERENCES employees (employee_id)
-- );

-- CREATE TABLE dependents (
-- 	dependent_id INT (11) AUTO_INCREMENT PRIMARY KEY,
-- 	first_name VARCHAR (50) NOT NULL,
-- 	last_name VARCHAR (50) NOT NULL,
-- 	relationship VARCHAR (25) NOT NULL,
-- 	employee_id INT (11) NOT NULL,
-- 	FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE ON UPDATE CASCADE
-- );

--7 แก้

CREATE database exam;
use exam;
CREATE TABLE regions (
    region_id INT (11) AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR (25) DEFAULT NULL
);--ไม่เปลี่ยน

CREATE TABLE countries (
    country_id CHAR (2) PRIMARY KEY,
    country_name VARCHAR (40) DEFAULT NULL,
    region_id INT (11) NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions (region_id) ON DELETE CASCADE ON UPDATE CASCADE
);--ใช้ Cascade on delete กับ update. เพราะถ้า country ถูกลบ หรืออัปเดต primary key มันจะลบหรืออัปเดตตามนั้นด้วย

CREATE TABLE locations (
    location_id INT (11) AUTO_INCREMENT PRIMARY KEY,
    street_address VARCHAR (40) DEFAULT NULL,
    postal_code VARCHAR (12) DEFAULT NULL,
    city VARCHAR (30) NOT NULL,
    state_province VARCHAR (25) DEFAULT NULL,
    country_id CHAR (2) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries (country_id) ON DELETE CASCADE ON UPDATE CASCADE
);--Cascade on delete กับ update. เพราะถ้าหาก country_id ที่เกี่ยวข้องของ locations ถูกลบหรืออัปเดต ก็ควรลบหรืออัปเดต locations

CREATE TABLE jobs (
    job_id INT (11) AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR (35) NOT NULL,
    min_salary DECIMAL (8, 2) DEFAULT NULL,
    max_salary DECIMAL (8, 2) DEFAULT NULL
);--ไม่เปลี่ยน

CREATE TABLE departments (
    department_id INT (11) AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR (30) NOT NULL,
    location_id INT (11) DEFAULT NULL,
    FOREIGN KEY (location_id) REFERENCES locations (location_id) ON DELETE SET NULL ON UPDATE CASCADE
);--Set null on delete . เพราะถ้า department ถูกลบ หรืออัปเดตตำแหน่งที่เกี่ยวข้องของ departments ถูกลบ ให้ตั้งค่า location_id ในตารางแผนกเป็น null

CREATE TABLE employees (
    employee_id INT (11) AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR (20) DEFAULT NULL,
    last_name VARCHAR (25) NOT NULL,
    email VARCHAR (100) NOT NULL,
    phone_number VARCHAR (20) DEFAULT NULL,
    hire_date DATE NOT NULL,
    job_id INT (11) NOT NULL,
    salary DECIMAL (8, 2) NOT NULL,
    manager_id INT (11) DEFAULT NULL,
    department_id INT (11) DEFAULT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id) ON DELETE SET NULL ON UPDATE CASCADE
);--Set null on delete ให้ the department กับ manager. เพราะหาก department_id หรือ manager_id ที่เกี่ยวข้องของ employees ถูกลบ ก็จะตั้งค่า foreign keys ที่เกี่ยวข้องในตาราง employees เป็นค่าว่าง
CREATE TABLE dependents (
    dependent_id INT (11) AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    relationship VARCHAR (25) NOT NULL,
    employee_id INT (11) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);--Cascade on delete กับ update. เพราะหาก employee ถูกลบหรืออัปเดต primary key dependentsที่เกี่ยวข้องควรถูกลบหรืออัปเดตตามนั้น
