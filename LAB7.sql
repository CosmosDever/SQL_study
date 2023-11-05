use university;
--1
SELECT title
FROM course
WHERE dept_name = 'Comp. Sci.' AND credits = 3;

--2
select ID from student join takes using (ID) 
where (course_id, sec_id, semester, year) IN 
(select course_id, sec_id, semester, year 
from instructor join teaches using (ID) where name = 'Einstein');

--3
SELECT MAX(salary) AS highest_salary
FROM instructor;

--4
SELECT *
FROM instructor
WHERE salary = (
    SELECT MAX(salary)
    FROM instructor
);

--5
SELECT sec_id, COUNT(*) AS enrollment
FROM takes
WHERE semester = 'Autumn' AND year = 2017
GROUP BY sec_id;

--6
SELECT MAX(enrollment) AS max_enrollment
FROM (
    SELECT COUNT(*) AS enrollment
    FROM takes
    WHERE semester = 'Autumn' AND year = 2017
    GROUP BY sec_id
) AS section_enrollment;

--7
SELECT sec_id, COUNT(*) AS enrollment
FROM takes
WHERE semester = 'Autumn' AND year = 2017
GROUP BY sec_id
HAVING COUNT(*) = (
    SELECT MAX(enrollment)
    FROM (
        SELECT COUNT(*) AS enrollment
        FROM takes
        WHERE semester = 'Autumn' AND year = 2017
        GROUP BY sec_id
    ) AS section_enrollment
);

--8
INSERT INTO course (course_id, title, credits)
VALUES (
    'CS-001',
    'Weekly Seminar',
    0
);

--9
INSERT INTO takes (course_id, sec_id, semester, year)
VALUES ('CS-001', 1, 'Autumn', 2017);

--10
INSERT INTO takes (ID, course_id, sec_id, semester, year)
SELECT student.ID, 'CS-001', 1, 'Autumn', 2017
FROM student
JOIN department ON student.dept_name = department.dept_name
WHERE department.dept_name = 'Comp. Sci.';

--11
DELETE FROM takes
WHERE sec_id = (SELECT sec_id
                FROM takes
                WHERE semester = 'Autumn' AND year = 2017
                GROUP BY sec_id
                HAVING COUNT(*) = (SELECT MAX(enrollment)
                                FROM (SELECT COUNT(*) AS enrollment
                                        FROM takes
                                        WHERE semester = 'Autumn' AND year = 2017
                                        GROUP BY sec_id) AS section_enrollment))
AND ID IN (SELECT ID
            FROM student
            WHERE name = 'Chavez');

--12
DELETE FROM course
WHERE course_id = 'CS-001';

--13
DELETE FROM takes
WHERE sec_id IN (
    SELECT sec_id
    FROM course
    WHERE LOWER(title) LIKE '%database%'
);
