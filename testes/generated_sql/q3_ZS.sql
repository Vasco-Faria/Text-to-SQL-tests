SELECT 
    l_orderkey, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
    o_orderdate, 
    o_shippriority
FROM 
    lineitem, 
    orders
WHERE 
    o_orderkey = l_orderkey 
    AND l_shipdate > '1995-03-27' 
    AND o_orderdate < '1995-03-27' 
    AND o_orderdate >= '1995-03-01' 
    AND l_shipdate > '1995-03-27'
    AND o_shippriority IN ('1-URGENT', '2-HIGH')
    AND l_partkey IN (
        SELECT 
            l_partkey
        FROM 
            part, 
            lineitem
        WHERE 
            p_partkey = l_partkey 
            AND p_segment = 'FURNITURE'
    )
GROUP BY 
    l_orderkey, 
    o_orderdate, 
    o_shippriority
ORDER BY 
    revenue DESC
LIMIT 10;