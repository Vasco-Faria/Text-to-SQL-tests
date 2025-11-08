SELECT
  s_name
FROM supplier, orders, lineitem, nation
WHERE
  s_suppkey = l_suppkey
  AND o_orderkey = l_orderkey
  AND o_orderstatus = 'F'
  AND l_commitdate < l_shipdate
  AND s_nationkey = n_nationkey
  AND n_name = 'ETHIOPIA'
EXCEPT
SELECT
  s_name
FROM supplier, orders, lineitem, nation
WHERE
  s_suppkey = l_suppkey
  AND o_orderkey = l_orderkey
  AND o_orderstatus = 'F'
  AND l_commitdate < l_shipdate
  AND s_nationkey = n_nationkey
  AND n_name = 'ETHIOPIA'
  AND l_orderkey IN (
    SELECT
      l_orderkey
    FROM lineitem
    WHERE
      l_commitdate >= l_shipdate
  );