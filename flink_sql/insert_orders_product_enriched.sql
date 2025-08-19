INSERT INTO up_orders_product_enriched
SELECT 
  uo.order_id,
  up.product_id,
  up.name AS product_name,
  up.category AS product_category,
  uo.order_timestamp
FROM `up_orders_stream` AS uo
LEFT JOIN `up_products_materialized`
FOR SYSTEM_TIME AS OF uo.order_timestamp AS up
ON uo.`product_id` = up.`product_id`;