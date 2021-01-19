# Практическое задание по теме “Транзакции, переменные, представления”
#
#   1.1 В базе данных shop и sample присутствуют одни и те же таблицы,
#  учебной базы данных. Переместите запись id = 1 из таблицы shop.users
#  в таблицу sample.users. Используйте транзакции.
#   1.2 Создайте представление, которое выводит название name товарной позиции
#  из таблицы products и соответствующее название каталога name из таблицы catalogs.
#   1.3 (по желанию) Пусть имеется таблица с календарным полем created_at.
#  В ней размещены разряженые календарные записи за август 2018 года
#  '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
#  Составьте запрос, который выводит полный список дат за август,
#  выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0,
#  если она отсутствует.
#   1.4 (по желанию) Пусть имеется любая таблица с календарным полем created_at.
#  Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей
#
# Практическое задание по теме “Администрирование MySQL”  (эта тема изучается по вашему желанию)
#
# 2.1 Создайте двух пользователей которые имеют доступ к базе данных shop.
# Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
# второму пользователю shop — любые операции в пределах базы данных shop.
# 2.2 (по желанию) Пусть имеется таблица accounts содержащая три столбца
# id, name, password, содержащие первичный ключ, имя пользователя и его пароль.
# Создайте представление username таблицы accounts, предоставляющий доступ к столбца
# id и name. Создайте пользователя user_read, который бы не имел доступа к таблице
# accounts, однако, мог бы извлекать записи из представления username.
#
#  Практическое задание по теме “Хранимые процедуры и функции, триггеры"
#
# 3.1 Создайте хранимую функцию hello(), которая будет возвращать приветствие,
# в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать
# фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
# с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
#
#   1.1 В базе данных shop и sample присутствуют одни и те же таблицы,
#  учебной базы данных. Переместите запись id = 1 из таблицы shop.users
#  в таблицу sample.users. Используйте транзакции.
#
# Подготовка

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample DEFAULT CHARACTER SET 'utf8';
USE sample;
SET NAMES 'utf8';

create table users
(
    id          bigint unsigned auto_increment,
    name        varchar(255)                       null comment 'Имя покупателя',
    birthday_at date                               null comment 'Дата рождения',
    created_at  datetime default CURRENT_TIMESTAMP null,
    updated_at  datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint id
        unique (id)
)
    comment 'Покупатели';

alter table users
    add primary key (id);

START TRANSACTION;

INSERT INTO sample.users
SELECT *
FROM shop.users
WHERE id = 1;

DELETE
FROM shop.users
WHERE id = 1;

COMMIT;


#   1.2 Создайте представление, которое выводит название name товарной позиции
#  из таблицы products и соответствующее название каталога name из таблицы catalogs.
#

USE shop;

CREATE OR REPLACE VIEW product_short AS
SELECT p.name product_name, c.name catalog_name
FROM products p
         JOIN catalogs c on c.id = p.catalog_id;

SELECT *
from product_short;

#   1.3 (по желанию) Пусть имеется таблица с календарным полем created_at.
#  В ней размещены разряженые календарные записи за август 2018 года
#  '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
#  Составьте запрос, который выводит полный список дат за август,
#  выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0,
#  если она отсутствует.

# иммитация таблицы
CREATE OR REPLACE VIEW calend AS
SELECT *
FROM products
WHERE YEAR(created_at) = 2018;

SELECT *
FROM calend;


SELECT d2 * 10 + d1 as day
from (select 0 d1
      union
      select 1
      union
      select 2
      union
      select 3
      union
      select 4
      union
      select 5
      union
      select 6
      union
      select 7
      union
      select 8
      union
      select 9) cal,
     (select 0 d2 union select 1 union select 2 union select 3) cal2
WHERE (d2 * 10 + d1) <= 31 and (d2 * 10 + d1) > 0
order by day;

