-- TASK 01
create database if not exists assignment08;
use assignment07;

-- TASK 02
-- TASK 2.1
create table ett(
    cid varchar(50),
    exam_date date,
    start_time time,
    end_time time
);

load data local infile 'D:/exam-time-table.csv' 
 into table ett
 fields terminated by ',' lines terminated by '\n';

-- TASK 2.2 
create table cc(
    cid varchar(50) primary key,
    credits int 
);

load data local infile 'D:/course-credits.csv' 
 into table cc
 fields terminated by ',' lines terminated by '\n';

--TASK 2.3 
create table cwsl(
    serial_number int,
    roll_number int,
    name varchar(100),
    email varchar(100),
    cid varchar(50) 
);

load data local infile 'D:/BT.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

load data local infile 'D:/CE.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/CH.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/CL.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/CSE.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/DD.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/EEE.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/HS.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/MA.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/ME.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n';

 load data local infile 'D:/PH.csv' 
 into table cwsl
 fields terminated by ',' lines terminated by '\n'; 