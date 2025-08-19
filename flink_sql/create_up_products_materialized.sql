CREATE TABLE IF NOT EXISTS  `Rakesh-Workspace`.`Upvest Demo`.`up_products_materialized` (
  `product_id` VARCHAR(2147483647) NOT NULL,
  `name` VARCHAR(2147483647) NOT NULL,
  `category` VARCHAR(2147483647) NOT NULL,
  `created_at` TIMESTAMP_LTZ(3) NOT NULL,
  WATERMARK FOR `created_at` as created_at,
  PRIMARY KEY (`product_id`) NOT ENFORCED
)
DISTRIBUTED BY HASH(`product_id`) INTO 3 BUCKETS
WITH (
  'changelog.mode' = 'upsert',
  'connector' = 'confluent',
  'scan.bounded.mode' = 'unbounded',
  'scan.startup.mode' = 'earliest-offset',
  'value.format' = 'proto-registry'
)