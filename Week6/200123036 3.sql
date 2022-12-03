-- TASK 01
create database if not exists assignment06;
use assignment06;

-- TASK 02
--Task 2.1 
   create table course(
   cid varchar(20) primary key,
   cname varchar(100),
   l int,
   t int,
   p int,
   c int
   );

     --Task 2.2
     create table course_coordinator(
     cid varchar(50) primary key,
     cstart varchar(50),
     cend varchar(50),
     gsubmission varchar(50),
     coordinator varchar(100),
     exam_date varchar(50)
     ); 

     --Task 2.3
     create table course_eligibility(
     cid varchar(50) not null,
     program varchar(50),
     batch_year int,
     batch_month varchar(50),
     eligibility varchar(100)
     );       

     --Task 2.4
     create table course_instructor(
     cid varchar(50),
     instructor varchar(100)
     );   

     --Task 2.5
     create table faculty(
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

    
    --Task 4.1
    --nested query
    select cname, table1.count_cid from course left outer join ( select cid, count(cid) as 
    count_cid from course_eligibility group by cid) as table1 on course.cid = table1.cid; 
     
    --correlated nested query
    select cname, count_program from ( select cname, count(program) as count_program,
    course.cid from course left outer join course_eligibility on 
    course.cid = course_eligibility.cid group by cid )
    as table2 where exists ( select * from course where course.cid = table2.cid );

    --Task 4.2
    --nested query
    create table table3 as select cid, count(distinct instructor) as count_inst from 
    course_instructor group by cid;
    select cid, cname, instructor from table3 natural join course_instructor 
    natural join faculty natural join course as table4 where table4.cid
    in (select course.cid from course) and count_inst =(select max(count_inst) from table3)
    order by cid;

    --correlated nested query
    create table table3 as select cid, count(distinct instructor) as count_inst from 
    course_instructor group by cid;
    select cid, cname, instructor from table3 natural join course_instructor 
    natural join faculty natural join course as table4 where exists
    (select * from course where course.cid = table4.cid ) and 
    count_inst = ( select max(count_inst) from table3) order by cid;
                
--Task 4.3
--nested query
 create table table5 as ( select tab1.cid , tab2.instructor, tab2.dept from
 course_instructor as tab1 , faculty as tab2 where tab1.instructor = tab2.instructor);
 select distinct cname, dept from course natural join table5 where ((cid like "%H"
 and ( c<> (( 2*l + 2*t + p )/2))) or (cid not like "%H" and ( c<> ( 2*l + 2*t + p) ) ) );

--correlated nested query
create table table5 as ( select tab1.cid , tab2.instructor, tab2.dept from
course_instructor as tab1 , faculty as tab2 where tab1.instructor = tab2.instructor);
select distinct (cname), dept from course as tab3, table5 as tab4 where tab3.cid=tab4.cid 
and exists (select cid from course_coordinator where ( (cid like "%H" and 
( c<> ((2*l + 2*t + p)/2 ))) or (cid not like "%H" and (c<> (2*l + 2*t + p ) ))) and 
(tab3.cid = cid));
 
-- task 4.4
--nested query
create table table7 as select cid,coordinator from course_coordinator as s1 where 
coordinator not in (select instructor from course_instructor as s2 where 
s1.cid =  s2.cid); 
create table table8 as select cid,cname from course where cid in (select cid from table7);
select cname,coordinator from table8,table7 where table8.cid = table7.cid;

--correlated nested query
select cname, coordinator from course as table9 natural join course_coordinator 
as table10 where not exists (select * from course_instructor where table9.cid = 
course_instructor.cid and table10.coordinator = course_instructor.instructor );

--task 4.5
--nested query 
select cname, gsubmission from (select cid,gsubmission from course_coordinator) as f1,
course as f2 where f1.cid = f2.cid ;

--correlated nested query
select cname, gsubmission from (select cid, gsubmission from course_coordinator group by 
cid) as temp1, course as temp2 where exists (select course.cid from course where 
course.cid = temp1.cid and course.cid = temp2.cid);

--Task 4.6
--nested query
select cname,temp3.exam_date from course join (select cid, gsubmission as exam_date from 
course_coordinator) as temp3 where course.cid= temp3.cid and course.cid not like "%H" ;

--correlated nested query
select cname, gsubmission as exam_date from course join course_coordinator as temp4 on 
temp4.cid = course.cid where exists (select cid from course_coordinator as temp4 where 
temp4.cid not like "%H" and temp4.cid = course.cid );

--Task 4.7
--nested query
create table temp_1 as (select cid, count(program) as count_program
from course_eligibility group by cid );
select cid, cname, instructor from course natural join course_instructor where cid
in (select cid from temp_1 where count_program >= 10 );  

--correlated nested query
create table temp_1 as (select cid, count(program) as count_program
from course_eligibility group by cid );
select temp_2.cid, cname, instructor from course as temp_2, course_instructor as temp_3 
where temp_2.cid = temp_3.cid and exists (select cid 
from temp_1 where ( count_program >= 10 and temp_1.cid = temp_2.cid));  
 

--Task 4.8
--nested Query
select m1.dept, m1.instructor, m2.cid from faculty as m1,
course_instructor as m2 where m1.instructor = m2.instructor and m2.cid in 
(select cid from course) ;

--correlated nested query
select m3.dept, m3.instructor, m4.cid from faculty as m3,
course_instructor as m4 where exists (select course.cid from course where 
m4.cid = course.cid and m3.instructor = m4.instructor );

--Task 4.9
--nested Query
select dept, instructor from faculty 
where instructor not in (select instructor from course_instructor) order by dept;

--correlated nested query
select dept, instructor from faculty 
where not exists (select instructor from course_instructor as T1 where
T1.instructor = faculty.instructor) order by dept;


--Task 05
--Task 5.1
create view Q51 as select cname, table1.count_cid from course left outer join (select cid, count(cid) as 
count_cid from course_eligibility group by cid) as table1 on course.cid = table1.cid;    
     
--Task 5.2
create table table3 as select cid, count(distinct instructor) as count_inst from 
course_instructor group by cid;
create view Q52 as select cid, cname, instructor from table3 natural join course_instructor 
natural join faculty natural join course as table4 where table4.cid
in (select course.cid from course) and count_inst =(select max(count_inst) from table3)
order by cid;    
               
--Task 5.3
create table table5 as ( select tab1.cid , tab2.instructor, tab2.dept from
course_instructor as tab1 , faculty as tab2 where tab1.instructor = tab2.instructor);
create view Q53 as select distinct cname, dept from course natural join table5 where ((cid like "%H"
 and ( c<> (( 2*l + 2*t + p )/2))) or (cid not like "%H" and ( c<> ( 2*l + 2*t + p) ) ) );
 
-- task 5.4
create table table7 as select cid,coordinator from course_coordinator as s1 where 
coordinator not in (select instructor from course_instructor as s2 where 
s1.cid =  s2.cid); 
create table table8 as select cid,cname from course where cid in (select cid from table7);
create view Q54 as select cname,coordinator from table8,table7 where table8.cid = table7.cid;

--task 5.5 
create view Q55 as select cname, gsubmission from (select cid,gsubmission from course_coordinator) as f1,
course as f2 where f1.cid = f2.cid ;

--Task 5.6
create view Q56 as select cname,temp3.exam_date from course join (select cid, gsubmission as exam_date from 
course_coordinator) as temp3 where course.cid = temp3.cid and course.cid not like "%H" ;

--Task 5.7
create table temp_1 as (select cid, count(program) as count_program
from course_eligibility group by cid );
create view Q57 as select cid, cname, instructor from course natural join course_instructor where cid
in (select cid from temp_1 where count_program >= 10 ); 

--Task 5.8
create view Q58 as select m1.dept, m1.instructor, m2.cid from faculty as m1,
course_instructor as m2 where m1.instructor = m2.instructor and m2.cid in 
(select cid from course) ;

--Task 5.9
create view Q59 as select dept, instructor from faculty 
where instructor not in (select instructor from course_instructor) order by dept;


