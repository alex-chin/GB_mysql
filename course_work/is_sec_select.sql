# Типичные выборки
# Получить состав всех технических средсв ИС для заданной организации

select wp.name, type_code, units.name, part_num from units
left join work_places wp on wp.id = units.work_places_id
left join sites s on s.id = wp.site_id
left join infosystems i on i.id = s.infosystems_id
where i.organization_id = 1
order by wp.name;


