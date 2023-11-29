-- 1
use sakila;
SELECT film.title, AVG(CHAR_LENGTH(film.description)) AS average_length
FROM film
GROUP BY film.title
ORDER BY average_length DESC;

--2 
--ได้ เพราะ เราสามารถดึงข้อมูลจากตารางหลายๆ ตารางได้ในคำสั่ง SQL เดียวกัน
use sakila;
SELECT film_id, title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id IN (
        SELECT actor_id
        FROM actor
        WHERE first_name = 'Penelope' AND last_name = 'Guiness'
        )
);

--3
-- Grant 
GRANT UPDATE ON sakila.film TO store_manager;
-- Revoke 
REVOKE UPDATE ON sakila.film FROM store_manager;

--4
CASE
    WHEN score >= 94 THEN "A"
    WHEN score >= 90 THEN "A-"
    WHEN score >= 87 THEN "B+"
    WHEN score >= 83 THEN "B"
    WHEN score >= 80 THEN "B-"
    WHEN score >= 77 THEN "C+"
    WHEN score >= 73 THEN "C"
    WHEN score >= 70 THEN "C-"
    WHEN score >= 67 THEN "D+"
    WHEN score >= 60 THEN "D"
    ELSE "F"
END

--5
-- 5.1
CREATE PROCEDURE get_last_customer(IN movie_title VARCHAR(255), OUT last_customer VARCHAR(255))
BEGIN
    SELECT customer.last_name INTO last_customer
    FROM film
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN customer ON rental.customer_id = customer.customer_id
    WHERE film.title = movie_title
    ORDER BY rental.return_date DESC
    LIMIT 1;
END 

-- 5.2
CREATE PROCEDURE get_movies_by_actor(IN actor_name VARCHAR(255))
BEGIN
    SELECT film.title
    FROM film
    JOIN film_actor ON film.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id
    WHERE actor.first_name = SUBSTRING_INDEX(actor_name, ' ', 1)
        AND actor.last_name = SUBSTRING_INDEX(actor_name, ' ', -1);
END


--6 คิดว่าแค่แยกเรตGก็จะมีหนังเหมาะกับเด็กแล้ว
CREATE VIEW children_movies AS
SELECT title,rating,description
FROM film
WHERE rating = "G";

--7 

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

--8
CREATE TABLE employees_copy AS
SELECT * FROM employees;

--9
CREATE INDEX idx_employee_id ON employees(employee_id); --เพราะมีทางผ่านเยอะสุด

CREATE INDEX idx_department_name ON departments(department_name); --เพราะมีทางผ่านรองลงมา

CREATE INDEX idx_city ON locations(city);--เพราะมีทางผ่านน้อยรองลงมา

--10
SELECT
    j.job_id,
    j.job_title,
    e.first_name,
    e.last_name,
    e.salary,
    (j.max_salary+j.min_salary)/2 as avg_salary_in_job
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
    WHERE (e.job_id, e.salary) IN (
        SELECT job_id,MAX(salary) AS max_salary
        FROM employees
    GROUP BY job_id
);
