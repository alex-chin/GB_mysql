use issec;

SET FOREIGN_KEY_CHECKS = 0;

insert into issec.organizations (id, photo_id, name, short_name, address, inn, is_executor)
values (1, 96, 'ЗАО "АГРОС МИТ"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АГРОС МИТ"',
        '109382, МОСКВА Г, КРАСНОДАРСКАЯ УЛ, 20/1, 137', '5036057916', false),
       (2, 97, 'ЗАО "АДС "МАСК"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "Агенство Делового сотрудничества "МАСК"',
        '109382, г Москва, пр Кирова, д 2', '7723093962', false),
       (3, 98, 'ЗАО "АКАДЕМЗАГРАНПОСТАВКА"',
        'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "ЦЕНТР ЗАГРАНПОСТАВОК И СЕРВИСА НАУЧНОГО ОБОРУДОВАНИЯ РАН"',
        '109347, МОСКВА Г, ЛЕТНЯЯ УЛ, 1, СТР.2', '7723586943', false),
       (4, 99, 'ЗАО "АККОРД"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АККОРД"', '109559, г Москва, ул Ставропольская, д 50/22',
        '7723328325', false),
       (5, 100, 'ЗАО "АЛЬКОНА"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АЛЬКОНА"',
        '109559, г Москва, ул Краснодарская, д 57, корп 2, кв 4', '7723891150', false),
       (6, null, 'ЗАО "АЛЬФА-ФИНЭКО"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АЛЬФА-ФИНЭКО"',
        '109386, Г МОСКВА, УЛ ТАГАНРОГСКАЯ, Д 6, ПОМ 22 Н', '7723529430', false),
       (7, null, 'ЗАО "АНЕС М"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АНЕС М"',
        '109382, г Москва, ул Нижние Поля, д 29, стр 1', '7723015001', false),
       (8, null, 'ЗАО "АнСи Системс"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АнСи Системс"',
        '109382, МОСКВА Г, МАРИУПОЛЬСКАЯ УЛ, 6, ОФИС 30', '7723797951', false),
       (9, null, 'ЗАО "АНТАРЕС-ОЙЛ"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АНТАРЕС-ОЙЛ"',
        '109382, г Москва, ул Судакова, д 22/10, корп 1', '7723168431', false),
       (10, null, 'ЗАО "АПРИОРИ"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АПРИОРИ"', '109382, г Москва, ул Совхозная, д 3',
        '7723906985', false),
       (11, null, 'ЗАО "АРГО-ИМПУЛЬС"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "АРГО-ИМПУЛЬС"',
        '109382, г Москва, Юго-Восточный административный округ, район Люблино, УЛ ЕГОРЬЕВСКАЯ, Д 16', '7723601239',
        false),
       (24, null, 'ЗАО "ИНФО-КАЛИБР"', 'ЗАКРЫТОЕ АКЦИОНЕРНОЕ ОБЩЕСТВО "ИНФО-КАЛИБР"',
        '109559, МОСКВА Г, СТАВРОПОЛЬСКАЯ УЛ, 67', '7721617156', true);


insert into issec.persons (id, organization_id, name_full, name_short, position, phone, email, position_sign,
                           is_chairman, is_member, is_agreement, is_approval)
values (3, 1, 'МАРЧЕНКО НАТАЛЬЯ СЕРГЕЕВНА', 'МАРЧЕНКО  Н. С.', 'Генеральный директор', '(570)895-0927x9158',
        'ratke.aiden@jacobishields.com', null, false, false, true, false),
       (4, 2, 'ГЛОВАЦКИЙ АЛЕКСЕЙ ВАСИЛЬЕВИЧ', 'ГЛОВАЦКИЙ  А. В.', 'Генеральный директор', '8 (495) 164-05-76',
        'albin.toy@zemlak.org', null, false, false, true, false),
       (5, 3, 'ИВАНОВА КСЕНИЯ ПАВЛОВНА', 'ИВАНОВА  К. П.', 'Генеральный директор', '8 (919) 424-81-82',
        'pauline42@harberfisher.com', null, false, false, true, false),
       (6, 4, 'Королев Валерий Федорович', 'Королев  В. Ф.', 'Генеральный директор', '8 (495) 179-78-60',
        'grant.liam@schowalter.com', null, false, false, true, false),
       (7, 5, 'ИСАЕВ ВИКТОР ВАСИЛЬЕВИЧ', 'ИСАЕВ  В. В.', 'Генеральный директор', '8 (495) 358-01-59',
        'qgaylord@schultzhilpert.net', null, false, false, true, false),
       (8, 6, 'КОНДРАТЬЕВ АЛЕКСАНДР ВАЛЕНТИНОВИЧ', 'КОНДРАТЬЕВ  А. В.', 'Генеральный директор', '8 (929) 613-81-20',
        'rigoberto57@wehner.biz', null, false, false, true, false),
       (9, 7, 'БОБРОВСКИЙ ДМИТРИЙ ГЕННАДЬЕВИЧ', 'БОБРОВСКИЙ  Д. Г.', 'Генеральный директор', '8 (495) 122-42-35',
        'imani72@okon.com', null, false, false, true, false),
       (10, 8, 'АЛОВА ВИКТОРИЯ ВЛАДИМИРОВНА', 'АЛОВА  В. В.', 'Генеральный директор', '8 (926) 162-32-98',
        'gus.huel@crooks.com', null, false, false, true, false),
       (11, 9, 'СУСЛИН АЛЕКСАНДР ДМИТРИЕВИЧ', 'СУСЛИН  А. Д.', 'Генеральный директор', '8 (925) 187-67-27',
        'ehaag@glover.com', null, false, false, true, false),
       (12, 10, 'МАРУСЕВИЧ АЛЕКСЕЙ АЛЕКСЕЕВИЧ', 'МАРУСЕВИЧ  А. А.', 'Генеральный директор', '8 (495) 617-02-04',
        'stokes.raquel@brown.com', null, false, false, true, false),
       (13, 11, 'ГОРОХОВ ДМИТРИЙ АЛЕКСАНДРОВИЧ', 'ГОРОХОВ  Д. А.', 'Генеральный директор', '8 (925) 187-67-27',
        'alexzander87@zemlak.com', null, false, false, true, false),
       (14, 24, 'ВАССИЛ СТЕФАНОВ ВАССИЛЕВ', 'ВАССИЛ  С. В.', 'Руководитель проекта', '8 (495) 640-91-17',
        'jaylon.wiza@reilly.com', null, true, false, false, true),
       (15, 24, 'РАЗОВА ЕЛЕНА ВЛАДИМИРОВНА', 'РАЗОВА  Е. В.', 'Эксперт', '8 (916) 933-73-74', 'lbruen@denesik.org',
        null, false, true, false, false),
       (16, 24, 'ФИЛИМОНОВ ЮРИЙ ВИКТОРОВИЧ', 'ФИЛИМОНОВ  Ю. В.', 'Эксперт', '8 (499) 490-25-03',
        'schinner.kasey@hammeschamplin.com', null, false, true, false, false),
       (17, 24, 'ЖУБАНОВ АНДРЕЙ НИКОЛАЕВИЧ', 'ЖУБАНОВ  А. Н.', 'Эксперт', '8 (495) 359-00-39',
        'federico.gibson@johnsonsteuber.net', null, false, true, false, false),
       (18, 24, 'ГОРОХОВ ДМИТРИЙ АЛЕКСАНДРОВИЧ', 'ГОРОХОВ  Д. А.', 'Эксперт', '8 (495) 358-88-09',
        'albert43@langworthcummings.info', null, false, false, false, false),
       (19, 24, 'УШАКОВ АЛЕКСЕЙ ВЛАДИМИРОВИЧ', 'УШАКОВ  А. В.', 'Эксперт', '8 (495) 740-32-47',
        'carson.welch@handkuphal.org', null, false, false, false, false),
       (20, 24, 'СИМОНОВА ОКСАНА ВЛАДИМИРОВНА', 'СИМОНОВА  О. В.', 'Эксперт', '8 (495) 925-90-05',
        'juliet05@willms.biz', null, false, false, false, false);

# update persons
# set name_short = concat(substr(name_full, 1, locate(' ', name_full)), ' ',
#                         substr(name_full, locate(' ', name_full) + 1, 1), '. ',
#                         substr(name_full, locate(' ', name_full, locate(' ', name_full) + 1) + 1, 1), '.');


insert into issec.infosystems (id, organization_id, executor_org_id, name, short_name, is_one_site, is_ispdn,
                               ispdn_lev, is_gis, gis_class, is_as, as_class, date_agreement, date_approval,
                               is_att_before, before_name, before_date, before_num_attestation, reg_number)
values (1, 1, 24, 'Информационная система «MODEUS» ООО «ЗИС»', 'ИС «MODEUS»', true,
        true, 3, null, null, null, null, null, null, false, null,
        null, null, null),
       (2, 2, 24,
        'Автоматизированная система мониторинга, анализа и оперативного реагирования на инциденты информационной безопасности',
        'ИС "SOC"', true, false, null, true, 1, null,
        null, null, null, false, null, null, null, null),
       (3, 3, 24, 'Информационная система «Защищённый сегмент облачной платформы «ИТ-ГРАД 1 Клауд»',
        'ИС «ИТ-ГРАД 1 Клауд»', true,
        true,
        3, true, 3, null, null, null, null, false, null, null, null, null),
       (4, 4, 24, 'Информационная система персональных данных ООО «Орб»', 'ИC ООО «Орб»', true,
        true, 3, false, null, false, null, null, null,
        false, null, null, null, null),
       (5, 5, 24, 'Автоматизированная система «Финансово-закупочной деятельности» ООО «РусАйТиЭкспорт»', 'ИС "АИСФЗД"',
        true, true, 3, null, null, null, null, null, null, false, null, null, null, null),
       (6, 6, null,
        'Информационная система персональных данных «Автоматизированная защищенная среда обработки информации в центре обработки данных» ООО «Стек Групп»',
        'ИС "АЗС"', true, true, 1, null, null, null, null, null, null, false, null, null, null, null),
       (7, 7, null,
        'Автоматизированная информационная система «ОПЕРАТОР ФИСКАЛЬНЫХ ДАННЫХ» Акционерного общества «ТАНДЕР»',
        'ИС "ОФД"', true, null, null, true, 3, null, null, null, null, false, null, null, null, null);

# UPDATE sites s
# INNER JOIN infosystems i ON s.infosystems_id = i.id
# INNER JOIN organizations o ON i.organization_id = o.id
# SET s.address = o.address;

insert into issec.type_it (code)
values ('ИПБ'),
       ('Клавиатура'),
       ('Коммутатор'),
       ('Манипулятор мышь'),
       ('Монитор'),
       ('Сервер'),
       ('Системный блок');

insert into issec.sites (id, infosystems_id, address)
values (1, 1, '109382, МОСКВА Г, КРАСНОДАРСКАЯ УЛ, 20/1, 137'),
       (2, 2, '109382, г Москва, пр Кирова, д 2'),
       (3, 3, '109347, МОСКВА Г, ЛЕТНЯЯ УЛ, 1, СТР.2'),
       (4, 4, '109559, г Москва, ул Ставропольская, д 50/22'),
       (5, 5, '109559, г Москва, ул Краснодарская, д 57, корп 2, кв 4'),
       (6, 6, '109386, Г МОСКВА, УЛ ТАГАНРОГСКАЯ, Д 6, ПОМ 22 Н'),
       (7, 7, '109382, г Москва, ул Нижние Поля, д 29, стр 1');

insert into issec.work_places (id, site_id, name)
values (1, 1, 'АРМ Администратора'),
       (2, 1, 'Сервера'),
       (3, 1, 'Коммутационное оборудование'),
       (4, 2, 'АРМ00'),
       (5, 2, 'АРМ01'),
       (6, 2, 'АРМ02'),
       (7, 2, 'АРМ03'),
       (8, 2, 'Серверное оборудование'),
       (9, 2, 'Коммутационное оборудование');

insert into issec.units (id, work_places_id, type_code, name, part_num)
values (1, 1, 'Монитор', 'ViewSonic VE710s', 'PUE054721168'),
       (2, 1, 'Системный блок', 'ТЕАМ', '2013086610-10'),
       (3, 1, 'Клавиатура', 'Logitech K200', 'SY301UK'),
       (4, 1, 'Манипулятор мышь', 'Logitech RX 250', 'LZ049HG1GR6'),
       (5, 2, 'Сервер', 'Super Micro', 'A15751827402958'),
       (6, 2, 'Сервер', 'Super Micro', 'A15751827402957'),
       (7, 3, 'Коммутатор', 'Cisco 2960X', 'JTV213010AR'),
       (8, 3, 'Коммутатор', 'Cisco 2960X', 'JTV213010E3'),
       (12, 4, 'Монитор', 'ViewSonic VE710s', 'PUE054721168'),
       (13, 4, 'Клавиатура', 'Logitech K120', '1917SC50FPW8'),
       (14, 4, 'Манипулятор мышь', 'Logitech B110', '810-001317'),
       (15, 5, 'Системный блок', 'InWin', '16232036400104'),
       (16, 6, 'Системный блок', 'InWin', '1622C031800149'),
       (17, 7, 'Системный блок', 'InWin', '16218030300388'),
       (18, 8, 'Сервер', 'ProLiant DL 120 Gen9', 'CZ254407ST'),
       (19, 8, 'Сервер', 'ProLiant DL160 G6', 'CZJ0500BWX'),
       (20, 8, 'Сервер', 'ProLiant ML380p Gen8', 'CZ221404Q7'),
       (21, 9, 'Коммутатор', 'Catalyst 3560G', 'F0C1114Y43B'),
       (22, 9, 'Коммутатор', 'Catalyst 2960G', 'F0C1040X1T0'),
       (23, 9, 'ИПБ', 'APC', 'SYRMXRI4');


insert into issec.photos (id, site_id, workplace_id, is_logo, file_name)
values (1, null, 1, false, 'photo/distinctio.png'),
       (2, null, 1, false, 'photo/dolorum.png'),
       (3, null, 1, false, 'photo/libero.png'),
       (4, null, 1, false, 'photo/eos.png'),
       (5, null, 1, false, 'photo/dolore.png'),
       (6, null, 1, false, 'photo/accusantium.png'),
       (7, null, 1, false, 'photo/rerum.png'),
       (8, null, 1, false, 'photo/cum.png'),
       (9, null, 1, false, 'photo/atque.png'),
       (10, null, 1, false, 'photo/necessitatibus.png'),
       (11, null, 2, false, 'photo/deserunt.png'),
       (12, null, 2, false, 'photo/porro.png'),
       (13, null, 2, false, 'photo/omnis.png'),
       (14, null, 2, false, 'photo/velit.png'),
       (15, null, 2, false, 'photo/repellat.png'),
       (16, null, 2, false, 'photo/quo.png'),
       (17, null, 2, false, 'photo/aut.png'),
       (18, null, 2, false, 'photo/molestiae.png'),
       (19, null, 2, false, 'photo/possimus.png'),
       (20, null, 2, false, 'photo/dolorem.png'),
       (21, null, 2, false, 'photo/quos.png'),
       (22, null, 2, false, 'photo/et.png'),
       (23, null, 3, false, 'photo/dolores.png'),
       (24, null, 3, false, 'photo/et.png'),
       (25, null, 3, false, 'photo/animi.png'),
       (26, null, 3, false, 'photo/fuga.png'),
       (27, null, 3, false, 'photo/aut.png'),
       (28, null, 3, false, 'photo/facere.png'),
       (29, null, 3, false, 'photo/est.png'),
       (30, null, 3, false, 'photo/repellendus.png'),
       (31, null, 3, false, 'photo/veniam.png'),
       (32, null, 3, false, 'photo/aut.png'),
       (33, null, 3, false, 'photo/atque.png'),
       (34, null, 4, false, 'photo/qui.png'),
       (35, null, 4, false, 'photo/quisquam.png'),
       (36, null, 4, false, 'photo/provident.png'),
       (37, null, 4, false, 'photo/omnis.png'),
       (38, null, 4, false, 'photo/accusantium.png'),
       (39, null, 4, false, 'photo/est.png'),
       (40, null, 4, false, 'photo/maxime.png'),
       (41, null, 4, false, 'photo/aperiam.png'),
       (42, null, 4, false, 'photo/dignissimos.png'),
       (43, null, 4, false, 'photo/totam.png'),
       (44, null, 4, false, 'photo/eum.png'),
       (45, null, 4, false, 'photo/ad.png'),
       (46, null, 5, false, 'photo/ut.png'),
       (47, null, 5, false, 'photo/illum.png'),
       (48, null, 5, false, 'photo/vero.png'),
       (49, null, 5, false, 'photo/est.png'),
       (50, null, 5, false, 'photo/voluptatem.png'),
       (51, null, 5, false, 'photo/dolor.png'),
       (52, null, 5, false, 'photo/laudantium.png'),
       (53, null, 5, false, 'photo/rem.png'),
       (54, null, 5, false, 'photo/et.png'),
       (55, null, 5, false, 'photo/qui.png'),
       (56, null, 5, false, 'photo/inventore.png'),
       (57, null, 6, false, 'photo/nesciunt.png'),
       (58, null, 6, false, 'photo/ut.png'),
       (59, null, 6, false, 'photo/illo.png'),
       (60, null, 6, false, 'photo/ea.png'),
       (61, null, 6, false, 'photo/impedit.png'),
       (62, null, 6, false, 'photo/itaque.png'),
       (63, null, 7, false, 'photo/odit.png'),
       (64, null, 7, false, 'photo/eius.png'),
       (65, null, 7, false, 'photo/porro.png'),
       (66, null, 7, false, 'photo/ullam.png'),
       (67, null, 7, false, 'photo/dolore.png'),
       (68, null, 7, false, 'photo/corrupti.png'),
       (69, null, 7, false, 'photo/explicabo.png'),
       (70, null, 7, false, 'photo/ipsam.png'),
       (71, null, 7, false, 'photo/possimus.png'),
       (72, null, 7, false, 'photo/quia.png'),
       (73, null, 7, false, 'photo/quis.png'),
       (74, null, 7, false, 'photo/delectus.png'),
       (75, null, 7, false, 'photo/consectetur.png'),
       (76, null, 8, false, 'photo/ex.png'),
       (77, null, 8, false, 'photo/laborum.png'),
       (78, null, 8, false, 'photo/ratione.png'),
       (79, null, 8, false, 'photo/ut.png'),
       (80, null, 8, false, 'photo/iure.png'),
       (81, null, 8, false, 'photo/pariatur.png'),
       (82, null, 9, false, 'photo/reprehenderit.png'),
       (83, null, 9, false, 'photo/quis.png'),
       (84, null, 9, false, 'photo/dolore.png'),
       (85, null, 9, false, 'photo/quo.png'),
       (86, null, 9, false, 'photo/labore.png'),
       (87, null, 9, false, 'photo/quo.png'),
       (88, null, 9, false, 'photo/provident.png'),
       (89, null, 9, false, 'photo/qui.png'),
       (90, 2, null, false, 'photo/et.png'),
       (91, 2, null, false, 'photo/rem.png'),
       (92, 2, null, false, 'photo/harum.png'),
       (93, 2, null, false, 'photo/dolorum.png'),
       (94, 2, null, false, 'photo/temporibus.png'),
       (95, 2, null, false, 'photo/saepe.png'),
       (96, null, null, true, 'photo/reiciendis.png'),
       (97, null, null, true, 'photo/id.png'),
       (98, null, null, true, 'photo/repudiandae.png'),
       (99, null, null, true, 'photo/eos.png'),
       (100, null, null, true, 'photo/quaerat.png');

insert into issec.templates (id, name, description, file_name)
values (1, 'ПИМ', null, 'Шаблон_ПИМ_ГИС_ИСПДН_К_2.docx'),
       (2, 'Аттестат', null, 'Шаблон_Аттестат_соответствия.docx'),
       (3, 'Заключение', null, 'Шаблон_Заключение_ГИС_ИСПДН_K_2.docx');

insert into issec.documents (id, id_infosystems, id_templates, file_name, created_at)
values (1, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:38:51'),
       (2, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:38:51'),
       (3, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25'),
       (4, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25'),
       (5, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25'),
       (6, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25'),
       (7, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25'),
       (8, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25'),
       (9, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25'),
       (10, 1, 1, 'АГРОС_ПИМ_ГИС_ИСПДН_К_2.docx', '2021-02-01 13:41:25');


SET FOREIGN_KEY_CHECKS = 1;


