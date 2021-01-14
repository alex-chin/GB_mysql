# 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
#     который больше всех общался с выбранным пользователем (написал ему сообщений).
# 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
# 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

# 1. С учетом строго "написал ему сообщений"

# 1 вариант с LIMIT
SET @ID_USER = 1;
SELECT COUNT(*) num_mes, from_user_id
from messages
WHERE to_user_id = @ID_USER
GROUP BY from_user_id
ORDER BY num_mes DESC
LIMIT 1;

# 2 вариант cо вложенными запросами
SET @ID_USER = 1;
SELECT MAX(num_mes)
FROM (
         SELECT COUNT(*) num_mes
         from messages
         WHERE to_user_id = @ID_USER
         GROUP BY from_user_id
         ORDER BY num_mes DESC) as mnm;


# 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
SELECT COUNT(*) num_likes_teen
FROM likes
WHERE user_id in (
    SELECT user_id
    FROM profiles
    WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <= 10);


# 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

# данные из БД
SELECT gender, COUNT(*) num_gender
from (
         SELECT (select gender from profiles where likes.user_id = profiles.user_id) gender
         FROM likes) as lg
GROUP BY gender
ORDER BY num_gender DESC
LIMIT 1;

# расшифровка данных по условию задачи
SELECT CASE (gender)
           WHEN 'm' THEN 'мужчины'
           WHEN 'f' THEN 'женщины'
           END AS gender,
       COUNT(*)   num_gender
from (
         SELECT (select gender from profiles where likes.user_id = profiles.user_id) gender
         FROM likes) as lg
GROUP BY gender
ORDER BY num_gender DESC
LIMIT 1;

# исключение числового столбца
SELECT gender from(
SELECT CASE (gender)
           WHEN 'm' THEN 'мужчины'
           WHEN 'f' THEN 'женщины'
           END AS gender,
       COUNT(*)   num_gender
from (
         SELECT (select gender from profiles where likes.user_id = profiles.user_id) gender
         FROM likes) as lg
GROUP BY gender
ORDER BY num_gender DESC
LIMIT 1) as gng;
