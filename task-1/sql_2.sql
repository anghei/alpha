-- Таблица #oper хранит информацию о количестве произведенных операций на каждую календарную дату.
-- Вывести на каждую дату количества операций, совершенное с начала месяца по указанную дату включительно накопительным итогом.


with tb1 as (
        select  *,
                extract(month from o.date) month_date
--                 date_trunc('month', o.date) month_date
        from    oper o
        order by o.date
)

select
    t.date,
    t.cnt,
    sum(t.cnt) over(partition by t.month_date order by t.date) as cum_sum
from tb1 t
order by 1