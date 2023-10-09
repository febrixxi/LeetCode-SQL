select distinct email 
from (
select email, count(email)
from person p
group by email
having count(email) > 1) sq;