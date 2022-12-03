--TASK 3.2
delimiter // 
create procedure count_credits()
begin   
    select roll_number, name, SUM(credits) as total
    from (cwsl inner join cc on cwsl.cid = cc.cid) group by
    roll_number having SUM(credits) > 40;
end ;//
delimiter ;   