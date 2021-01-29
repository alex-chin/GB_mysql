DROP DATABASE IF EXISTS issec;
CREATE DATABASE issec DEFAULT CHARACTER SET 'utf8';
USE issec;

drop table if exists organizations;
create table organizations
(
    id          SERIAL PRIMARY KEY,
    photo_id    bigint unsigned comment 'лого',
    name        varchar(255) null,
    short_name  varchar(255) null,
    address     varchar(255) null,
    inn         char(20)     not null,
    is_executor bit default 0 comment '1 - Организация внедряющая систему защиты информации'

)
    comment 'Организация';

drop table if exists persons;
create table persons
(
    id              serial primary key,
    organization_id bigint unsigned      not null,
#     created_at      timestamp            null,
#     updated_at      timestamp            null,
    name_full       varchar(255)         null,
    name_short      varchar(255)         null,
    position        varchar(255)         null comment 'должность',
    phone           varchar(255)         null,
    email           varchar(255)         null,
    position_sign   varchar(255)         null comment 'должность при подписании',
    is_chairman     bit        default 0 not null comment 'председатель',
    is_member       bit        default 0 not null comment 'член комиссии',
    is_agreement    tinyint(1) default 0 not null comment 'согласующий',
    is_approval     tinyint(1) default 0 not null comment 'утверждающий'
)
    comment 'Сотрудник организации';

drop table if exists infosystems;
create table infosystems
(
    id                     serial primary key,
    name                   varchar(255)         null,
    short_name             varchar(255)         null,
    is_one_site            bit        default 1 null comment 'один адрес',
    address                varchar(266),
    is_att_before          tinyint(1) default 0 not null comment 'проводилась аттестация',
    before_name            varchar(255)         null,
    before_date            date                 null,
    before_num_attestation varchar(255)         null,
    is_ispdn               bit                  null comment 'система обработки персональных данных',
    ispdn_lev              int                  null comment 'Уровень_Защищенности',
    is_gis                 bit                  null comment 'государственная информационная система',
    gis_class              int                  null comment 'Класс_Защищенности',
    is_as                  bit                  null comment 'АС',
    as_class               int                  null comment 'Класс_Защищенности',
    date_agreement         date                 null comment 'дата согласования',
    date_approval          date                 null comment 'дата утверждения',
    reg_number             varchar(255)         null comment 'учетный номер',
    organization_id        bigint unsigned      not null comment 'Организация владелец',
    executor_org_id        bigint unsigned      not null comment 'Организация исполнитель по проекту защиты'
)
    comment 'Информационная система';

drop table if exists sites;
create table sites
(
    id             serial primary key,
    infosystems_id bigint unsigned,
    address        varchar(266)

)
    comment 'Площадка, здание, адрес местоположения ИС';

drop table if exists photos;
create table photos
(
    id           serial primary key,
    site_id      bigint unsigned null comment 'скриншот испытаний на площадке',
    workplace_id bigint unsigned null comment 'скриншот испытаний на рабочем месте',
    is_logo      bit default 0 comment 'логотип для использования в документах',
    file_name    char(20)        not null
)
    comment 'фотографии: лого, скриншоты испытаний';

drop table if exists work_place;
create table work_place
(
    id      serial primary key,
    site_id bigint unsigned not null,
    name    varchar(255)
)
    comment 'АРМ, Компьютер в сборе, периферия, стойка';

drop table if exists unit;
create table unit
(
    id        serial primary key,
    site_id   bigint unsigned not null,
    type_code char(20)        not null,
    name      varchar(255),
    part_num  char(100)
)
    comment 'отдельное устройство: монитор, системный блок, коммутатор';

drop table if exists type_it;
create table type_it
(
    code char(20) primary key
)



