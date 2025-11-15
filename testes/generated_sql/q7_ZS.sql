SELECT
    s_nation.n_name AS supplier_nation,
    c_nation.n_name AS customer_nation,
    EXTRACT(YEAR FROM l.l_shipdate) AS l_year,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM
    lineitem l
JOIN
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    customer c ON o.o_custkey = c.c_custkey
JOIN
    nation s_nation ON s.s_nationkey = s_nation.n_nationkey
JOIN
    nation c_nation ON c.c_nationkey = c_nation.n_nationkey
WHERE
    ((s_nation.n_name = 'ARGENTINA' AND c_nation.n_name = 'KENYA')
     OR (s_nation.n_name = 'KENYA' AND c_nation.n_name = 'ARGENTINA'))
    AND l.l_shipdate >= DATE '1995-01-01'
    AND l.l_shipdate < DATE '1997-01-01'
GROUP BY
    supplier_nation,
    customer_nation,
    l_year
ORDER BY
    supplier_nation,
    customer_nation,
    l_year;
