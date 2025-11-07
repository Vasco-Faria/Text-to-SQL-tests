WITH part_avg AS (
  SELECT p.p_type, p.p_size, AVG(ps.ps_availqty) as avg_qty
  FROM part p
  JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
  WHERE p.p_name LIKE 'brown%'
  GROUP BY p.p_type, p.p_size
)
SELECT s.s_name, p.p_name, ps.ps_availqty
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN part p ON ps.ps_partkey = p.p_partkey
WHERE n.n_name = 'SAUDI ARABIA'
AND p.p_name LIKE 'brown%'
AND ps.ps_availqty > (SELECT 1.5 * avg_qty FROM part_avg pa WHERE pa.p_type = p.p_type AND pa.p_size = p.p_size);