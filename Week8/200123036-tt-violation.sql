--TASK 3.1
delimiter //  
create procedure tt_violation()
begin   
  create table X as (select temp1.roll_number, temp1.name, 
  temp1.cid as cid1, temp2.cid as cid2 from cwsl as temp1 
  inner join cwsl as temp2 on ( (temp1.roll_number = 
  temp2.roll_number) and (temp1.cid != temp2.cid)));
  select * from X where exists
  (select * from (ett as temp1 inner join ett as temp2 on 
  (temp1.cid = cid1) and (temp2.cid = cid2) and (temp1.cid < temp2.cid))
  where (temp1.exam_date = temp2.exam_date) and not
  ((temp1.end_time < temp2.start_time or temp2.end_time < temp1.start_time)));
end ;//
delimiter ;   


