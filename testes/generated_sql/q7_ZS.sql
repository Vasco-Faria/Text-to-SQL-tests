SELECT 
    n1.n_name AS supplier_nation,
    n2.n_name AS customer_nation,
    EXTRACT(YEAR FROM l.l_shipdate) AS year,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM 
    lineitem l
JOIN 
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN 
    nation n1 ON s.s_nationkey = n1.n_nationkey
JOIN 
    customer c ON l.l_custkey = c.c_custkey
JOIN 
    nation n2 ON c.c_nationkey = n2.n_nationkey
WHERE 
    (n1.n_name = 'ARGENTINA' AND n2.n_name = 'KENYA') 
    OR (n1.n_name = 'KENYA' AND n2.n_name = 'ARGENTINA')
    AND EXTRACT(YEAR FROM l.l_shipdate) IN (1995, 1996)
GROUP BY 
    n1.n_name,
    n2.n_name,
    EXTRACT(YEAR FROM l.l_shipdate)
ORDER BY 
    n1.n_name ASC,
    n2.n_name ASC,
    EXTRACT(YEAR FROM l.l_shipdate) ASC;