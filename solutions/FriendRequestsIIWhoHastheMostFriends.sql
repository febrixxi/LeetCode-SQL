with request_list as (
    select requester_id, count(requester_id) friends
    from RequestAccepted
    group by requester_id
),
accept_list as (
    select accepter_id, count(requester_id) friends
    from RequestAccepted
    group by accepter_id
),
merged_friend_list as (
select requester_id as id, friends
from request_list
union all
select accepter_id as id, friends
from accept_list
),
cleaning_data as (
select id, sum(friends) as num
from merged_friend_list
group by id
)
select id, num
from cleaning_data
where num = (select max(num) from cleaning_data)