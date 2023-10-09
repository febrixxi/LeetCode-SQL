select id
from (
select id, temperature, lag(temperature,1) over(order by recorddate) as prev_temperature, 
recorddate, lag(recordDate,1) over(order by recorddate) as prev_day
from weather
order by recorddate) sq
where temperature > prev_temperature 
and datediff(recorddate,prev_day)=1;