select p.name, f.name
from products as p
    join providers as f
    on p.id_providers = f.id
    join categories as c
    on p.id_categories = c.id
where c.id = 6;