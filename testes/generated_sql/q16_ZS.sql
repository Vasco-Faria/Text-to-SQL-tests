SELECT COUNT(DISTINCT ps.ps_suppkey)
FROM partsupp ps
JOIN part p ON ps.ps_partkey = p.p_partkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
WHERE p.p_brand <> 'Brand#42'
AND p.p_type NOT LIKE 'LARGE PLATED%'
AND p.p_size IN (9, 7, 14, 41, 43, 38, 23, 34);