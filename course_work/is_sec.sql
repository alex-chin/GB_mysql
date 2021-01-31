DROP DATABASE IF EXISTS issec;
CREATE DATABASE issec DEFAULT CHARACTER SET 'utf8';
USE issec;

# drop table if exists photos;
create table photos
(
    id           serial primary key,
    site_id      bigint unsigned null comment 'скриншот испытаний на площадке',
    workplace_id bigint unsigned null comment 'скриншот испытаний на рабочем месте',
    is_logo      bit default 0 comment 'логотип для использования в документах',
    file_name    char(200)       not null
)
    comment 'фотографии: лого, скриншоты испытаний';

alter table photos
	add constraint photos_sites_id_fk
		foreign key (site_id) references sites (id);

alter table photos
	add constraint photos_work_place_id_fk
		foreign key (workplace_id) references work_place (id);


# drop table if exists organizations;
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

alter table organizations
    add CONSTRAINT `organizations_photo_fk` FOREIGN KEY (photo_id) REFERENCES photos (id);



# drop table if exists persons;
create table persons
(
    id              serial primary key,
    organization_id bigint unsigned      not null,
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

alter table persons
    add constraint persons_organizations_id_fk
        foreign key (organization_id) references organizations (id);


# drop table if exists infosystems;
create table infosystems
(
    id                     serial primary key,
    name                   varchar(255)    null,
    short_name             varchar(255)    null,
    is_one_site            bit default 1   null comment 'один адрес',
    address                varchar(266),
    is_att_before          bit default 0   not null comment 'проводилась аттестация',
    before_name            varchar(255)    null,
    before_date            date            null,
    before_num_attestation varchar(255)    null,
    is_ispdn               bit             null comment 'система обработки персональных данных',
    ispdn_lev              int             null comment 'Уровень_Защищенности',
    is_gis                 bit             null comment 'государственная информационная система',
    gis_class              int             null comment 'Класс_Защищенности',
    is_as                  bit             null comment 'АС',
    as_class               int             null comment 'Класс_Защищенности',
    date_agreement         date            null comment 'дата согласования',
    date_approval          date            null comment 'дата утверждения',
    reg_number             varchar(255)    null comment 'учетный номер',
    organization_id        bigint unsigned not null comment 'Организация владелец',
    executor_org_id        bigint unsigned not null comment 'Организация исполнитель по проекту защиты'
)
    comment 'Информационная система';

alter table infosystems
	add constraint infosystems_organizations__fk
		foreign key (organization_id) references organizations (id);

alter table infosystems
	add constraint infosystems_organizations_exe__fk
		foreign key (executor_org_id) references organizations (id);



# drop table if exists sites;
create table sites
(
    id             serial primary key,
    infosystems_id bigint unsigned,
    address        varchar(266)

)
    comment 'Площадка, здание, адрес местоположения ИС';

alter table sites
	add constraint sites_infosystems_id_fk
		foreign key (infosystems_id) references infosystems (id);

# drop table if exists work_place;
create table work_place
(
    id      serial primary key,
    site_id bigint unsigned not null,
    name    varchar(255)
)
    comment 'АРМ, Компьютер в сборе, периферия, стойка';

alter table work_place
	add constraint work_place_sites_id_fk
		foreign key (site_id) references sites (id);


# drop table if exists unit;
create table unit
(
    id        serial primary key,
    site_id   bigint unsigned not null,
    type_code char(20)        not null,
    name      varchar(255),
    part_num  char(100)
)
    comment 'отдельное устройство: монитор, системный блок, коммутатор';

alter table unit
	add constraint unit_sites_id_fk
		foreign key (site_id) references sites (id);

alter table unit
	add constraint unit_type_it_code_fk
		foreign key (type_code) references type_it (code);


# drop table if exists type_it;
create table type_it
(
    code char(20) primary key
)
    comment 'типы устойств ит';

# drop table if exists measures;
create table measures
(
    id            serial primary key,
    code          char(10),
    order_service char(10) comment 'документ регулятора',
    description   varchar(255),
    level_type    char(1) comment 'Тип: уровень, класс',
    level         tinyint
)
    comment 'меры информационной безопасности по документам регулятора';

# drop table if exists measures_infosystems;
create table measures_infosystems
(
    primary key (id_measures, id_infosystems),
    id_measures    bigint unsigned not null,
    id_infosystems bigint unsigned not null
)
    comment 'меры которые выполняются в информационной системе';

alter table measures_infosystems
	add constraint measures_infosystems_infosystems_id_fk
		foreign key (id_infosystems) references infosystems (id);

alter table measures_infosystems
	add constraint measures_infosystems_measures_id_fk
		foreign key (id_measures) references measures (id);



create table templates
(
    id          serial primary key,
    name        char(20),
    description varchar(255),
    file_name   char(200) not null

)
    comment 'шаблон документа';

# drop table if exists documents;
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
	add constraint documents_infosystems_id_fk
		foreign key (id_infosystems) references infosystems (id);

alter table documents
	add constraint documents_templates_id_fk
		foreign key (id_templates) references templates (id);








