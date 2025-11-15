select
    s_name,
    s_address
from
    supplier,
    nation
where
    s_suppkey in (
        select
            ps_suppkey
        from
            partsupp
        where
            ps_partkey in (
                select
                    p_partkey
                from
                    part
                where
                    p_name like 'brown%'
            )
            and ps_availqty > (
                select
                    0.5 * sum(l_quantity)
                from
                    lineitem,
                    orders,
                    supplier,
                    nation
                where
                    l_partkey = ps_partkey
                    and s_suppkey = l_suppkey
                    and l_orderkey = o_orderkey
                    and s_nationkey = n_nationkey
                    and n_name = 'SAUDI ARABIA'
                    and l_shipdate >= date '1994-01-01'
                    and l_shipdate < date '1994-01-01' + interval '1 year'
            )
    )
    and s_nationkey = n_nationkey
    and n_name = 'SAUDI ARABIA'
order by
    s_name
limit 10;