select
    c_custkey,
    c_name,
    c_acctbal,
    c_phone,
    n_name,
    c_address,
    c_comment,
    sum(l_extendedprice * (1 - l_discount)) as total_lost_revenue
from
    customer,
    orders,
    lineitem,
    nation
where
    c_custkey = o_custkey
    and o_orderkey = l_orderkey
    and l_returnflag = 'R'
    and c_nationkey = n_nationkey
    and o_orderdate >= date '1993-08-01'
    and o_orderdate < date '1993-08-01' + interval '3 months'
group by
    c_custkey,
    c_name,
    c_acctbal,
    c_phone,
    n_name,
    c_address,
    c_comment
order by
    total_lost_revenue desc
limit 20;
