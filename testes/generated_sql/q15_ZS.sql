WITH supplier_revenue AS (
    SELECT
        s.s_suppkey,
        s.s_name,
        SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
    FROM
        supplier s
    JOIN
        lineitem l ON s.s_suppkey = l.l_suppkey
    JOIN
        orders o ON l.l_orderkey = o.o_orderkey
    WHERE
        l.l_shipdate >= DATE '1997-01-01'
        AND l.l_shipdate < DATE '1997-01-01' + INTERVAL '3 months'
    GROUP BY
        s.s_suppkey,
        s.s_name
)
SELECT
    s_suppkey,
    s_name,
    revenue
FROM
    supplier_revenue
WHERE
    revenue = (SELECT MAX(revenue) FROM supplier_revenue)
ORDER BY
    s_suppkey;
