select request_at as Day, 
round(cancelled/(completed+cancelled),2) as 'Cancellation Rate'
from (
select request_at, sum(if(status='completed',1,0)) as completed, 
sum(if(status!='completed',1,0)) as cancelled
from trips t
join users u1 on t.client_id = u1.users_id and u1.banned = 'No' and u1.role = 'client'
join users u2 on t.driver_id = u2.users_id and u2.banned = 'No' and u2.role = 'driver'
where request_at between '2013-10-01' and '2013-10-03'
group by request_at) sq;