SELECT supp_no, SUM(order_amt) AS total_revenue
FROM orders
WHERE order_date BETWEEN DATE '1997-01-01' AND DATE '1997-03-31'
GROUP BY supp_no
HAVING SUM(order_amt) = (
  SELECT MAX(total)
  FROM (
    SELECT supp_no, SUM(order_amt) AS total
    FROM orders
    WHERE order_date BETWEEN DATE '1997-01-01' AND DATE '1997-03-31'
    GROUP BY supp_no
  ) AS subquery
)
ORDER BY supp_no;