WITH late_suppliers AS (
    SELECT
        l.l_orderkey,
        l.l_suppkey
    FROM
        lineitem l
    JOIN
        supplier s ON l.l_suppkey = s.s_suppkey
    JOIN
        nation n ON s.s_nationkey = n.n_nationkey
    WHERE
        n.n_name = 'ETHIOPIA'
        AND l.l_receiptdate > l.l_commitdate
),
multi_supplier_orders AS (
    SELECT
        l_orderkey
    FROM
        lineitem
    GROUP BY
        l_orderkey
    HAVING
        COUNT(DISTINCT l_suppkey) > 1
),
only_late AS (
    SELECT
        ls.l_suppkey,
        ls.l_orderkey
    FROM
        late_suppliers ls
    JOIN
        multi_supplier_orders mso ON ls.l_orderkey = mso.l_orderkey
    GROUP BY
        ls.l_orderkey,
        ls.l_suppkey
    HAVING
        COUNT(*) = 1
)
SELECT
    s.s_suppkey,
    s.s_name,
    n.n_name AS nation
FROM
    only_late ol
JOIN
    supplier s ON ol.l_suppkey = s.s_suppkey
JOIN
    nation n ON s.s_nationkey = n.n_nationkey
ORDER BY
    s.s_suppkey;
