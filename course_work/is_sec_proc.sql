# 6. Скрипт создания хранимых процедур, функций, триггеров

use issec;

drop procedure if exists applying_measures;
delimiter //
# процедура формирует начальный массив мер для ИС
# в зависимости от требования регулятора и класса ИС
create procedure applying_measures(IN id_infosystem bigint, IN order_service int, IN div_num int)
begin
    delete from measures_infosystems where id_infosystems = id_infosystem;

    insert into measures_infosystems (id_infosystems, id_measures)
    select id_infosystem, id
    from measures m
    where m.order_service like concat('%', order_service)
      and ((div_num = 1 and div1) or
           (div_num = 2 and div2) or
           (div_num = 3 and div3) or
           (div_num = 4 and div4));
end //
delimiter ;

# дополнительно добавить к ссылочному списку меру
drop procedure if exists add_measure;
delimiter //
create procedure add_measure(IN id_infosystem bigint, IN order_service int, IN code char(6))
begin
    insert into measures_infosystems (id_infosystems, id_measures)
    select id_infosystem, id
    from measures m
    where m.order_service like concat('%', order_service)
      and m.code = code;
end //
delimiter ;

# удаление отдельных мер в ссылочном списке
drop procedure if exists del_measure;
delimiter //
create procedure del_measure(IN id_infosystem bigint, IN order_service int, IN code char(6))
begin
    delete mi
    from measures_infosystems mi
             left join measures m on mi.id_measures = m.id
    where m.order_service like concat('%', order_service)
      and m.code = code;
end //
delimiter ;

# преобразование текстового поля документ регулятора в числовой - выборка номера приказа
# order_num('Приказ  17') => 17
DROP FUNCTION IF EXISTS order_num;
DELIMITER //
create function order_num(order_service char(15)) returns int
begin
    RETURN substr(order_service, locate(' ', order_service));
end //
DELIMITER ;

# контроль привязки фото либо к рабочему месту, либо к адресу, либо это должно быть лого
DROP TRIGGER if exists check_link_photo_b_insert;
DELIMITER //
CREATE TRIGGER check_link_photo_b_insert
    BEFORE INSERT
    ON photos
    FOR EACH ROW
begin
    IF NEW.site_id IS NULL AND NEW.workplace_id IS NULL and (NEW.is_logo is null or NEW.is_logo = false) THEN
        SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT =
                'INSERT: One of "site" or "workplace" must be not NULL! Or it can be logo!';
    end if;
END //
DELIMITER ;

# контроль привязки фото либо к рабочему месту, либо к адресу, либо это должно быть лого
DROP TRIGGER if exists check_link_photo_b_update;
DELIMITER //
CREATE TRIGGER check_link_photo_b_update
    BEFORE update
    ON photos
    FOR EACH ROW
begin
    IF NEW.site_id IS NULL AND NEW.workplace_id IS NULL and (NEW.is_logo is null or NEW.is_logo = false) THEN
        SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT =
                'UPDATE: One of "site" or "workplace" must be not NULL! Or it can be logo!';
    end if;
END //
DELIMITER ;
