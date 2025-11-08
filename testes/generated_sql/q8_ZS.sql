SELECT
    100.00 * SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1995 THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1995 THEN 1 ELSE 0 END) AS market_share_1995,
    100.00 * SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1996 THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / SUM(CASE WHEN EXTRACT(YEAR FROM l_shipdate) = 1996 THEN 1 ELSE 0 END) AS market_share_1996
FROM
    lineitem,
    part,
    supplier,
    orders,
    customer,
    nation,
    region
WHERE
    p_partkey = l_partkey
    AND s_suppkey = l_suppkey
    AND l_orderkey = o_orderkey
    AND o_custkey = c_custkey
    AND c_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = 'AFRICA'
    AND p_type = 'ECONOMY PLATED BRASS'
    AND n_name = 'KENYA'
    AND EXTRACT(YEAR FROM l_shipdate) IN (1995, 1996);