-- Даны месячные срезы сегментов клиентов,
-- нужно получить по каждому клиенту периоды действия каждого сегмента.

with seg_1 as (select s.clientid,
       min(s.date) over(partition by s.clientid) seg_1_start_date,
       max(s.date) over(partition by s.clientid) seg_1_end_date
from segment s
where s.segmentid = 1),

seg_2 as (select s.clientid,
       min(s.date) over(partition by s.clientid) seg_2_start_date,
       max(s.date) over(partition by s.clientid) seg_2_end_date
from segment s
where s.segmentid = 2),

seg_3 as (select s.clientid,
       min(s.date) over(partition by s.clientid) seg_3_start_date,
       max(s.date) over(partition by s.clientid) seg_3_end_date
from segment s
where s.segmentid = 3
)

select
    s1.clientid,
    s1.seg_1_start_date, s1.seg_1_end_date,
    s2.seg_2_start_date, s2.seg_2_end_date,
    s3.seg_3_start_date, s3.seg_3_end_date
from seg_1 s1
left join seg_2 s2 on s1.clientid = s2.clientid
left join seg_3 s3 on s1.clientid = s3.clientid
group by 1,2,3,4,5,6,7
