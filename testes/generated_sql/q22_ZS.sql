SELECT count(*)
FROM customer
WHERE substr(c_phone, 1, 2) IN ('30', '31', '28', '21', '26', '33', '10')
AND NOT EXISTS (
    SELECT 1
    FROM orders
    WHERE o_custkey = c_custkey
    AND o_orderdate >= date('now', '-7 years')
)
AND c_acctbal > (SELECT avg(c_acctbal) FROM customer);