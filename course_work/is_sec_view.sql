# 7. Скрипт создания представлений

use issec;

# Получить состав всех технических средсв ИС для организаций
create or replace view view_infosystem_it as
select s.infosystems_id, wp.name wp_name, type_code, u.name, part_num
from units u
         left join work_places wp on wp.id = u.work_places_id
         left join sites s on s.id = wp.site_id
         left join infosystems i on i.id = s.infosystems_id
order by s.infosystems_id, wp.name;

create or replace view veiw_measures as
select mi.id_infosystems, m.order_service,  order_num(m.order_service) order_num, m.code, m.description
from measures_infosystems mi
         left join measures m on mi.id_measures = m.id;


