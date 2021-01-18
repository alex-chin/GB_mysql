# Тема “Сложные запросы”
# 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
# 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
# 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и
# таблица городов cities (label, name). Поля from, to и label содержат английские названия городов,
# поле name — русское. Выведите список рейсов flights с русскими названиями городов.

# 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
# Подготовка
INSERT INTO shop.orders (user_id, created_at, updated_at)
VALUES (1, '2021-01-18 09:25:55', '2021-01-18 09:25:55');
INSERT INTO shop.orders (user_id, created_at, updated_at)
VALUES (1, '2021-01-18 09:26:06', '2021-01-18 09:26:06');
INSERT INTO shop.orders (user_id, created_at, updated_at)
VALUES (2, '2021-01-18 09:26:30', '2021-01-18 09:26:30');
INSERT INTO shop.orders (user_id, created_at, updated_at)
VALUES (2, '2021-01-18 09:26:30', '2021-01-18 09:26:30');
INSERT INTO shop.orders (user_id, created_at, updated_at)
VALUES (2, '2021-01-18 09:26:30', '2021-01-18 09:26:30');
INSERT INTO shop.orders (user_id, created_at, updated_at)
VALUES (2, '2021-01-18 09:26:30', '2021-01-18 09:26:30');

# 1 вариант
SELECT DISTINCT u.name
FROM orders
         JOIN users u on u.id = orders.user_id;

# 2 вариант
SELECT DISTINCT name
from users
         join orders o on users.id = o.user_id;

# 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name, c.name
FROM products p
         LEFT JOIN catalogs c on c.id = p.catalog_id;


# 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и
# таблица городов cities (label, name). Поля from, to и label содержат английские названия городов,
# поле name — русское. Выведите список рейсов flights с русскими названиями городов.

# генерация бд в отдельном файле shed.sql

SELECT  f.id, c1.name, c2.name
from flights f
         LEFT JOIN cities c1 on f.`from` = c1.label
         LEFT JOIN cities c2 on f.`to` = c2.label
ORDER BY f.id;




