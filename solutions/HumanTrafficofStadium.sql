# Write your MySQL query statement below
with more_than_a_hundred as (
  select * from stadium
  where people >= 100
),
next_two_id as (
select id, visit_date, people, lead(id,1) over() as next_id, lead(id,2) over() as next_second_id
from more_than_a_hundred
),
check_consecutive as (
select n.*, if(next_second_id-next_id=1,if(next_id-id=1,1,0),0) as is_consecutive 
from next_two_id n 
),
get_consecutive_id as (
select id
from check_consecutive
where is_consecutive=1
),
combine_consecutive_id as (
select distinct id from (select id
from get_consecutive_id
union
select id+1
from get_consecutive_id
union
select id+2
from get_consecutive_id) sq
)

select s.*
from stadium s
join combine_consecutive_id c on s.id = c.id