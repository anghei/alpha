-- Отобрать клиентов по г. Москва с суммарными остатками по клиенту от 20 000 на последнюю дату.


with tb1 as (select *,
       rank() over (partition by account_num order by date desc) rnk
from accounts
order by 1
)

select  c.fio,
        sum(t.summa_usd) usd_summary
from    tb1 t
join customers c on t.account_num = c.account_num
where t.rnk = 1
    and c.region = 'Москва'
group by 1
having sum(t.summa_usd) >= '$20000.00'