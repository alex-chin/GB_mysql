# Типичные выборки
use issec;

# Получить состав всех технических средсв ИС для заданной организации
select wp.name, type_code, units.name, part_num
from units
         left join work_places wp on wp.id = units.work_places_id
         left join sites s on s.id = wp.site_id
         left join infosystems i on i.id = s.infosystems_id
where i.organization_id = 1
order by wp.name;

# отобразить текущий состав мер для заданной ИС
select m.code, m.description
from measures_infosystems mi
         left join measures m on mi.id_measures = m.id and mi.id_infosystems = 1;# отобразить текущий состав мер для заданной ИС

# отобразить текущий состав мер для заданной ИС 2
select (select code from measures m where m.id = mi.id_measures),
       (select description from measures m where m.id = mi.id_measures)
from measures_infosystems mi;

# аналитика - общее количество мер по приказам регулятора
select order_service, count(*)
from measures
group by order_service;

# сводная таблица по приказам регулятора в зависимости от класса ИС
select '1 класс', ''
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



