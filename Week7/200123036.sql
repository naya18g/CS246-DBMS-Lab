-- TASK 01
create database if not exists assignment07;
use assignment07;

-- TASK 02
-- 2.1
delimiter // 
create function roll_year(rollno int)  
returns int deterministic 
begin
 declare year int ;
 set year = 2000 + (rollno/10000000);
 return year;
end ;// 
delimiter ;


-- 2.2
delimiter // 
create function roll_progcode(rollno int) 
returns varchar(10) deterministic
begin
  declare code int;
  declare finalcode varchar(10);
  set code = rollno/100000 ;
  set code  = code % 100 ;
  if(code = 1)
  then
    set finalcode = '01';
  else
    set finalcode = '02';
  end if;  
  return finalcode;
end;// 
delimiter ;

-- 2.3  
delimiter //
create function roll_dept(rollno int) 
returns varchar(10) deterministic
begin
	declare code int;
    declare deptcode varchar(10);
    set code = (roll / 1000);
    set code = code % 100;
    case 
    when (code = 1)
    then
		set deptcode = 'CSE';
	when (code = 2)
    then
		set deptcode = 'ECE';
	when(code = 3)
    then
		set deptcode = 'ME';
	when(code = 4)
    then
		set deptcode = 'CE';
	when(code = 5)
    then
		set deptcode = 'DD';
	when(code = 6)
    then
		set deptcode = 'BSBE';
	when(code = 7)
    then
		set deptcode = 'CL';
	when(code = 8)
    then
		set deptcode = 'EEE';
	when(code = 21)
    then
		set deptcode = 'EPH';
	when(code = 22)
    then
		set deptcode = 'CST';
	when(code = 23)
    then
		set deptcode = 'M & C';
	end case;
    return deptcode;
end;//
delimiter ;


-- TASK 03
create table hss_electives(
   roll_number int primary key,
   sname varchar(100) not null,
   cid varchar(50) not null,
   cname varchar(100) not null
);

-- TASK 04
create table student_details(
    roll_number int primary key,
    sname varchar(100) not null,
    joined_year int not null, 
    joined_program varchar(100) not null,
    joined_dept varchar(100) not null
);   

-- TASK 05
delimiter // 
create trigger insert_hss
before insert on hss_electives
for each row
begin
 insert into student_details set roll_number = new.roll_number, sname = new.sname, 
 joined_year = roll_year(new.roll_number), joined_program = roll_progcode(new.roll_number),
 joined_dept = roll_dept(new.roll_number);
end; //
delimiter;

-- TASK 06
 load data local infile 'D:/HSS_ELECTIVE_ALLOCATION_2018_BATCH.csv' 
 into table hss_electives
 fields terminated by '#' lines terminated by '\n'
 ignore 4 rows;

-- TASK 07
-- TASK 7.1
insert into hss_electives(roll_number,sname,cid,cname) values 
(20000012345678934657456,'Gupta','HS211','Sociology' );

insert into hss_electives(roll_number,sname,cid,cname) values 
(20034567890123456789789,'Sen','HS236','Art');

-- TASK 7.2 
insert into hss_electives(roll_number,sname,cid,cname) values 
(200356036,'Riya','HS211','Sociology');

insert into hss_electives(roll_number,sname,cid,cname) values 
(200756036,'Manas','HS236','Language');

-- TASK 7.3 
insert into hss_electives(roll_number,sname,cid,cname) values 
(200256036,'Meena','HS211','Sociology');

insert into hss_electives(roll_number,sname,cid,cname) values 
(200144049,'Kapoor','HS236','Art');

-- TASK 7.4
insert into hss_electives(roll_number,sname,cid,cname) values 
('ABC','Roy','HS245','Language');

insert into hss_electives(roll_number,sname,cid,cname) values 
('SDE','Kapoor','HS236','Craft');


-- TASK 08
delimiter // 
create trigger proc_hss
before update on hss_electives 
for each row
begin
 update student_details set roll_number = hss_electives.roll_number, 
 sname = hss_electives.sname, joined_year = roll_year(hss_electives.roll_number), 
 joined_program = roll_progcode(hss_electives.roll_number),
 joined_dept = roll_dept(hss_electives.roll_number);
end; //
delimiter;

-- TASK 09
delimiter // 
create trigger del_hss
after delete on hss_electives 
for each row
begin
 delete from student_details where roll_number = old.roll_number ;
end; //
delimiter;