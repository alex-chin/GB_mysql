# 8. Скрипт основных манипуляций с данными

use issec;

# Получить состав всех технических средсв ИС для заданной организации
select wp.name, type_code, units.name, part_num
from units
         left join work_places wp on wp.id = units.work_places_id
         left join sites s on s.id = wp.site_id
         left join infosystems i on i.id = s.infosystems_id
where i.organization_id = 1
order by wp.name;

# сформировать начальный список мер для
# ИС с id=1, Номер документа регулятора order_service=17, класс защищенности=1
call applying_measures(1, 17, 1);

# отобразить текущий состав мер для заданной ИС
select m.code, m.description
from measures_infosystems mi
         left join measures m on mi.id_measures = m.id and mi.id_infosystems = 1;

# добавить к ссылочному списку меру
# ИС с id=1, Номер документа регулятора order_service=21, код меры='ИНЦ.2'
call add_measure(1, 21, 'ИНЦ.2');


# отобразить текущий состав мер для заданной ИС 2
select (select code from measures m where m.id = mi.id_measures) code,
       (select description from measures m where m.id = mi.id_measures) description
from measures_infosystems mi
       where mi.id_infosystems = 1;

# удалить из ссылочного списка меру
# ИС с id=1, Номер документа регулятора order_service=21, код меры='ИНЦ.2'
call del_measure(1, 21, 'ИНЦ.2');

# отобразить текущий состав мер для заданной ИС 3
select *
from veiw_measures
where id_infosystems = 1;

# аналитика - общее количество мер по приказам регулятора
select order_service as 'Приказ', count(*) as 'Кол мер'
from measures
group by order_service;

# сводная таблица по количеству мер по документам регулятора в зависимости от класса ИС
select '1 класс' as 'Приказ', '' as 'Описание'
union
select order_service, count(*)
from measures
where div1
group by order_service
union
select '2 класс', ''
union
select order_service, count(*)
from measures
where div2
group by order_service
union
select '3 класс', ''
union
select order_service, count(*)
from measures
where div3
group by order_service
union
select '4 класс', ''
union
select order_service, count(*)
from measures
where div4
group by order_service;

# Получить состав всех технических средсв ИС для заданной организации
select *
from view_infosystem_it
where infosystems_id = 2;




