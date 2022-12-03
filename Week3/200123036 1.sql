TASK 01:- 
    CREATE TABLE course(
    CourseNo varchar(50) primary key,
    CourseTitle varchar(50) not null,
    L int not null,
    T int not null,
    P int not null,
    C int not null,
    TypeOfCourse varchar(50) not null
);

TASK 02:-
LOAD DATA LOCAL INFILE 'D:/courses.csv' INTO TABLE course
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

TASK 03:-
CREATE TABLE  course_offered_to(
    CourseNo varchar(50) primary key,
    TypeOfCourse varchar(50) not null,
    Offered_to varchar(50) not null,
    foreign key(CourseNo) references course(CourseNo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

TASK 04:-
LOAD DATA LOCAL INFILE 'D:/courses-offered-to.csv' INTO TABLE course_offered_to
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

TASK 05:-
CREATE TABLE course_exam_slot(
   CourseNo varchar(50) primary key,
   Exam_Slot varchar(10),
   Exam_Date_and_Time varchar(50),
   foreign key(CourseNo) references course(CourseNo)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

TASK 06:-
LOAD DATA LOCAL INFILE 'D:/courses-exam-slots.csv' INTO TABLE course_exam_slot
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

TASK 07:-
CREATE TABLE faculty(
   faculty_id varchar(50) primary key,
   dept_name varchar(50) not null,
   faculty_name varchar(50) not null
);

TASK 08:-
LOAD DATA LOCAL INFILE 'D:/bt.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ce.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ch.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/cl.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/cs.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/da.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/dd.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/dm.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ee.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/en.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/hs.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ifst.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ls.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ma.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/me.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/nt.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ph.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/ra.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:/rt.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

TASK 09:-
CREATE TABLE faculty_course_allotment(
    CourseNo varchar(50),
    dept_name varchar(50) not null,
    faculty_id int,
    primary key(CourseNo,faculty_id),
    foreign key(CourseNo) references course(CourseNo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    foreign key(faculty_id) references faculty(faculty_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

TASK 10:-
LOAD DATA LOCAL INFILE 'D:/faculty-course-allotment.csv'
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n';

/* In faculty_course_allotment table, there is an error in line 430 
(faculty_id is BD and not any integer value)
to resolve the error, we have to delete the row from the table */
