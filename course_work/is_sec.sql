DROP DATABASE IF EXISTS issec;
CREATE DATABASE issec DEFAULT CHARACTER SET 'utf8';
USE issec;

drop table if exists organizations;
create table organizations
(
    id          SERIAL PRIMARY KEY,
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
    is_chairman     tinyint(1) default 0 not null comment 'председатель',
    is_member       tinyint(1) default 0 not null comment 'член комиссии',
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
    is_gis                 bit                  null comment 'государственная информац система',
    gis_class              int                  null comment 'Класс_Защищенности',
    is_as                  bit                  null comment 'АС',
    as_class               int                  null comment 'Класс_Защищенности',
    date_agreement         date                 null comment 'дата согласования',
    date_approval          date                 null comment 'дата утверждения',
    reg_number             varchar(255)         null comment 'учетный номер',
    organization_id        bigint unsigned      not null,
    attestation_org_id     bigint unsigned      not null
)
    comment 'Информационная система';

drop table if exists sites;
create table sites
(
    id      serial primary key,
    address varchar(266)

) comment 'Площадка, здание, адрес местоположения ИС';

