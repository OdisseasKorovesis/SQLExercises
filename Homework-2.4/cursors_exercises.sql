-- 1st exercise
use eshopschema_new;

delimiter $$
create procedure getCityName(in in_state_id int, inout name_list varchar(1000))
begin
declare c_name varchar(50) default '';
declare done boolean default false;

declare cur_city cursor for
select city_name from exercise_table
where state_id = in_state_id;

declare continue handler for not found set done = true;

open cur_city;
	cityLoop : loop
	fetch cur_city into c_name;
	if done then
		leave cityloop;
	end if;
	set name_list = Concat(c_name, ', ', name_list );
end loop cityloop;
close cur_city;
end $$
delimiter ; 

set @name_list = "";
call getCityName(1, @name_list);
select @name_list;

drop procedure getcityname;

-- 2nd exercise
use sakila;

delimiter $$
create procedure assignDataToNewTable()
begin

declare customer_done boolean default false;
declare c_full_name varchar(100);
declare  c_address_id int;

declare cur_customer cursor for
select Concat(first_name, ' ', last_name) as FullName, address_id from customer
where active = 1;

declare continue handler for not found set customer_done = true;

open cur_customer;
customer_loop : loop
fetch from cur_customer into c_full_name, c_address_id;
if customer_done then
	leave customer_loop;
end if;

	block2: begin
    declare address_done boolean default false;
    declare  c_address varchar(50);
    
    declare cur_address cursor for
    select address from address
    where address_id = c_address_id;
    
    declare continue handler for not found set address_done = true;
    
    open cur_address;
    address_loop : loop
    fetch from cur_address into c_address;
    if address_done then
		set address_done = false;
        leave address_loop;
	end if;
    insert into new_table(FullName, Address) values (c_full_name, c_address);
    end loop address_loop;
    close cur_address;
    end block2;
end loop customer_loop;
close cur_customer;
end $$
delimiter ;

call assignDataToNewTable();
drop procedure assignDataToNewTable;

