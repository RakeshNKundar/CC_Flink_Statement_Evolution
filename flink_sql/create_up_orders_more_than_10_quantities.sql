CREATE TABLE IF NOT EXISTS `Rakesh-Workspace`.`Upvest Demo`.`up_orders_more_than_10_quantities` (
  `key` VARBINARY(2147483647),
  `order_id` VARCHAR(2147483647) NOT NULL,
  `product_id` VARCHAR(2147483647) NOT NULL,
  `quantity` INT NOT NULL,
  `order_timestamp` BIGINT NOT NULL
)
DISTRIBUTED BY HASH(`key`) INTO 3 BUCKETS
WITH (
  'changelog.mode' = 'append',
  'connector' = 'confluent',
  'kafka.cleanup-policy' = 'delete',
  'kafka.compaction.time' = '0 ms',
  'kafka.max-message-size' = '2097164 bytes',
  'kafka.retention.size' = '0 bytes',
  'kafka.retention.time' = '7 d',
  'key.format' = 'raw',
  'scan.bounded.mode' = 'unbounded',
  'scan.startup.mode' = 'earliest-offset',
  'value.format' = 'proto-registry'
) 