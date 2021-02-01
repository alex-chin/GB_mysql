use issec;

drop procedure if exists applying_measure;
delimiter //
# процедура формирует начальный массив мер для ИС
# в зависимости от требования регулятора и класса ИС
create procedure applying_measure(IN id_infosystem bigint, IN order_service int, IN div_num int)
begin
    declare str_order char(15);
    delete from measures_infosystems m where m.id_infosystems = id_infosystem;
    set str_order = concat('%', order_service);

    insert into measures_infosystems (id_infosystems, id_measures)
    select id_infosystem, id
    from measures m
    where m.order_service like str_order
      and ((div_num = 1 and div1) or
           (div_num = 2 and div2) or
           (div_num = 3 and div3) or
           (div_num = 4 and div4));
end //

delimiter ;

call applying_measure(1, 17, 1);
