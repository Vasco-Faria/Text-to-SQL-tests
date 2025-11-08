SELECT
  l_shipmode,
  SUM(CASE WHEN o_orderpriority = '1-URGENT' OR o_orderpriority = '2-HIGH' THEN 1 ELSE 0 END) AS high_line_count,
  SUM(CASE WHEN o_orderpriority <> '1-URGENT' AND o_orderpriority <> '2-HIGH' THEN 1 ELSE 0 END) AS low_line_count
FROM orders
JOIN customer
  ON o_custkey = c_custkey
JOIN lineitem
  ON l_orderkey = o_orderkey
WHERE
  c_mktsegment = 'FURNITURE'
  AND l_shipdate <= DATE('1995-03-27')
GROUP BY
  l_shipmode
ORDER BY
  l_shipmode;