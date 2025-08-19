INSERT INTO `up_orders_stream`
SELECT
  `key`,
  `order_id`,
  `product_id`,
  `quantity`,
  TO_TIMESTAMP_LTZ(`order_timestamp`, 3) AS order_timestamp
FROM `up_orders`;