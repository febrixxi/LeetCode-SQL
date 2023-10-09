select Department, Employee, salary 
from (select d.name as Department, e.name as Employee, salary, 
dense_rank() over(partition by d.name order by d.name asc, salary desc) as "ranking"
from employee e 
join department d on e.departmentid = d.id) sq
where ranking < 4;