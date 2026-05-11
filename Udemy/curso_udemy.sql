-- Select: Selecionar colunas de tabelas
	-- Formato: 
			-- select [colunas]
			-- from [schema].[tabela]
select email
from sales.customers;

select email, first_name, last_name
from sales.customers;

select * from sales.customers;





-- Distinct: remove linhas duplicadas
select distinct brand
from sales.products;

select distinct brand, model_year
from sales.products;





-- Where: filtra as linhas da tabela
select email, state
from sales.customers
where state = 'SC';





-- Order By
select *
from sales.products
order by price;

select *
from sales.products
order by price desc;





-- Limit
select * from sales.funnel
order by visit_page_date desc
limit 5;





-- Operadores aritmeticos
-- + - * / ^ %

select 
	email, 
	birth_date,
	(current_date - birth_date) / 365 as age
from sales.customers
order by age desc
limit 10;


-- || eh para unir strings
select
	(first_name || ' ' || last_name) as name
from sales.customers
limit 10;


-- Operadores de comparacao
-- = > < >= <= <>
select *
from (
	select 
		(price < 50000) as discount,
		price
	from sales.products
) t
where discount is true;


-- Operadores logicos
-- and, not, not, between, in, like, ilike, is null
select * 
from sales.products
where price between 100000 and 200000;



select *
from sales.products
where brand in ('HONDA', 'TOYOTA', 'RENAULT');





-- Funcoes agregadas
-- COUNT(), SUM(), MIN(), MAX(), AVG()

select *
from sales.products
where price = (select max(price) from sales.products);





-- Group by
select brand, count(*) as qtd
from sales.products
group by brand;





-- Having: filtra dados agrupados
select brand, count(*)
from sales.products
group by brand
having count(*) > 10;




-- Left Join
select * from temp_tables.tabela_1;
select * from temp_tables.tabela_2;


select t1.cpf, t1.name, t2.state
	from temp_tables.tabela_1 as t1
	left join temp_tables.tabela_2 as t2
	on t1.cpf = t2.cpf
where state is not null;


-- Union

select * from sales.products
union all
select * from temp_tables.products_2;


-- Subquery
	-- Where
select *
from sales.products
where price = (select min (price) from sales.products);


	-- With
with alguma_tabela as (
	select 
		professional_status,
		(current_date - birth_date)/365 as idade
	from sales.customers 
)
select
	professional_status,
	avg(idade) as idade_media
from alguma_tabela
group by professional_status;


	-- from
	
select 
	professional_status, 
	avg(idade) as idade_media
from (
	select 
		professional_status,
		(current_date - birth_date)/365.0 as idade
	from sales.customers 
) as alguma_tabela
group by professional_status;


	-- somar repeticoes
select 
    id,
    nome,
    data,
    count(*) over (
        partition by nome
        order by data
    ) as repeticoes_ate_agora
from tabela;



-- function
create function datediff(unidade varchar, data_inicial date, data_final date)
returns int
language sql
as

$$
	select 
		case
			when unidade in ('d', 'day', 'days') then (data_final - data_inicial)
			when unidade in ('w', 'week', 'weeks') then (data_final - data_inicial)/7
			end as diferenca
$$;





-- salvar
select
	customer_id
	into sales.customers_id
from sales.customers;

insert into sales.customers_id(name);





-- atualizar linhas

update temp_tables.profissoes
set professional_status = 'intern'
where status_professional = 'estagiario';


delete from temp_tables.profissoes
where status_professional = 'estagiario';




--  atualizar colunas
alter table sales.customers
add customer_age int;

update temp_tables.profissoes
set nova_coluna = 'valor'
where true;

alter table sales.customers
alter column customer_age type varchar;

alter table sales.customers
rename column customer_age to age;

alter table sales.customers
drop column age;




-- funcoes interessantes

select '2021-10-01'::date - '2021-02-01'::date

select replace ('1112222', '1', '0')

coalesce() -- verifica o primeiro valor nao nulo




-- funcoes de texto

lower
upper
trim
replace

date_trunc('month',visit_page_date)
interval '10 weeks'
extract ('dow' from visit_page_date) as blablabla
datediff ('weeks', data1, data2)