SELECT
  S.acctbal,
  S.name,
  N.name,
  P.partkey,
  P.mfgr,
  S.address,
  S.phone,
  S.comment
FROM Part AS P
JOIN PartSupp AS PS
  ON P.partkey = PS.partkey
JOIN Supplier AS S
  ON PS.suppkey = S.suppkey
JOIN Nation AS N
  ON S.nationkey = N.nationkey
JOIN Region AS R
  ON N.regionkey = R.regionkey
WHERE
  P.size = 2
  AND P.type LIKE '%TIN'
  AND R.name = 'ASIA'
  AND PS.supplycost = (
    SELECT
      MIN(PS2.supplycost)
    FROM PartSupp AS PS2
    JOIN Supplier AS S2
      ON PS2.suppkey = S2.suppkey
    JOIN Nation AS N2
      ON S2.nationkey = N2.nationkey
    JOIN Region AS R2
      ON N2.regionkey = R2.regionkey
    WHERE
      PS2.partkey = P.partkey
      AND R2.name = 'ASIA'
  )
  AND S.acctbal IN (
    SELECT
      S3.acctbal
    FROM Supplier AS S3
    JOIN Nation AS N3
      ON S3.nationkey = N3.nationkey
    JOIN Region AS R3
      ON N3.regionkey = R3.regionkey
    WHERE
      R3.name = 'ASIA'
    ORDER BY
      S3.acctbal DESC
    LIMIT 100
  )
ORDER BY
  S.acctbal DESC,
  S.name;