WITH order_totals AS (
    SELECT
        o.o_orderkey,
        o.o_custkey,
        o.o_orderdate,
        SUM(l.l_quantity) AS total_quantity,
        SUM(l.l_extendedprice) AS total_price
    FROM
        orders o
    JOIN
        lineitem l ON o.o_orderkey = l.l_orderkey
    GROUP BY
        o.o_orderkey,
        o.o_custkey,
        o.o_orderdate
    HAVING
        SUM(l.l_quantity) > 14
)
SELECT
    c.c_name,
    c.c_custkey,
    ot.o_orderkey,
    ot.o_orderdate,
    ot.total_price,
    ot.total_quantity
FROM
    order_totals ot
JOIN
    customer c ON ot.o_custkey = c.c_
