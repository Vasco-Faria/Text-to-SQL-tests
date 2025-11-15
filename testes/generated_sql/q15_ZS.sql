select
    s_suppkey,
    s_name,
    s_address,
    s_phone,
    s_acctbal,
    s_comment,
    sum(l_extendedprice * (1 - l_discount)) as total_revenue
from
    supplier,
    lineitem
where
    s_suppkey = l_suppkey
    and l_shipdate >= date '1997-01-01'
    and l_shipdate < date '1997-01-01' + interval '3 months'
group by
    s_suppkey,
    s_name,
    s_address,
    s_phone,
    s_acctbal,
    s_comment
order by
    total_revenue desc
limit 1;