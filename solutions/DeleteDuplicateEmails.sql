delete from person where id in (
select id
from (
select id, email, row_number() over(partition by email order by id) as rownum
from person) sq
where rownum > 1);