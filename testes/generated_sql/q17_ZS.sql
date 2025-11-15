WITH avg_qty AS (
    SELECT
        AVG(l.l_quantity) AS avg_quantity
    FROM
        lineitem l
    JOIN
        part p ON l.l_partkey = p.p_partkey
    WHERE
        p.p_brand = 'Brand#23'
        AND p.p_container = 'SM CAN'
)
SELECT
    SUM(l.l_extendedprice) / 7 AS avg_yearly_loss
FROM
    lineitem l
JOIN
    part p ON l.l_partkey = p.p_partkey
CROSS JOIN
    avg_qty
WHERE
    p.p_brand = 'Brand#23'
    AND p.p_container = 'SM CAN'
    AND l.l_quantity < 0.2 * avg_qty.avg_quantity;
