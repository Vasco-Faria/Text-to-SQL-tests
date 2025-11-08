SELECT
  SUM(l.l_extendedprice * (
    1 - l.l_discount
  )) / 7.0
FROM lineitem AS l
JOIN part AS p
  ON l.l_partkey = p.p_partkey
WHERE
  p.p_brand = 'Brand#23'
  AND p.p_container = 'SM CAN'
  AND l.l_quantity < (
    SELECT
      0.2 * avg(l2.l_quantity)
    FROM lineitem AS l2
    JOIN part AS p2
      ON l2.l_partkey = p2.p_partkey
    WHERE
      p2.p_brand = 'Brand#23'
      AND p2.p_container = 'SM CAN'
  );