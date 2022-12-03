-- TASK 01
CREATE DATABASE IF NOT EXISTS assignment05;
USE assignment05;


-- TASK 02
/* 1) */ 
   CREATE TABLE course(
   cid varchar(20) primary key,
   cname varchar(100),
   l int,
   t int,
   p int,
   c int
   );

/* 2) */ 
     CREATE TABLE course_coordinator(
     cid varchar(50) primary key,
     cstart varchar(50),
     cend varchar(50),
     gsubmission varchar(50),
     coordinator varchar(100),
     exam_date varchar(50)
     ); 

/* 3) */ 
     CREATE TABLE course_eligibility(
     cid varchar(50) not null,
     program varchar(50),
     batch_year int,
     batch_month varchar(50),
     eligibility varchar(100)
     );       

/* 4) */  
     CREATE TABLE course_instructor(
     cid varchar(50),
     instructor varchar(100)
     );   

/* 5) */ 
     CREATE TABLE faculty(
     dept varchar(100),
     instructor varchar(100),  
     primary key(dept,instructor)      
    );


-- Task 03
    LOAD DATA LOCAL INFILE 'D:/course.csv' 
    INTO TABLE course
    FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' ;  

    LOAD DATA LOCAL INFILE 'D:/course_coordinator.csv' 
    INTO TABLE course_coordinator
    FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' ;

    LOAD DATA LOCAL INFILE 'D:/course_eligibility.csv' 
    INTO TABLE course_eligibility
    FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' ;

    LOAD DATA LOCAL INFILE 'D:/course_instructor.csv' 
    INTO TABLE course_instructor
    FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' ;

    LOAD DATA LOCAL INFILE 'D:/faculty.csv' 
    INTO TABLE faculty
    FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' ;  


-- Task 04
-- Q1.
SELECT cname,COUNT(*) FROM course NATURAL JOIN course_eligibility GROUP BY cid; 

-- Q2.
CREATE TABLE num_instructor( SELECT cid, COUNT(instructor) AS count_inst FROM 
course_instructor GROUP BY cid ORDER BY COUNT(instructor) );

SELECT cid,instructor,cname from num_instructor NATURAL JOIN course_instructor 
NATURAL JOIN course WHERE count_inst = 3 ; 

-- Q3. 
SELECT DISTINCT cname,dept FROM course NATURAL JOIN course_instructor NATURAL JOIN 
faculty WHERE ( cid LIKE '%H' AND c <> (2*l + 2*t +p)/2 ) 
OR ( cid NOT LIKE '%H' AND c <> (2*l + 2*t + p) ); 
 
-- Q4.
SELECT cname,coordinator FROM course_coordinator NATURAL JOIN course AS not_inst WHERE
coordinator NOT IN
( SELECT instructor FROM course_instructor WHERE not_inst.cid = course_instructor.cid);

-- Q5. 
SELECT DISTINCT course.cname, course_coordinator.gsubmission FROM course JOIN 
course_coordinator ON course.cid = course_coordinator.cid; 

-- Q6.
SELECT course.cname, course_coordinator.exam_date FROM course JOIN 
course_coordinator ON course.cid = course_coordinator.cid WHERE course.cid NOT LIKE '%H';

-- Q7.
CREATE TABLE eligible_prog AS(SELECT cid, count(program) as no_elig_prog 
FROM course_eligibility GROUP BY cid);
SELECT course.cid, course_instructor.cname, course_instructor.instructor
where course.cid = course_instructor.cid AND course.cid 
IN (SELECT cid from eligible_prog WHERE no_elig_prog >= 10);

-- Q8.


-- Q9.
CREATE TABLE new_faculty AS (SELECT instructor FROM course_instructor);
SELECT dept, instructor FROM faculty;



