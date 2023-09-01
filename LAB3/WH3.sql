use university;
SELECT * FROM student NATURAL LEFT JOIN takes;
SELECT * FROM student NATURAL RIGHT JOIN takes;

SELECT
    I.ID,
    I.name,
    COUNT(T.course_id) AS num_sections_taught
FROM
    instructor I
LEFT JOIN
    teaches T ON I.ID = T.ID
GROUP BY
    I.ID, I.name;

SELECT 
    S.course_id,
    I.name
FROM
    teaches T
LEFT JOIN    
    instructor I ON I.ID = T.ID
LEFT JOIN
    section S ON T.course_id = S.course_id AND T.sec_id = S.sec_id
WHERE
    T.semester = "Spring" AND T.year = 2010;

SELECT d.dept_name, COUNT(i.ID) AS num_instructors
FROM department d
LEFT JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name;







