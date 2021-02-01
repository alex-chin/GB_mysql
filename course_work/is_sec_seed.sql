#
# GeekUniversity. Факультет Искусственного интеллекта. 676 группа.
# Александр Клянчин
#
# Проект по курсу "Основы реляционных баз данных. MySQL"
#
# 2021 г.
# #################################################################
#
# Описание базы данных
#
# Учет проектной деятельности предприятия по защите информационных систем заказчика в соответствии
# с требованиями регуляторов
#
# Система позволяет осуществлять учет данных по проектам. Основные сущности:
# - Информационная система (адреса, рабочие места, устройства)
# - Организация - владелец ИС
# - Организация - производитель работ по заците
# - Сотрудники организаций, занятых на проекте
# - Выполнение мер по защите в ИС
#
# В соответсвии с введенными данными возможно получение разнообразных справок и отчетов по проектам.
# А также автоматическая генерация необходимой документации по шаблонам
#
#  Состав курсового проекта:
# 1. Скрипт создания структуры БД - is_sec_seed.sql
# 2. Логическая структура БД - is_sec_logical.png
# 3. Физическая структура БД - is_sec_physical.png


DROP DATABASE IF EXISTS issec;
CREATE DATABASE issec DEFAULT CHARACTER SET 'utf8';
USE issec;

drop table if exists photos;
create table photos
(
    id           serial primary key,
    site_id      bigint unsigned null comment 'скриншот испытаний на площадке',
    workplace_id bigint unsigned null comment 'скриншот испытаний на рабочем месте',
    is_logo      bit default 0 comment 'логотип для использования в документах',
    file_name    char(200)       not null
)
    comment 'фотографии: лого, скриншоты испытаний';

drop table if exists organizations;
create table organizations
(
    id          SERIAL PRIMARY KEY,
    photo_id    bigint unsigned null comment 'лого',
    name        varchar(255)    null,
    short_name  varchar(255)    null,
    address     varchar(255)    null,
    inn         char(20)        not null,
    is_executor bit default 0 comment '1 - Организация внедряющая систему защиты информации'
)
    comment 'Организация';

create unique index organizations_inn_index
    on organizations (inn);

create unique index organizations_short_name_index
    on organizations (short_name);

drop table if exists persons;
create table persons
(
    id              serial primary key,
    organization_id bigint unsigned   not null,
    name_full       varchar(255)      null,
    name_short      varchar(255)      null,
    position        varchar(255)      null comment 'должность',
    phone           varchar(255)      null,
    email           varchar(255)      null,
    position_sign   varchar(255)      null comment 'должность при подписании',
    is_chairman     bit default false null comment 'председатель',
    is_member       bit default false null comment 'член комиссии',
    is_agreement    bit default false null comment 'согласующий',
    is_approval     bit default false null comment 'утверждающий'
)
    comment 'Сотрудник организации';

drop table if exists infosystems;
create table infosystems
(
    id                     serial primary key,
    organization_id        bigint unsigned   not null comment 'Организация владелец',
    executor_org_id        bigint unsigned   null comment 'Организация исполнитель по проекту защиты',
    name                   varchar(255)      null,
    short_name             varchar(255)      null,
    is_one_site            bit default true  null comment 'один адрес',
    is_ispdn               bit               null comment 'система обработки персональных данных',
    ispdn_lev              int               null comment 'Уровень_Защищенности',
    is_gis                 bit               null comment 'государственная информационная система',
    gis_class              int               null comment 'Класс_Защищенности',
    is_as                  bit               null comment 'АС',
    as_class               int               null comment 'Класс_Защищенности',
    date_agreement         date              null comment 'дата согласования',
    date_approval          date              null comment 'дата утверждения',
    is_att_before          bit default false not null comment 'проводилась аттестация',
    before_name            varchar(255)      null,
    before_date            date              null,
    before_num_attestation varchar(255)      null,
    reg_number             varchar(255)      null comment 'учетный номер'
)
    comment 'Информационная система';

create index infosystems_short_name_index
    on infosystems (short_name);

drop table if exists sites;
create table sites
(
    id             serial primary key,
    infosystems_id bigint unsigned,
    address        varchar(266)

)
    comment 'Площадка, здание, адрес местоположения ИС';

drop table if exists work_places;
create table work_places
(
    id      serial primary key,
    site_id bigint unsigned not null,
    name    varchar(255)
)
    comment 'АРМ, Компьютер в сборе, периферия, стойка';

drop table if exists units;
create table units
(
    id             serial primary key,
    work_places_id bigint unsigned not null,
    type_code      char(20)        not null,
    name           varchar(255),
    part_num       char(100)
)
    comment 'отдельное устройство: монитор, системный блок, коммутатор';

drop table if exists type_it;
create table type_it
(
    code char(20) primary key
)
    comment 'типы устойств ит';

drop table if exists measures;
create table issec.measures
(
    id            serial primary key,
    part          int      null,
    order_service char(15) null comment 'документ регулятора',
    code          char(6)  null,
    description   text     null,
    div4          bit      null,
    div3          bit      null,
    div2          bit      null,
    div1          bit      null

)
    comment 'меры информационной безопасности по документам регулятора';

create index measures_code_index
    on measures (code);

drop table if exists measures_infosystems;
create table measures_infosystems
(
    primary key (id_measures, id_infosystems),
    id_measures    bigint unsigned not null,
    id_infosystems bigint unsigned not null
)
    comment 'меры которые выполняются в информационной системе';

create table templates
(
    id          serial primary key,
    name        char(20),
    description varchar(255),
    file_name   char(200) not null
)
    comment 'шаблон документа';

drop table if exists documents;
create table documents
(
    id             serial primary key,
    id_infosystems bigint unsigned not null,
    id_templates   bigint unsigned not null,
    file_name      char(200)       not null,
    created_at     timestamp default CURRENT_TIMESTAMP
)
    comment 'документ сгенерированный по шаблону для инф системы ';

alter table documents
    add constraint documents_infosystems_fk
        foreign key (id_infosystems) references infosystems (id);

alter table documents
    add constraint documents_templates_fk
        foreign key (id_templates) references templates (id);

alter table photos
    add constraint photos_sites_fk
        foreign key (site_id) references sites (id);

alter table photos
    add constraint photos_work_places_fk
        foreign key (workplace_id) references work_places (id);

alter table organizations
    add CONSTRAINT organizations_photos_fk
        FOREIGN KEY (photo_id) REFERENCES photos (id);

alter table persons
    add constraint persons_organizations_fk
        foreign key (organization_id) references organizations (id);

alter table infosystems
    add constraint infosystems_organizations_fk
        foreign key (organization_id) references organizations (id);

alter table infosystems
    add constraint infosystems_organizations_exe_fk
        foreign key (executor_org_id) references organizations (id);

alter table sites
    add constraint sites_infosystems_fk
        foreign key (infosystems_id) references infosystems (id);

alter table work_places
    add constraint work_places_sites_fk
        foreign key (site_id) references sites (id);

alter table units
    add constraint units_sites_fk
        foreign key (work_places_id) references work_places (id);

alter table units
    add constraint units_type_it_code_fk
        foreign key (type_code) references type_it (code);


alter table measures_infosystems
    add constraint measures_infosystems_infosystems_id_fk
        foreign key (id_infosystems) references infosystems (id);

alter table measures_infosystems
    add constraint measures_infosystems_measures_id_fk
        foreign key (id_measures) references measures (id);





