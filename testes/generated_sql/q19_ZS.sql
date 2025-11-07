SELECT SUM(l_extendedprice * l_discount) AS gross_discounted_revenue
FROM lineitem l
JOIN part p ON l.partkey = p.partkey
WHERE p.container = 'MED BOX'
  AND p.size BETWEEN 1 AND 30
  AND (p.brand = 'Brand#11' OR p.brand = 'Brand#25' OR p.brand = 'Brand#54')
  AND l.shipmethod = 'AIR'
  AND l.delivery = 'in person';