SELECT
    EXTRACT(YEAR FROM l.l_shipdate) AS l_year,
    SUM(CASE WHEN s_nation.n_name = 'KENYA' THEN l.l_extendedprice * (1 - l.l_discount) ELSE 0 END) /
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS market_share
FROM
    lineitem l
JOIN
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN
    nation s_nation ON s.s_nationkey = s_nation.n_nationkey
JOIN
    region r ON s_nation.n_regionkey = r.r_regionkey
JOIN
    part p ON l.l_partkey = p.p_partkey
WHERE
    r.r_name = 'AFRICA'
    AND p.p_type = 'ECONOMY PLATED BRASS'
    AND l.l_shipdate >= DATE '1995-01-01'
    AND l.l_shipdate < DATE '1997-01-01'
GROUP BY
    l_year
ORDER BY
    l_year;

