select class
from (
select class, count(*)
from courses
group by class
having count(*) >= 5) sq;