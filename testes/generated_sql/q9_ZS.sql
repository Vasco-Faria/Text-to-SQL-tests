SELECT
    n.n_name AS nation,
    EXTRACT(YEAR FROM l.l_shipdate) AS l_year,
    SUM((l.l_extendedprice * (1 - l.l_discount)) - (ps.ps_supplycost * l.l_quantity)) AS profit
FROM
    lineitem l
JOIN
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN
    partsupp ps ON l.l_partkey = ps.ps_partkey AND l.l_suppkey = ps.ps_suppkey
JOIN
    part p ON l.l_partkey = p.p_partkey
JOIN
    nation n ON s.s_nationkey = n.n_nationkey
WHERE
    p.p_name LIKE '%red%'
GROUP BY
    n.n_name,
    l_year
ORDER BY
    nation ASC,
    l_year DESC;
