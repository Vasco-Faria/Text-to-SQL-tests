SELECT 
    o_orderpriority, 
    COUNT(o_orderkey) AS count
FROM 
    orders
WHERE 
    o_orderdate >= '1997-01-01' 
    AND o_orderdate < '1997-04-01'
    AND EXISTS (
        SELECT 
            1
        FROM 
            lineitem
        WHERE 
            l_orderkey = o_orderkey 
            AND l_receiptdate > l_commitdate
    )
GROUP BY 
    o_orderpriority
ORDER BY 
    o_orderpriority ASC;