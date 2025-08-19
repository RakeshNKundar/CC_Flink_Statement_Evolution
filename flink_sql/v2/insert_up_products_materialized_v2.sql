INSERT INTO `up_products_materialized_v2`
SELECT
  product_id,
  name,
  description,
  category,
  TO_TIMESTAMP_LTZ(created_at, 3) as created_at
FROM
`up_products` /*+ OPTIONS(
        'scan.startup.mode' = 'specific-offsets',
        'scan.startup.specific-offsets' = '${confluent_flink_statement.up_products_materialized_insert.latest_offsets["up_products"]}'
    ) */;