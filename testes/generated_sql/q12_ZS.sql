WITH late_shipments AS (
    SELECT 
        l.l_shipmode,
        o.o_orderpriority,
        l.l_receiptdate,
        l.l_commitdate,
        l.l_shipdate
    FROM 
        lineitem l
    JOIN 
        orders o ON l.l_orderkey = o.o_orderkey
    WHERE 
        l.l_shipmode IN ('FOB', 'MAIL')
        AND l.l_receiptdate > l.l_commitdate
        AND l.l_shipdate < l.l_commitdate
        AND l.l_shipdate >= '1996-01-01'
)
SELECT 
    ship_mode,
    COUNT(CASE WHEN order_priority IN ('URGENT', 'HIGH') THEN 1 ELSE NULL END) AS high_priority_count,
    COUNT(CASE WHEN order_priority NOT IN ('URGENT', 'HIGH') THEN 1 ELSE NULL END) AS other_priority_count
FROM 
    late_shipments
GROUP BY 
    ship_mode;