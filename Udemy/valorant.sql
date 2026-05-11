create schema if not exists users;
create schema if not exists matches;
create schema if not exists agents;





drop table if exists users.user_info cascade;
create table users.user_info (
	id int primary key,
	nickname varchar(15)
);
insert into users.user_info (id, nickname)
values 
(0, 'yuri'),
(1, 'suave po'),
(2, 'lana del reyna'),
(3, 'MIBR VIRTUS'),
(4, 'eoLirox'),
(5, 'DGzao'),
(6, 'GustavimX'),
(7, 'gaiatoxD'),
(8, 'fatal'),
(9, 'ice mexerica');





drop table if exists matches.all_matches cascade;
create table matches.all_matches (
	id int primary key,
	server char(8) not null,
	time_start timestamp not null,
	duration_seconds int not null
);

insert into matches.all_matches (id, server, time_start, duration_seconds)
values
(0, 'br-sp', timestamp '2026-03-30 20:00:00', 3700);





drop table if exists agents.agents_category cascade;
create table agents.agents_category (
	id int primary key,
	category text not null
);

insert into agents.agents_category (id, category)
values 
(0, 'sentinel'),
(1, 'duelist'),
(2, 'smoke'),
(3, 'initiator');





drop table if exists agents.agents_list cascade;
create table agents.agents_list (
	id int primary key,
	name text not null,
	category int references agents.agents_category(id)
);

insert into agents.agents_list (id,name, category)
values 
(0, 'sage', 0),
(1, 'cypher', 0),
(2, 'killjoy', 0),
(3, 'chamber', 0),
(4, 'deadlock', 0),

-- DUELIST (1)
(5, 'jett', 1),
(6, 'phoenix', 1),
(7, 'reyna', 1),
(8, 'raze', 1),
(9, 'yoru', 1),
(10, 'neon', 1),
(11, 'iso', 1),
(12, 'waylay', 1),

-- SMOKE / CONTROLLER (2)
(13, 'brimstone', 2),
(14, 'omen', 2),
(15, 'viper', 2),
(16, 'astra', 2),
(17, 'harbor', 2),
(18, 'miks', 2),

-- INITIATOR (3)
(19, 'sova', 3),
(20, 'breach', 3),
(21, 'skye', 3),
(22, 'kayo', 3),
(23, 'fade', 3),
(24, 'gekko', 3);





drop table if exists users.user_matches cascade;
create table users.user_matches (
	id int primary key,
	user_id int references users.user_info(id),
	match_id int references matches.all_matches(id),
	kills int not null,
	deaths int not null,
	assists int not null,
	agent_id int references agents.agents_list(id),
	attack_team boolean not null
);


insert into users.user_matches (id, user_id, match_id, kills, deaths, assists, agent_id, attack_team)
values
-- Attack team
(0, 0, 0, 21, 13, 5, 10, true),
(1, 1, 0, 19,  9,  1, 5, true),
(2, 2, 0, 13, 12, 14, 18, true),
(3, 3, 0, 13,  8, 4, 19, true),
(4, 4, 0,  7,  8, 2, 2, true),

-- Defensive team
(5, 5, 0, 16, 14, 2, 14, false),
(6, 6, 0, 15, 15, 10, 22, false),
(7, 7, 0, 9, 15, 2, 0, false),
(8, 8, 0, 7, 16, 1, 10, false),
(9, 9, 0, 3, 13, 2, 12, false);



-- query 1
select count(id) from matches.all_matches;


-- query 2

select name from agents.agents_list
where name ilike '%a%';

-- query 3
select * from matches.all_matches
where (server = 'br-sp') and (duration_seconds > 3600);




-- desafio 1
select 
	u.nickname, 
	am.time_start
from users.user_matches um
join users.user_info u	
	on um.user_id = u.id
join matches.all_matches am
	on um.match_id = am.id
where am.time_start < date '2026-01-01' and um.attack_team;




-- desafio 2
select al.name as agent_name
from users.user_matches um
	left join agents.agents_list al
	on um.agent_id = al.id
where um.attack_team;




-- desafio 3
select 
	a.name as agent_name, 
	count(*) as total
from users.user_matches u
	join agents.agents_list a
	on u.agent_id = a.id
group by agent_name
order by total desc
limit 1;



-- desafio 4
select ui.nickname, avg(um.kills + um.assists - um.deaths) as kda
from users.user_matches um
	left join users.user_info ui
	on um.user_id = ui.id
group by ui.id
order by kda desc
limit 1;


-- desafio 5
select ui.nickname, max(um.kills + um.assists - um.deaths) as kda
from users.user_matches um
	left join users.user_info ui
	on um.user_id = ui.id
group by ui.id
order by kda desc
limit 1;



-- desafio 6
select 
	al.name as agent_name, 
	count(*) as total
from users.user_matches um
	left join users.user_info ui
	on um.user_id = ui.id
	left join agents.agents_list al
	on um.agent_id = al.id
where nickname = 'ice mexerica'
group by al.id
order by total desc
limit 1;


-- desafio 7
select ac.category as agent_category, count(*) total
from users.user_matches um
	left join agents.agents_list al
	on um.agent_id = al.id
	left join agents.agents_category ac
	on al.category = ac.id
group by agent_category
order by total;