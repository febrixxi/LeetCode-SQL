with more_than_five as (
select managerid, count(*)
from employee
group by managerid
having count(*) >= 5)

select name
from employee e 
join more_than_five m on e.id = m.managerid;