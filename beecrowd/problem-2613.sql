
drop table if exists prices;
create table prices (
	id numeric primary key,
	category varchar,
	value numeric
);

insert into prices (id, category, value)
values
(1, 'Releases', 3.5),
(2, 'Bronze Seal', 2.0),
(3, 'Silver Seal', 2.5),
(4, 'Gold Seal', 3.0),
(5, 'Promotion', 1.5);


drop table if exists movies;
create table movies (
	id numeric,
	name varchar,
	id_prices numeric references prices(id)
);


insert into movies (id, name, id_prices)
values 
(1, 'Batman', 3),
(2, 'The Battle of the Dark River', 3),
(3, 'White Duck', 5),
(4, 'Breaking Barriers', 4),
(5, 'The Two Hours', 2);

select m.id, m.name
from movies as m
    join prices as p
    on m.id_prices = p.id
where p.prices < 2;