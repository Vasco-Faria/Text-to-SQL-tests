SELECT 
    S.acctbal, 
    S.name, 
    S.nation, 
    P.partkey, 
    P.mfgr, 
    S.address, 
    S.phone, 
    S.comment
FROM 
    Supplier S, 
    Parts P, 
    Partsupp PS
WHERE 
    P.size = 2 
    AND P.type LIKE '%TIN' 
    AND S.nation = 'ASIA' 
    AND PS.partkey = P.partkey 
    AND PS.supplier_no = S.supplier_no
    AND PS.supplycost = (
        SELECT 
            MIN(PS2.supplycost) 
        FROM 
            Partsupp PS2, 
            Supplier S2, 
            Parts P2, 
            Nation N2, 
            Region R2
        WHERE 
            P2.size = 2 
            AND P2.type LIKE '%TIN' 
            AND S2.nation = 'ASIA' 
            AND PS2.partkey = P2.partkey 
            AND PS2.supplier_no = S2.supplier_no
            AND S2.nation = N2.n_name 
            AND N2.regionkey = R2.regionkey 
            AND R2.r_name = 'ASIA'
    )
ORDER BY 
    S.acctbal DESC
LIMIT 100;