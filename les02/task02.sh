
# Практическое задание по теме “Управление БД”
# 1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль,
# который указывался при установке.
# 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов,
# числового id и строкового name.
# 3. Создайте дамп базы данных example из предыдущего задания,
# разверните содержимое дампа в новую базу данных sample.
# 4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump.
# Создайте дамп единственной таблицы help_keyword базы данных mysql.
# Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

# 1.1 СУБД MySQL установлена
alex@alex-E420s:~$ systemctl status mysql
● mysql.service - MySQL Community Server
     Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2020-12-12 15:17:13 MSK; 1 weeks 1 days ago
   Main PID: 1035 (mysqld)
     Status: "Server is operational"
      Tasks: 40 (limit: 9379)
     Memory: 25.0M
     CGroup: /system.slice/mysql.service
             └─1035 /usr/sbin/mysqld

дек 12 15:17:09 alex-E420s systemd[1]: Starting MySQL Community Server...
дек 12 15:17:13 alex-E420s systemd[1]: Started MySQL Community Server.

# 1.2 Файл параметров .my.cnf настроен
alex@alex-E420s:~$ cat .my.cnf
[mysql]
user=root
password=
alex@alex-E420s:~$
alex@alex-E420s:~$ mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 40
Server version: 8.0.22-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>

# 2 Создание БД example и таблицы users

mysql> CREATE DATABASE example;
Query OK, 1 row affected (0.02 sec)

mysql> USE example
Database changed
mysql> CREATE TABLE users (id BIGINT, name CHAR(20));
Query OK, 0 rows affected (0.16 sec)

mysql> describe users;

+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | bigint   | YES  |     | NULL    |       |
| name  | char(20) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
2 rows in set (0.02 sec)

# 3.1 Создание дампа базы данных example

alex@alex-E420s:~/Projects/GeekBrAI2020/gb_mqsql$ mysqldump -u root -p example > example.sql
Enter password:
alex@alex-E420s:~/Projects/GeekBrAI2020/gb_mqsql$

# 3.2 Развертывание дампа в новую базу данных sample.

alex@alex-E420s:~/Projects/GeekBrAI2020/gb_mqsql$ mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 46
Server version: 8.0.22-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE sample;
Query OK, 1 row affected (0.02 sec)

mysql> \u sample
Database changed
mysql> \. example.sql
Query OK, 0 rows affected (0.01 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> SHOW TABLES;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0.00 sec)

mysql> DESCRIBE users;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | bigint   | YES  |     | NULL    |       |
| name  | char(20) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
2 rows in set (0.01 sec)

# 4. Создать дамп единственной таблицы help_keyword базы данных mysql.
# --extended-insert=FALSE каждая запись на одной строке
# --where="true limit 100" true для согласования синтаксиса 'where true'
vagrant@homestead:~$ mysqldump --extended-insert=FALSE --where="true limit 100" mysql help_keyword > mysql.sql
# фильтр на каждую запись, считать только строки
vagrant@homestead:~$ cat  mysql.sql | grep INSERT | wc --lines
100






