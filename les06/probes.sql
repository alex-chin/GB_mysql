SELECT user_id, birthday
FROM profiles
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <= 10
ORDER BY birthday;

SELECT *, (select birthday from profiles where likes.user_id = profiles.user_id) bd
FROM likes
ORDER BY bd;
