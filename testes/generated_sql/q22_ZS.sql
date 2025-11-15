select
    count(c_custkey),
    sum(c_acctbal)
from
    customer
where
    substring(c_phone for 2) in ('30', '31', '28', '21', '26', '33', '10')
    and c_acctbal > (
        select
            avg(c_acctbal)
        from
            customer
        where
            c_acctbal > 0.00
            and substring(c_phone for 2) in ('30', '31', '28', '21', '26', '33', '10')
    )
    and c_custkey not in (
        select
            o_custkey
        from
            orders
    );