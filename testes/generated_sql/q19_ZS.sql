SELECT
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS discounted_revenue
FROM
    lineitem l
JOIN
    part p ON l.l_partkey = p.p_partkey
WHERE
    (p.p_brand = 'Brand#11' AND l.l_quantity BETWEEN 1 AND 4)
    OR (p.p_brand = 'Brand#25' AND l.l_quantity BETWEEN 10 AND 16)
    OR (p.p_brand = 'Brand#54' AND l.l_quantity BETWEEN 20 AND 29)
    AND l.l_shipmode = 'AIR'
    AND l.l_shipinstruct = 'DELIVER IN PERSON';
