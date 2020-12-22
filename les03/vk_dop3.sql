/* 3. Написать крипт, добавляющий в БД vk, которую создали на занятии, 
   3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)*/

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
	code CHAR(6) NOT NULL PRIMARY KEY COMMENT 'код тега, натуральный ключ',
) COMMENT 'Теги для быстрого поиска';

DROP TABLE IF EXISTS tags_media;
CREATE TABLE tags_media (
	code CHAR(6) NOT NULL PRIMARY KEY COMMENT 'код тега, натуральный ключ',
	media_id BIGINT(10) UNSIGNED NOT NULL,  
  	PRIMARY KEY (code, media_id),
  	KEY media_id (media_id),
    FOREIGN KEY (code) REFERENCES tags(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
  	
) COMMENT 'Теги на медиа для быстрого поиска';

DROP TABLE IF EXISTS events;
CREATE TABLE events (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	event_date DATETIME,
	


) COMMENT 'События привязанные к локации и времени' 


