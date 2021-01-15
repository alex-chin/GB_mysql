# Урок 5.
#
# Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
#
# 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными.
# Заполните их текущими датой и временем.
# 2. Таблица users была неудачно спроектирована.
# Записи created_at и updated_at были заданы типом VARCHAR
# и в них долгое время помещались значения в формате "20.10.2017 8:10".
# Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
# 3. В таблице складских запасов storehouses_products в поле value могут встречаться
# самые разные цифры: 0, если товар закончился и выше нуля,
# если на складе имеются запасы. Необходимо отсортировать записи таким образом,
# чтобы они выводились в порядке увеличения значения value.
#   Однако, нулевые запасы должны выводиться в конце, после всех записей.
# 4. (по желанию) Из таблицы users необходимо извлечь пользователей,
#  родившихся в августе и мае. Месяцы заданы в виде списка английских названий
#  ('may', 'august')
# 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
# SELECT * FROM catalogs WHERE id IN (5, 1, 2); О
# тсортируйте записи в порядке, заданном в списке IN.
#
# Практическое задание теме “Агрегация данных”
# 1. Подсчитайте средний возраст пользователей в таблице users
# 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
#    Следует учесть, что необходимы дни недели текущего года, а не года рождения.
# 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы


# 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными.
# Заполните их текущими датой и временем.
# ALTER TABLE users
#     ADD created_at DATETIME;
# ALTER TABLE users
#     ADD updated_at DATETIME;

UPDATE vk.users
SET created_at = NOW(),
    updated_at = NOW();

# 2. Таблица users была неудачно спроектирована.
# Записи created_at и updated_at были заданы типом VARCHAR
# и в них долгое время помещались значения в формате "20.10.2017 8:10".
# Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

# Подготовка таблицы под вариант, описанный в задаче.
# Вспомогательные поля
ALTER TABLE users
    ADD created_at_temp VARCHAR(20);
ALTER TABLE users
    ADD updated_at_temp VARCHAR(20);

#  генерация символьных полей через реальные
UPDATE vk.users
SET vk.users.created_at_temp = DATE_FORMAT(created_at, '%d.%m.%Y %h:%i'),
    vk.users.updated_at_temp = DATE_FORMAT(created_at, '%d.%m.%Y %h:%i');

# фактическое преобразование полей
UPDATE vk.users
SET updated_at = STR_TO_DATE(vk.users.updated_at_temp, "%d.%m.%Y %h:%i"),
    created_at = STR_TO_DATE(vk.users.created_at_temp, "%d.%m.%Y %h:%i")
WHERE TRUE;

# 3. В таблице складских запасов storehouses_products в поле value могут встречаться
# самые разные цифры: 0, если товар закончился и выше нуля,
# если на складе имеются запасы. Необходимо отсортировать записи таким образом,
# чтобы они выводились в порядке увеличения значения value.
#   Однако, нулевые запасы должны выводиться в конце, после всех записей.

INSERT INTO shop.storehouses_products (storehouse_id, product_id, value)
VALUES (1, 1, 0),
       (1, 2, 2500),
       (1, 3, 0),
       (1, 4, 30),
       (1, 5, 500),
       (1, 6, 1);

# создание отдельного поля для коррекции сортировки
SELECT product_id, value, IF(value = 0, 1, 0) is_zero
FROM storehouses_products
ORDER BY is_zero, value;

# 4. (по желанию) Из таблицы users необходимо извлечь пользователей,
#  родившихся в августе и мае. Месяцы заданы в виде списка английских названий
#  ('may', 'august')

select user_id, birthday
from profiles
WHERE LOWER(DATE_FORMAT(birthday, '%M')) in ('may', 'august');


# 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
# SELECT * FROM catalogs WHERE id IN (5, 1, 2);
# Отсортируйте записи в порядке, заданном в списке IN.

SELECT *
FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY FIND_IN_SET(id, '5,1,2');

# 1. Подсчитайте средний возраст пользователей в таблице users

SELECT AVG((SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE user_id = users.id)) med_old
FROM users;

# 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
#    Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT dw, COUNT(dw)
FROM (
         SELECT birthday,
                DAYOFWEEK(STR_TO_DATE(CONCAT(month(birthday), '/', DAY(birthday), '/', YEAR(NOW())), '%m/%d/%Y')) dw
         FROM profiles) as bd
GROUP BY dw;

# 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы

create table Num_series
(
    num int null
);

INSERT INTO Num_series (num) VALUES (1);
INSERT INTO Num_series (num) VALUES (2);
INSERT INTO Num_series (num) VALUES (3);
INSERT INTO Num_series (num) VALUES (4);
INSERT INTO Num_series (num) VALUES (5);

SELECT ROUND(EXP(SUM(LOG(num))),1)
FROM Num_series;

select max(sum)
from
(
  select @sum := @sum * num as sum
  from Num_series
  cross join (select @sum := 1) s
) tmp