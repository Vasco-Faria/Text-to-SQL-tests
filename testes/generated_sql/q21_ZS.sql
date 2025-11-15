select
    s_suppkey,
    s_name,
    s_address,
    s_phone,
    s_acctbal,
    s_comment
from
    supplier,
    nation
where
    s_suppkey in (
        select
            l_suppkey
        from
            lineitem
        where
            l_orderkey in (
                select
                    o_orderkey
                from
                    orders
                where
                    o_orderstatus = 'F'
            )
            and l_suppkey in (
                select
                    s_suppkey
                from
                    supplier,
                    nation
                where
                    s_nationkey = n_nationkey
                    and n_name = 'ETHIOPIA'
            )
            and l_receiptdate > l_commitdate
        group by
            l_orderkey,
            l_suppkey
        having
            sum(case
                when l_receiptdate > l_commitdate
                then 1
                else 0
            end) > 0
    )
    and s_suppkey not in (
        select
            l_suppkey
        from
            lineitem
        where
            l_orderkey in (
                select
                    o_orderkey
                from
                    orders
                where
                    o_orderstatus = 'F'
            )
            and l_suppkey in (
                select
                    s_suppkey
                from
                    supplier,
                    nation
                where
                    s_nationkey = n_nationkey
                    and n_name <> 'ETHIOPIA'
            )
            and l_receiptdate > l_commitdate
        group by
            l_orderkey,
            l_suppkey
        having
            sum(case
                when l_receiptdate > l_commitdate
                then 1
                else 0
            end) > 0
    )
    and s_nationkey = n_nationkey
    and n_name = 'ETHIOPIA'
order by
    s_suppkey;