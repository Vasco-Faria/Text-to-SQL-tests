SELECT COUNT(c.customer_id), o.ordercount
FROM customer c
LEFT JOIN (
    SELECT customer_id, COUNT(*) AS ordercount
    FROM orders
    WHERE NOT order_comment LIKE '%unusual accounts%'
    GROUP BY customer_id
) o ON c.customer_id = o.customer_id
GROUP BY o.ordercount
ORDER BY o.ordercount;