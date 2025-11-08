SELECT
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS discounted_revenue
FROM
    lineitem l
JOIN
    part p ON l.l_partkey = p.p_partkey
JOIN
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    nation n ON s.s_nationkey = n.n_nationkey
WHERE
    p.p_brand IN ('Brand#11', 'Brand#25', 'Brand#54')
    AND p.p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
    AND l.l_quantity >= 4 AND l.l_quantity <= 16
    AND p.p_size BETWEEN 1 AND 5
    AND l.l_shipmode IN ('AIR', 'AIR REG')
    AND l.l_shipinstruct = 'DELIVER IN PERSON';