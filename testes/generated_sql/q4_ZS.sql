select
    o_orderpriority,
    count(distinct o_orderkey) as order_count
from
    orders,
    lineitem
where
    l_orderkey = o_orderkey
    and l_commitdate < l_receiptdate
    and o_orderdate >= date '1997-01-01'
    and o_orderdate < date '1997-01-01' + interval '3 months'
group by
    o_orderpriority
order by
    o_orderpriority;