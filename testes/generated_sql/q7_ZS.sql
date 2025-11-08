SELECT
    s_nation,
    c_nation,
    year,
    SUM(volume) AS revenue
FROM
    (
        SELECT
            N1.n_name AS s_nation,
            N2.n_name AS c_nation,
            EXTRACT(YEAR FROM l_shipdate) AS year,
            l_extendedprice * (1 - l_discount) AS volume
        FROM
            supplier,
            lineitem,
            orders,
            customer,
            nation N1,
            nation N2
        WHERE
            s_suppkey = l_suppkey
            AND o_orderkey = l_orderkey
            AND c_custkey = o_custkey
            AND s_nationkey = N1.n_nationkey
            AND c_nationkey = N2.n_nationkey
            AND (
                (N1.n_name = 'ARGENTINA' AND N2.n_name = 'KENYA')
                OR (N1.n_name = 'KENYA' AND N2.n_name = 'ARGENTINA')
            )
            AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
    ) AS Shipping
GROUP BY
    s_nation,
    c_nation,
    year
ORDER BY
    s_nation,
    c_nation,
    year;