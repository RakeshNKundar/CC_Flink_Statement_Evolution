INSERT INTO up_orders_product_enriched_v2
SELECT 
  uo.order_id,
  up.product_id,
  up.name AS product_name,
  up.description,
  uo.unit_price,
  uo.quantity,
  up.category AS product_category,
  uo.order_timestamp
FROM `up_orders_stream_v2` AS uo
LEFT JOIN `up_products_materialized_v2`
FOR SYSTEM_TIME AS OF uo.order_timestamp AS up
ON uo.`product_id` = up.`product_id`;