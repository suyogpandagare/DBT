/* drop procedure if exists pro1;
delimiter $
create procedure pro1()
begin
	select "Hello World"as "Message Box";
end $
delimiter ;




drop procedure if exists pro2;
delimiter $
create procedure pro2(p1 int , p2 int)
begin
	select p1 + p2 as "Message Box";
end $
delimiter ;




drop procedure if exists pro3;
delimiter $
create procedure pro3(in p1 int , in p2 int, out x int, out y int)
begin
	set x := p1 + p2;
	set y := p1 * p2;
end $
delimiter ;


drop procedure if exists pro4;
delimiter $
create procedure pro4(inout p1 int)
begin
	set p1 := p1 * 2;
end $
delimiter ;




drop procedure if exists Insert_Login;
delimiter $
create procedure Insert_Login(in para_userName varchar(20), in para_password varchar(20))
begin
	INSERT into Login(userName, password) values(para_userName, para_password);
end $
delimiter ;



drop procedure if exists Display_Login_Details;
delimiter $
create procedure Display_Login_details()
begin
	 select * from login;
end $
delimiter ;

*/

drop procedure if exists Display;
delimiter $
create procedure Display(in para_Message varchar(2000))
begin
	 select para_Message as "Message Box" ;
end $
delimiter ;

/*
drop procedure if exists Login_Validation;
delimiter $
create procedure Login_Validation(in para_userName varchar(20), in para_password varchar(20))
begin
	 declare flag bool default False;
	 SELECT true into flag  from login where userName = para_userName and password = para_password;
	 
	 if flag then
		call Display("Valid UserName");
	 else
		call Display("InValid UserName");
	 end if;
	 
end $
delimiter ;


drop procedure if exists Delete_Login;
delimiter $
create procedure Delete_Login(in para_userName varchar(20))
begin
	 declare flag bool default False;
	 SELECT true into flag  from login where userName = para_userName;
	 
	 if flag then
		delete from login where userName = para_userName;
		call Display("User deleted");
	 else
		call Display("User done not exists");
	 end if;
	 
end $
delimiter ;



drop function if exists f1;
delimiter $

create function f1() returns varchar(20)
deterministic
begin
	declare x varchar(20);
	select "Hello World" into x;
	return(x);
end $
delimiter ;



drop function if exists f2;
delimiter $

create function f2(x int, y int) returns int
deterministic
begin
	return(ifnull(x, 0) + ifnull(y, 0));
end $
delimiter ;


drop function if exists f3;
delimiter $
create function f3() returns int
deterministic
begin
	declare x int;
	declare cnt int;
	SET x := 0; 
	SET cnt := 0; 
	
	select count(*) into cnt from a;
	
	if cnt = 0 then
		return(1);
	else
		SELECT max(id) + 1 into x from a;
		return(x);
	end if;
end $
delimiter ;



drop procedure if exists pro5;
delimiter $
create procedure pro5()
begin
	declare x int default 1;
	loop_label:loop
		select x;
		SET x := x + 1;
		if x > 5 then
			leave loop_label;
		END IF;
		
	end loop loop_label;
end $
delimiter ;

drop procedure if exists pro6;
delimiter $
create procedure pro6()
begin
	create table a1(id int, ename varchar(20));
	
end $
delimiter ;



drop function if exists f4;
delimiter $

create function f4() returns varchar(20)	
deterministic
begin
	
	create table a2(id int, ename varchar(20));  // ERROR
	return("Table Created");
end $
delimiter ;




drop function if exists f5;
delimiter $
deterministic
create function f5() returns varchar(20)	
begin
	return("Table Created");     ERROR;
end $
delimiter ;



drop trigger if exists tr1;
delimiter $

create trigger tr1 before INSERT on dept for each row
begin
	insert into log(logData) values ('Record inserted in DEPT table!');
end $

delimiter ;



drop trigger if exists tr2;
delimiter $

create trigger tr2 before INSERT on dept for each row
begin
	insert into deptBK values(new.deptno, new.dname, new.loc, new.pwd, new.startedon, user(), curDate(), curtime());
end $

delimiter ;

*/


/*
drop procedure if exists pro7;
delimiter $
create procedure pro7(in para_dname varchar(20))
begin
	declare flag bool default false;
	
	select distinct true into flag from duplicate where dname=para_dname;
	
	if flag then
		delete from duplicate where dname=para_dname;
		call display("Record deleted");
	end if;
	
end $
delimiter ;



drop trigger if exists tr3;
delimiter $

create trigger tr3 before INSERT on dept for each row
begin
	declare x int default 0;
	select max(deptno) + 1 into x from dept;
	SET new.deptno := x;
	
end $

delimiter ;

*/

/*
mysql> insert into dept(dname,loc,pwd,startedon) values('Purchase','Baroda','brdxxy','02/02/2022');




drop procedure if exists pro8;
delimiter $
create procedure pro8()
begin
	declare exit handler for 1146 select 'Table not found';
	declare exit handler for 1062 select 'Duplicate Record';
	
	insert into dept values(1,10,10,10,10);
	select * from abc;
	select "hello";
end $
delimiter ;



drop trigger if exists tr4;
delimiter $

create trigger tr4 before DELETE on dept for each row
begin
		insert into deptBK values(old.deptno, old.dname, old.loc, old.pwd, old.startedon, user(), curDate(), curtime());
	
end $

delimiter ;




drop trigger if exists tr5;
delimiter $

create trigger tr5 before INSERT on dept for each row
begin
	if new.deptno > 80 then
		signal sqlstate '42000' SET message_text= "Invalaid DEPTNO...!";
	end if;
end $

delimiter ;


mysql> insert into dept values(81,1,1,1,1);



drop trigger if exists tr4;
delimiter $

create trigger tr4 after DELETE on dept for each row
begin
		insert into deptBK values(old.deptno, old.dname, old.loc, old.pwd, old.startedon, user(), curDate(), curtime());
	
end $

delimiter ;




*/



/*

mysql> insert into dept values(2,'purchase','surat','c',10,7000);

*/

/*

drop trigger if exists tr5;
delimiter $

create trigger tr5 before INSERT on dept for each row
begin
	SET new.dname := upper(new.dname);
	SET new.loc := upper(new.loc);
	
end $

delimiter ;

drop trigger if exists tr6;
delimiter $

create trigger tr6 before INSERT on dept for each row
begin
	if new.amount < 10000 then
		SET new.amount := 10000;
	end if;
	
end $

delimiter ;






mysql> insert into dept values(3,'abcd','mumbai','c',10,7000);

*/

drop procedure if exists pro9;
delimiter $
create procedure pro9()
begin
	declare _deptno int;
	declare _dname varchar(20);
	declare _loc varchar(20);
	declare _pwd varchar(20);
	declare _startedon varchar(20);
	
	
	
	declare c1 cursor for select * from dept;
	
	declare exit handler for 1329 call Display('No more records to fetch from the cursor!');
	
	open c1;
	lbl:loop
		fetch c1 into _deptno, _dname, _loc, _pwd, _startedon;
		
		select _deptno, _dname, _loc, _pwd, _startedon;
	
	end loop lbl;
	
	close c1;
	
end $
delimiter ;

/*

drop procedure if exists pro10;
delimiter $
create procedure pro10()
begin
	declare _deptno int;
	declare _dname varchar(20);
	declare _loc varchar(20);
	declare _pwd varchar(20);
	declare _startedon varchar(20);
	declare _amount int;
	
	declare c1 cursor for select * from dept;
	
	declare exit handler for 1329 call display('No more records to fetch from the cursor!');
	
	open c1;
	lbl:loop
		fetch c1 into _deptno, _dname, _loc, _pwd, _startedon, _amount;
		
		if  _deptno <=30 then
			insert into d values ( _deptno, _dname, _loc, _pwd, _startedon, _amount);
		end if;
	end loop lbl;
	close c1;
	
end $
delimiter ;


*/

/*
drop procedure if exists pro11;
delimiter $
create procedure pro11(in x int)
begin
	declare _deptno int;
	declare _dname varchar(20);
	declare _loc varchar(20);
	declare _pwd varchar(20);
	declare _startedon varchar(20);
	declare _amount int;
	declare x int default 1;
	
	declare c1 cursor for select * from dept;
	
	open c1;
	lbl:loop

		if x > 3 then
			leave lbl;
		end if;
		
		
		fetch c1 into _deptno, _dname, _loc, _pwd, _startedon, _amount;
		
		select _deptno, _dname, _loc, _pwd, _startedon, _amount;
		
		
		SET x := x + 1;
	
	end loop lbl;
	close c1;
	
end $
delimiter ;

*/

































