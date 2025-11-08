SELECT
  s.s_name
FROM supplier AS s
JOIN nation AS n
  ON s.s_nationkey = n.n_nationkey
JOIN partsupp AS ps
  ON s.s_suppkey = ps.ps_suppkey
JOIN part AS p
  ON ps.ps_partkey = p.p_partkey
WHERE
  p.p_name LIKE 'brown%'
  AND n.n_name = 'SAUDI ARABIA'
  AND ps.ps_availqty > (
    SELECT
      0.5 * SUM(l.l_quantity)
    FROM lineitem AS l
    JOIN orders AS o
      ON l.l_orderkey = o.o_orderkey
    JOIN customer AS c
      ON o.o_custkey = c.c_custkey
    WHERE
      l.l_partkey = ps.ps_partkey
      AND l.l_suppkey = s.s_suppkey
      AND o.o_orderdate BETWEEN DATE('1994-01-01') AND DATE('1994-12-31')
      AND c.c_nationkey = n.n_nationkey
  );