SELECT p.p_partkey, SUM(ps.ps_supplycost * p.p_size * p.p_weight) AS value
FROM partsupp ps
JOIN supplier s ON ps.ps_suppkey = s.suppkey
JOIN nation n ON s.nationkey = n.nationkey
JOIN part p ON ps.ps_partkey = p.partkey
WHERE n.n_name = 'UNITED STATES'
GROUP BY p.p_partkey
HAVING SUM(ps.ps_supplycost * p.p_size * p.p_weight) >= (
  SELECT SUM(ps.ps_supplycost * p.p_size * p.p_weight) * 0.0001000000
  FROM partsupp ps
  JOIN supplier s ON ps.ps_suppkey = s.suppkey
  JOIN nation n ON s.nationkey = n.nationkey
  JOIN part p ON ps.ps_partkey = p.partkey
  WHERE n.n_name = 'UNITED STATES'
)
ORDER BY value DESC;