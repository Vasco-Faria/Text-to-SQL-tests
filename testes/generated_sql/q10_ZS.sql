WITH returned_revenue AS (
    SELECT 
        l.l_extendedprice * (1 - l.l_discount) AS lost_revenue,
        o.o_orderkey,
        c.c_name,
        c.c_address,
        c.c_nation,
        c.c_phone,
        c.c_acctbal,
        c.c_comment
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    JOIN 
        customer c ON o.o_custkey = c.c_custkey
    WHERE 
        l.l_returnflag = 'R'
        AND o.o_orderdate >= '1993-07-01'
        AND o.o_orderdate < '1994-10-01'
)
SELECT 
    c_name,
    c_address,
    c_nation,
    c_phone,
    c_acctbal,
    c_comment,
    SUM(lost_revenue) AS total_lost_revenue
FROM 
    returned_revenue
GROUP BY 
    c_name, c_address, c_nation, c_phone, c_acctbal, c_comment
ORDER BY 
    total_lost_revenue DESC
LIMIT 20;