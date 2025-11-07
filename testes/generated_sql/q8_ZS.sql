SELECT 
    (SELECT sum(l.l_extendedprice * (1 - l.l_discount)) 
     FROM lineitem l
     JOIN part p ON l.l_partkey = p.p_partkey
     JOIN nation n ON l.l_nationkey = n.n_nationkey
     JOIN region r ON n.n_regionkey = r.r_regionkey
     WHERE n.n_name = 'KENYA'
       AND r.r_name = 'AFRICA'
       AND p.p_type = 'ECONOMY PLATED BRASS'
       AND l.l_shipdate >= '1995-01-01'
       AND l.l_shipdate < '1996-01-01') 
    / 
    (SELECT sum(l.l_extendedprice * (1 - l.l_discount)) 
     FROM lineitem l
     JOIN part p ON l.l_partkey = p.p_partkey
     JOIN nation n ON l.l_nationkey = n.n_nationkey
     JOIN region r ON n.n_regionkey = r.r_regionkey
     WHERE r.r_name = 'AFRICA'
       AND p.p_type = 'ECONOMY PLATED BRASS'
       AND l.l_shipdate >= '1995-01-01'
       AND l.l_shipdate < '1996-01-01') 
    AS market_share_1995,
    
    (SELECT sum(l.l_extendedprice * (1 - l.l_discount)) 
     FROM lineitem l
     JOIN part p ON l.l_partkey = p.p_partkey
     JOIN nation n ON l.l_nationkey = n.n_nationkey
     JOIN region r ON n.n_regionkey = r.r_regionkey
     WHERE n.n_name = 'KENYA'
       AND r.r_name = 'AFRICA'
       AND p.p_type = 'ECONOMY PLATED BRASS'
       AND l.l_shipdate >= '1996-01-01'
       AND l.l_shipdate < '1997-01-01') 
    / 
    (SELECT sum(l.l_extendedprice * (1 - l.l_discount)) 
     FROM lineitem l
     JOIN part p ON l.l_partkey = p.p_partkey
     JOIN nation n ON l.l_nationkey = n.n_nationkey
     JOIN region r ON n.n_regionkey = r.r_regionkey
     WHERE r.r_name = 'AFRICA'
       AND p.p_type = 'ECONOMY PLATED BRASS'
       AND l.l_shipdate >= '1996-01-01'
       AND l.l_shipdate < '1997-01-01')
    AS market_share_1996;