CREATE TABLE IF NOT EXISTS up_orders_product_enriched (
  order_id VARCHAR(2147483647) NOT NULL,
  product_id VARCHAR(2147483647) NOT NULL,
  product_name VARCHAR(2147483647) NOT NULL,
  product_category  VARCHAR(2147483647) NOT NULL,
  order_timestamp TIMESTAMP_LTZ(3) NOT NULL,
  WATERMARK FOR order_timestamp AS order_timestamp
) DISTRIBUTED BY (order_id) INTO 3 BUCKETS 
WITH (
  'changelog.mode' = 'append',
  'connector' = 'confluent',
  'scan.bounded.mode' = 'unbounded',
  'scan.startup.mode' = 'earliest-offset',
  'value.format' = 'proto-registry'
);