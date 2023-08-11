
 -- 1. Creating a Table: Create a table named "Students" with columns: 
 "student_id" (integer), "first_name" (text), "last_name" (text), and "age" (integer).
	
	CREATE TABLE students(student_id INT,first_name TEXT,last_name TEXT,age INT,
						  PRIMARY KEY(student_id));
	SELECT * FROM students;
	
 -- 2)Insert a few rows of sample data into the "Students" table you created in the 
 previous exercise.

INSERT INTO students(student_id,first_name,last_name,age)VALUES(12,'Nidhi','Kumar',18),
      (14,'Kamalesh','Kumar',19),(20,'Siva','priya',22),(7,'Dev','Anand',18)RETURNING *;
INSERT INTO students VALUES(29,'Radhika','Venkat',24),(35,'Sathya','Narayanan',29),
                           (34,'Leela','kumar',39);
																
 -- 3)a. Retrieve all the records from the "Students" table.

SELECT * FROM students;

-- b. Retrieve the first and last names of students whose age is greater than 20. 

SELECT first_name,last_name
FROM students
WHERE students.age>=20;

-- c. Count the number of students in the table. 


SELECT COUNT(*) AS number_of_students
FROM students;

-- d. Retrieve the names of students in alphabetical order by their last names.

SELECT first_name,last_name
FROM students
ORDER BY last_name ASC;

-- 4) a. Update the age of a specific student in the "Students" table.

UPDATE students
SET age= 20
WHERE student_id=14;

-- b. Delete a student's record from the table based on their ID.

DELETE FROM students WHERE student_id=12 ;

SELECT * FROM students;
-- 5) a. Retrieve the first name, last name, and age of students aged between 18 and 25.

SELECT first_name,last_name,age
FROM students
WHERE age BETWEEN 18 AND 25;

-- b. Retrieve the names of students in descending order of their ages.

SELECT first_name,last_name
FROM students
ORDER BY age DESC;

-- 6)a. Calculate the average age of all students. 

SELECT AVG(age) AS average_age
FROM students;

-- b. Find the maximum age among all students.

SELECT MAX(age) AS MAXIMUM_AGE
FROM students;

-- c. Calculate the total age of all students.

SELECT SUM(age) AS TOTAL_AGE
FROM students;

-- 7. Retrieve the count of students for each age group (e.g., 18-20, 21-25, etc.).

SELECT 
CASE 
	WHEN age>=18 AND age<=20 THEN '18-20'
	WHEN age>=21 AND age<=25 THEN '21-25'
	WHEN age>=26 AND age<=35 THEN '26-35'
	WHEN age>=35 THEN '35+'
	END AS age_group,
	COUNT(*) AS Number_of_students	
FROM students
GROUP BY age_group
ORDER BY age_group;

-- 8)a)Create another table named "Courses" with columns:"course_id"(integer) and "course_name"(text). 

CREATE TABLE courses(course_id INT,course_name TEXT);

-- b. Insert some sample course data into the "Courses" table. 


INSERT INTO courses VALUES(23,'C++'),(25,'C'),(29,'Github'),(22,'Python'),(18,'HTML'),
                          (129,'CSS'),(290,'Javascript'),(123,'C#') RETURNING *;

-- c) Create a new table "StudentCourses" with columns: "student_id" and "course_id" to represent 
 a many-to-many relationship between students and courses.

CREATE TABLE studentCourses(student_id INT,course_id INT);
SELECT * FROM studentCourses;

-- d) Insert sample data into the "StudentCourses" table. 

INSERT INTO StudentCourses VALUES(7,123),(35,129),(20,22),(14,123),(34,290),(34,29),(34,18),
                                 (6,129),(35,18) RETURNING *;


-- e) Write a query to retrieve the courses taken by a specific student.
				   
SELECT course_name 
FROM courses
JOIN studentCourses ON studentCourses.course_id=courses.course_id WHERE student_id IN
	(SELECT student_id FROM studentCourses WHERE student_id IN 
	 (SELECT student_id FROM students WHERE first_name='Kamalesh'))GROUP BY course_name;
																			
-- 9) retrieve the names of the students who enrolled in course_name eg.Mathematics

SELECT first_name,last_name
FROM students
WHERE student_id IN (SELECT student_id from studentCourses WHERE course_id IN 
					 (SELECT course_id FROM courses WHERE course_name IN 
					  (SELECT course_name FROM courses WHERE course_name='C#')));


-- 10)Retrieve the names of students whose last name contains the letter "s."


SELECT first_name,last_name
FROM students
WHERE first_name LIKE'%s%'or last_name LIKE'%s%';

SELECT first_name,last_name
FROM students
WHERE first_name ILIKE'%s%'or last_name ILIKE'%s%';

