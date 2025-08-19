INSERT INTO `up_orders_stream_v2`
SELECT
  `key`,
  `order_id`,
  `product_id`,
  `quantity`,
  `unit_price`,
  TO_TIMESTAMP_LTZ(`order_timestamp`, 3) AS order_timestamp
FROM `up_orders` /*+ OPTIONS(
        'scan.startup.mode' = 'specific-offsets',
        'scan.startup.specific-offsets' = '${confluent_flink_statement.up_orders_stream_insert.latest_offsets["up_orders"]}'
    ) */;