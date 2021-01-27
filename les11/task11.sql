# 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products
# в таблицу logs помещается время и дата создания записи, название таблицы,
# идентификатор первичного ключа и содержимое поля name.
#
# 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

# 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products
# в таблицу logs помещается время и дата создания записи, название таблицы,
# идентификатор первичного ключа и содержимое поля name.

drop table if exists log;
create table log
(
    date       datetime default now() not null,
    table_name char(25)               not null,
    id_table   bigint                 not null,
    name       varchar(255)           null
)
    comment 'архив' engine = ARCHIVE;

drop trigger if exists log_users_a_insert;
create trigger log_users_a_insert
    after insert
    on users
    for each row
begin
    insert into log (table_name, id_table, name)
    values ('users', NEW.id, NEW.name);
end;

drop trigger if exists log_catalogs_a_insert;
create trigger log_catalogs_a_insert
    after insert
    on catalogs
    for each row
begin
    insert into log (table_name, id_table, name)
    values ('catalogs', NEW.id, NEW.name);
end;

drop trigger if exists log_products_a_insert;
create trigger log_products_a_insert
    after insert
    on products
    for each row
begin
    insert into log (table_name, id_table, name)
    values ('products', NEW.id, NEW.name);
end;


# 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

INSERT INTO users (name)
select concat('Foo',n6.n, n5.n, n4.n, n3.n, n2.n, n1.n) as name from
              (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) as n1,
              (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) as n2,
              (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) as n3,
              (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) as n4,
              (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) as n5,
              (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) as n6;
