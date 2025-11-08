SELECT
    c.name,
    c.custkey,
    o.orderkey,
    o.orderdate,
    o.totalprice,
    l.quantity
FROM
    customer c
JOIN
    orders o ON c.custkey = o.custkey
JOIN
    lineitem l ON o.orderkey = l.orderkey
WHERE
    l.quantity > 14
ORDER BY
    l.quantity DESC
LIMIT 100;