INSERT INTO `up_products_materialized`
SELECT
  product_id,
  name,
  category,
  TO_TIMESTAMP_LTZ(created_at, 3) as created_at
FROM
`up_products`;