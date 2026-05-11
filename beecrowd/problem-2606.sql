select p.id, p.name
from products as p
    join categories as c
    on p.id_categories = c.id
where c.name ilike 'super%';