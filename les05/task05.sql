# У рок 5. Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
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

# Вспомогательные поля
ALTER TABLE users
    ADD created_at_temp VARCHAR(20);
ALTER TABLE users
    ADD updated_at_temp VARCHAR(20);

#  генерация символьных полей через реальные
UPDATE vk.users
SET vk.users.created_at_temp = DATE_FORMAT(created_at, '%d.%m.%Y %h:%i'),
    vk.users.updated_at_temp = DATE_FORMAT(created_at, '%d.%m.%Y %h:%i');

# обнуление полей
UPDATE vk.users
SET updated_at =NULL,
    created_at=NULL;

# восстановление полей
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
