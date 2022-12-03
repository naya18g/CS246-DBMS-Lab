TASK 01 :-
CREATE DATABASE IF NOT EXISTS assignment04;
USE assignment04;

TASK 02 :-
CREATE TABLE hss_electives(
  roll_number int primary key,
  sname varchar(50) not null,
  cid varchar(50) not null,
  cname varchar(150) not null
);

TASK 03 :-
 LOAD DATA LOCAL INFILE 'D:/HSS_ELECTIVE_ALLOCATION_2018_BATCH.csv' 
 INTO TABLE hss_electives
 FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n'
 IGNORE 4 rows;

TASK 04 :-
1. INSERT INTO hss_electives(roll_number,sname,cid,cname) VALUES 
 (180101058,'Pranav Gupta','HS 236','Sociological Perspectives on Modernity');

 /* ERROR 1062 (23000): Duplicate entry '180101058' for key 'hss_electives.PRIMARY' */

2. INSERT INTO hss_electives(sname,cid,cname) VALUES 
 ('Pranav Gupta','HS 236','Sociological Perspectives on Modernity');

 /* ERROR 1364 (HY000): Field 'roll_number' doesn't have a default value */

3. INSERT INTO hss_electives(roll_number,cid,cname) VALUES
 (180102158,'HS 236','Economics of Uncertainty and Information');

 /* ERROR 1364 (HY000): Field 'sname' doesn't have a default value */

4. INSERT INTO hss_electives(roll_number,sname,cname) VALUES
 (180103158,'Pranav Gupta','Economics of Uncertainty and Information');

 /* ERROR 1364 (HY000): Field 'cid' doesn't have a default value */

5. INSERT INTO hss_electives(roll_number,sname,cid) VALUES
 (180104158,'Pranav Gupta','HS 424');

 /* ERROR 1364 (HY000): Field 'cname' doesn't have a default value */

 TASK 05 :-
 1. UPDATE hss_electives SET roll_number = NULL WHERE roll_number = 180123047;

  /* ERROR 1048 (23000): Column 'roll_number' cannot be null */ 

 2. UPDATE hss_electives SET roll_number = 180123045 WHERE roll_number = 180123046;

  /* ERROR 1062 (23000): Duplicate entry '180123045' for key 'hss_electives.PRIMARY' */

 3. UPDATE hss_electives SET sname = NULL;

  /* ERROR 1048 (23000): Column 'sname' cannot be null */

 4. UPDATE hss_electives SET cid = NULL WHERE cid = 'HS 211';

  /* ERROR 1048 (23000): Column 'cid' cannot be null */

 5. UPDATE hss_electives SET cname = NULL WHERE cid = 'HS 245';

  /* ERROR 1048 (23000): Column 'cname' cannot be null */

TASK 06 :-
1. DELETE FROM hss_electives WHERE cid = 'HS 225';

2. DELETE FROM hss_electives WHERE sname LIKE '%Ajay%';

TASK 07 :-
 1. LOAD DATA LOCAL INFILE 'D:/HS225.csv' 
    INTO TABLE hss_electives
    FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' ; 

 2. LOAD DATA LOCAL INFILE 'D:/ajay.csv' 
    INTO TABLE hss_electives
    FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' ;

TASK 08 :-
  /* Warning 1062 :- Duplicate entry '180107005' for key 'hss_electives.PRIMARY'*/

  /* A common Ajay exists in 'ajay.csv' and 'HS225.csv' so we get the 
    duplicate warning when we are loading the file */ 

 /* the warning is thrown as I was inserting '180107005' in column roll_number.
    Column roll_number has '18010700' before and it has primary key constraint, 
    which must be unique. Therefore it can't contain duplicate values. */  

TASK 09 :-
1.  ALTER TABLE hss_electives DROP PRIMARY KEY;
    
2. INSERT INTO hss_electives(roll_number,sname,cid,cname) VALUES
 (180123001,'Aditi Bihade','HS 225',
 'Inventing the Truth: The Art and Craft of Autobiography'); 

3. ALTER TABLE hss_electives ADD CONSTRAINT my_roll_number PRIMARY KEY(roll_number) ;

 /* ERROR 1062 (23000): Duplicate entry '180123001' for key 'hss_electives.PRIMARY' */

4. INSERT INTO hss_electives(roll_number,sname,cid,cname) VALUES
   (180123001,'Aditi Bihade','HS 225',
   'Inventing the Truth: The Art and Craft of Autobiography');

TASK 10 :-
 LOAD DATA LOCAL INFILE 'D:/old-hss-electives-allotment.csv' 
 INTO TABLE hss_electives
 FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n'  
 IGNORE 1 ROWS;

TASK 11 :-
1. SELECT cid FROM hss_electives; 

2. SELECT * FROM hss_electives WHERE roll_number LIKE '1701010%' OR 
   roll_number LIKE '1801010%' OR roll_number LIKE '190101%' OR 
   roll_number LIKE '1701230%' OR roll_number LIKE '1801230%'
   OR roll_number LIKE '1901230%' ;

3. SELECT * FROM hss_electives WHERE (roll_number LIKE '170123%' OR 
   roll_number LIKE '180123%' OR roll_number LIKE '190123%') AND
   cname = 'Sociological Perspectives on Modernity';

4. SELECT DISTINCT (cid) , cname FROM hss_electives ;

5. SELECT cid, cname FROM hss_electives ORDER BY cname DESC;
      /* for ALL */

   SELECT DISTINCT (cid), cname FROM hss_electives ORDER BY cname DESC;
      /* for DISTINCT */

6. SELECT sname FROM hss_electives WHERE cname ='Human Resource Management' 
   ORDER BY sname, roll_number;    

   

