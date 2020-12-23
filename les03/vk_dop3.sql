/* 3. Написать крипт, добавляющий в БД vk, которую создали на занятии, 
   3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)*/
/*
 * Дополнительно создаются две сущности: событие и тег
 * Событие - событие (events) привязанное к дате, локации и посту в соцсети
 *  Владельцем события является пользователь
 * 	События можно размещать в календаре пользователя (calendar_user)
 * 
 * Тег - метка для поста (media) , которая позволяет быстро отобрать посты по определенной теме.
 * 	Теги в сети устанавливает администратор
 * */

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
	code CHAR(6) NOT NULL PRIMARY KEY COMMENT 'код тега, натуральный ключ'
) COMMENT 'Теги для быстрого поиска';

DROP TABLE IF EXISTS tags_media;
CREATE TABLE tags_media (
	code CHAR(6) NOT NULL COMMENT 'код тега, натуральный ключ',
	media_id BIGINT(10) UNSIGNED NOT NULL,  
  	PRIMARY KEY (code, media_id), -- два одинаковых тега для одной публикации недопустимы
  	KEY media_id (media_id),
  	-- KEY code (code),
    FOREIGN KEY (code) REFERENCES tags (code), -- справочник по тегам
    FOREIGN KEY (media_id) REFERENCES media (id) -- теги для публикации
) COMMENT 'Теги на медиа для быстрого поиска';

DROP TABLE IF EXISTS events;
CREATE TABLE events (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	event_datetime DATETIME NOT NULL,
	event_date DATE COMMENT 'Для операций с календарем', -- возможно будет вычисляться из event_date, решить на этапе реализации
	coord POINT COMMENT 'Коодинаты события',
  	KEY (event_date),
    FOREIGN KEY (user_id) REFERENCES users (id), -- создатель события
    FOREIGN KEY (media_id) REFERENCES media (id) -- описание события
) COMMENT 'События привязанные к локации и времени'; 

DROP TABLE IF EXISTS calendar_user;
CREATE TABLE calendar_user (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE, -- владелец календаря
	event_id BIGINT UNSIGNED NOT NULL, -- событие в календаре
  	PRIMARY KEY (user_id, event_id),
	FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (event_id) REFERENCES events (id)
) COMMENT 'События в календаре пользователя';


