DROP DATABASE IF EXISTS issec;
CREATE DATABASE issec DEFAULT CHARACTER SET 'utf8';
USE issec;

create table organisation
(
    name        varchar(255) null,
    short_name  varchar(255) null,
    address     varchar(255) null,
    inn         char(20)     not null,
    is_executor bit default 0

)
    comment 'Организация';

