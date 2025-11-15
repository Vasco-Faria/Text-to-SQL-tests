WITH avg_acctbal AS (
    SELECT AVG(c_acctbal) AS avg_balance
    FROM customer
    WHERE c_acctbal > 0
)
SELECT
    COUNT(*) AS num_customers,
    SUM(c_acctbal) AS total_acctbal
FROM
    customer c
CROSS JOIN
    avg_acctbal a
WHERE
    SUBSTRING(c.c_phone, 1, 2) IN ('30', '31', '28', '21', '26', '33', '10')
    AND c.c_acctbal > a.avg_balance
    AND NOT EXISTS (
        SELECT 1
        FROM orders o
        WHERE o.o_custkey = c.c_custkey
          AND o.o_orderdate >= CURRENT_DATE - INTERVAL '7 years'
    );
