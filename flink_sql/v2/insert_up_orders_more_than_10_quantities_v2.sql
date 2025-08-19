INSERT INTO `Rakesh-Workspace`.`Upvest Demo`.`up_orders_more_than_10_quantities_v2`
SELECT 
  `key`,
  `order_id`,
  `product_id`,
  `quantity`,
  `unit_price`,
  `order_timestamp`
FROM
`Rakesh-Workspace`.`Upvest Demo`.`up_orders`  /*+ OPTIONS(
        'scan.startup.mode' = 'specific-offsets',
        'scan.startup.specific-offsets' = '${confluent_flink_statement.up_orders_stream_insert.latest_offsets["up_orders"]}'
    ) */
WHERE quantity > 10;