WITH shipped_parts AS (
    SELECT
        l.l_suppkey,
        l.l_partkey,
        SUM(l.l_quantity) AS qty_shipped
    FROM
        lineitem l
    JOIN
        supplier s ON l.l_suppkey = s.s_suppkey
    JOIN
        nation n ON s.s_nationkey = n.n_nationkey
    WHERE
        l.l_shipdate >= DATE '1994-01-01'
        AND l.l_shipdate < DATE '1995-01-01'
        AND n.n_name = 'SAUDI ARABIA'
        AND l.l_partkey IN (
            SELECT p_partkey FROM part WHERE p_name LIKE 'brown%'
        )
    GROUP BY
        l.l_suppkey,
        l.l_partkey
),
avg_shipped AS (
    SELECT
        l_suppkey,
        AVG(qty_shipped) AS avg_qty
    FROM
        shipped_parts
    GROUP BY
        l_suppkey
)
SELECT
    s.s_suppkey,
    s.s_name,
    sp.l_partkey,
    sp.qty_shipped
FROM
    shipped_parts sp
JOIN
    avg_shipped a ON sp.l_suppkey = a.l_suppkey
JOIN
    supplier s ON sp.l_suppkey = s.s_suppkey
WHERE
    sp.qty_shipped > 0.5 * a.avg_qty
ORDER BY
    s.s_suppkey,
    sp.l_partkey;
