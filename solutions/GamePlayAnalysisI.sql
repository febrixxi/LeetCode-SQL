select player_id, event_date as first_login
from (
select player_id, event_date, row_number() over(partition by player_id order by event_date) as rownum
from activity) sq 
where rownum = 1;