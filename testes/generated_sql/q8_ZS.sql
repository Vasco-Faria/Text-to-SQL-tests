select
    sum(case
        when n_name = 'KENYA'
        then l_extendedprice * (1 - l_discount)
        else 0
    end) / sum(l_extendedprice * (1 - l_discount)) as mkt_share
from
    part,
    supplier,
    lineitem,
    orders,
    customer,
    nation n1,
    region
where
    p_partkey = l_partkey
    and s_suppkey = l_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and s_nationkey = n1.n_nationkey
    and n1.n_regionkey = r_regionkey
    and r_name = 'AFRICA'
    and o_orderdate >= date '1995-01-01'
    and o_orderdate < date '1996-12-31' + interval '1 day'
    and p_type = 'ECONOMY PLATED BRASS'
group by
    extract(year from o_orderdate)
order by
    extract(year from o_orderdate);