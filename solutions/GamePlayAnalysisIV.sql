with activity_raw as (
  select 
  player_id, event_date, 
  lead(event_date) over(partition by player_id order by event_date) as second_login, 
  row_number() over(partition by player_id order by event_date) as rownum
  from activity
),

first_activity as (
  select player_id, datediff(second_login, event_date) as day_after_first_login
  from activity_raw
  where rownum = 1
)

select round(sum(if(day_after_first_login=1,1,0))/count(player_id),2) as fraction
from first_activity;