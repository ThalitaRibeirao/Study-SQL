select c.name, sum(amount) as sum
from categories as c
    join products as p
    on c.id = p.id_categories
group by c.name