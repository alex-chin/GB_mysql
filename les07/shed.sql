DROP DATABASE IF EXISTS shed;
CREATE DATABASE shed DEFAULT CHARACTER SET 'utf8';
USE shed;
SET NAMES 'utf8';

DROP TABLE IF EXISTS flights;
CREATE TABLE flights
(
    id     SERIAL PRIMARY KEY,
    `from` CHAR(20),
    `to`   CHAR(20)
);

INSERT INTO flights
VALUES (NULL, 'moscow', 'omsk'),
       (NULL, 'novgorod', 'kazan'),
       (NULL, 'irkutsk', 'moscow'),
       (NULL, 'omsk', 'irkutsk'),
       (NULL, 'moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities
(
    label CHAR(20),
    name  CHAR(20)
);

INSERT INTO cities
VALUES ('moscow', 'Москва'),
       ('irkutsk', 'Иркутск'),
       ('novgorod', 'Новгород'),
       ('kazan', 'Казань'),
       ('omsk', 'Омск');
