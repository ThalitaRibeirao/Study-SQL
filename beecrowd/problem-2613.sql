select m.id, m.name
from movies as m
    join prices as p
    on m.id_prices = p.id
where p.prices < 2;