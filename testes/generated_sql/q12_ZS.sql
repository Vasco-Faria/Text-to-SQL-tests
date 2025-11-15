SELECT
    l_shipmode,
    SUM(CASE WHEN o_orderpriority IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS high_line_count,
    SUM(CASE WHEN o_orderpriority NOT IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS low_line_count
FROM
    lineitem l
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
WHERE
    l.l_shipmode IN ('FOB', 'MAIL')
    AND l.l_shipdate >= DATE '1996-01-01'
    AND l.l_shipdate < DATE '1996-01-01' + INTERVAL '1 year'
    AND l.l_receiptdate > l.l_commitdate
GROUP BY
    l_shipmode
ORDER BY
    l_shipmode;
