SELECT 
    DATE_TRUNC('month', DATE '1996-04-01') AS month,
    ROUND(
        (SUM(CASE WHEN l_promo THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / 
         SUM(l_extendedprice * (1 - l_discount))) * 100,
        2
    ) AS promo_revenue_pct
FROM 
    lineitem
WHERE 
    l_shipdate >= DATE '1996-04-01' 
    AND l_shipdate < DATE '1996-04-01' + INTERVAL '1 month'
GROUP BY 
    DATE_TRUNC('month', DATE '1996-04-01');