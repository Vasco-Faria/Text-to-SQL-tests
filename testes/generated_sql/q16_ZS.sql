SELECT 
    s.s_suppkey, 
    COUNT(p.p_partkey) AS count
FROM 
    Supplier s
JOIN 
    Parts_Supplier ps ON s.s_suppkey = ps.ps_suppkey
JOIN 
    Part p ON ps.ps_partkey = p.p_partkey
WHERE 
    p.p_brand NOT LIKE 'Brand#42'
    AND p.p_type LIKE 'LARGE PLATED%'
    AND p.p_size IN (9, 7, 14, 41, 43, 38, 23, 34)
    AND s.s_complaints IS NULL
GROUP BY 
    s.s_suppkey, 
    p.p_brand, 
    p.p_type, 
    p.p_size
ORDER BY 
    count DESC, 
    p.p_brand ASC, 
    p.p_type ASC, 
    p.p_size ASC;