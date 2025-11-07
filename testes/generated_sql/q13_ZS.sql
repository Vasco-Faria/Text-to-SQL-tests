WITH customer_order_counts AS (
    SELECT 
        c.customer_id,
        COUNT(o.order_id) AS order_count
    FROM 
        customers c
    LEFT JOIN 
        orders o ON c.customer_id = o.customer_id
            AND o.comment NOT LIKE '% unusual accounts %'
    GROUP BY 
        c.customer_id
)
SELECT 
    order_count,
    COUNT(customer_id) AS customer_distribution
FROM 
    customer_order_counts
GROUP BY 
    order_count
ORDER BY 
    order_count;