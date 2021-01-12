# 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
#     который больше всех общался с выбранным пользователем (написал ему сообщений).
# 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
# 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

# 1. С учетом строго "написал ему сообщений"

SET @ID_USER = 1;
SELECT COUNT(*) num_mes, from_user_id
FROM messages
WHERE to_user_id = @ID_USER
GROUP BY from_user_id
ORDER BY num_mes DESC
LIMIT 1;

# 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10;