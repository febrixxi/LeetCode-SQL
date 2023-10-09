select customer_number
from (
select customer_number, dense_rank() over(order by count(*) desc) as order_rank
from orders
group by customer_number) sq
where order_rank = 1;