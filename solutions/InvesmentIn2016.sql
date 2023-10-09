with 
insurance_raw as (
  select pid, concat(lat,lon) latlon, tiv_2015, tiv_2016, row_number() over(partition by concat(lat,lon) order by pid) as rownum
  from insurance
),

pid_unique_location as (
select pid, latlon, tiv_2015, tiv_2016
from insurance_raw
where rownum = 1),

remove_duplicated_location as (
  select p.pid, p.latlon, rownum, p.tiv_2015, p.tiv_2016
  from pid_unique_location p
  left join insurance_raw i on p.latlon = i.latlon and rownum > 1
  where rownum is null
),

remove_unique_tiv_2015 as (
select tiv_2015, count(tiv_2015) as amount
from insurance 
group by tiv_2015
having count(tiv_2015) > 1
)

select round(sum(tiv_2016), 2) as tiv_2016
from remove_duplicated_location
where tiv_2015 in (select tiv_2015 from remove_unique_tiv_2015)