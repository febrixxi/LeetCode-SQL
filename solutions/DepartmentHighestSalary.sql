select d.name as Department, e.name as Employee, sq.salary as Salary
from employee e 
join department d on e.departmentid = d.id
join (select departmentid, max(salary) as salary from employee group by departmentid) sq 
on e.departmentid = sq.departmentid and e.salary = sq.salary;