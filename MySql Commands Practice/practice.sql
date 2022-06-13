/*
drop function if exists f1;
delimiter $
create function f1() returns varchar(100)
deterministic
begin
declare x varchar(100) default "Hello World";
call p1(x);
return x;
end $
delimiter;

drop procedure if exists p1;
delimiter $
craete procedure p
 */
 
 drop trigger if exists tr1;
 delimiter $
 create trigger tr1 after insert on dept for each row
 begin 
       insert into d1 values (new.deptno,new.dname,new.loc,new.pwd);
end $
	delimiter ;
     