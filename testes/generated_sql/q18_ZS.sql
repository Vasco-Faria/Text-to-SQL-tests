SELECT c.customer_name, c.customer_key, o.order_key, o.order_date, o.total_price, o.quantity 
FROM customers c 
INNER JOIN orders o ON c.customer_key = o.customer_key 
WHERE o.quantity > 14 
ORDER BY o.quantity DESC 
LIMIT 100;