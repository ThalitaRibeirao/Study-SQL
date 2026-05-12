select c.name, r.rentals_date
from customers c
join rentals r
    on c.id = r.id_customers
where r.rentals_date >= '2016-09-01'
  and r.rentals_date < '2016-10-01'