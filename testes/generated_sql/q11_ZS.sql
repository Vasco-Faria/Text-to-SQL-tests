WITH nation_stock AS (
    SELECT
        ps.ps_partkey,
        SUM(ps.ps_supplycost * ps.ps_availqty) AS value
    FROM
        partsupp ps
    JOIN
        supplier s ON ps.ps_suppkey = s.s_suppkey
    JOIN
        nation n ON s.s_nationkey = n.n_nationkey
    WHERE
        n.n_name = 'UNITED STATES'
    GROUP BY
        ps.ps_partkey
),
total_value AS (
    SELECT SUM(value) AS total FROM nation_stock
)
SELECT
    ps.partkey,
    ns.value
FROM
    nation_stock ns
JOIN
    partsupp ps ON ns.ps_partkey = ps.ps_partkey
CROSS JOIN
    total_value tv
WHERE
    ns.value > tv.total * 0.0001000000
ORDER BY
    ns.value DESC;
