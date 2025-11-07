SELECT SUM(l_extendedprice * l_discount) AS revenue_increase
FROM lineitem
WHERE EXTRACT(YEAR FROM l_shipdate) = 1994
  AND l_discount BETWEEN 0.01 AND 0.03
  AND l_quantity < 25;