WITH customer_orders AS (
    SELECT
        c.c_custkey,
        COUNT(o.o_orderkey) AS order_count
    FROM
        customer c
    LEFT JOIN
        orders o ON c.c_custkey = o.o_custkey
                   AND o.o_comment NOT LIKE '%unusual accounts%'
    GROUP BY
        c.c_custkey
)
SELECT
    order_count,
    COUNT(*) AS num_customers
FROM
    customer_orders
GROUP BY
    order_count
ORDER BY
    order_count;
