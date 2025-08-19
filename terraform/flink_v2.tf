resource "confluent_flink_statement" "up_products_materialized_create_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-products-materialized-v2-create"
  statement =  file("${path.module}/../flink_sql/v2/create_up_products_materialized_v2.sql")

}

resource "confluent_flink_statement" "up_orders_stream_create_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-orders-stream-v2-create"
  statement =  file("${path.module}/../flink_sql/v2/create_up_orders_stream_v2.sql")

}

resource "confluent_flink_statement" "up_orders_more_than_10_quantities_create_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-orders-more-than-10-quantities-v2-create"
  statement =  file("${path.module}/../flink_sql/v2/create_up_orders_more_than_10_quantities_v2.sql")

}

resource "confluent_flink_statement" "orders_product_enriched_create_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "orders-product-enriched-v2-create"
  statement =  file("${path.module}/../flink_sql/v2/create_orders_product_enriched_v2.sql")

}

######### V2 INSERT QUERIES ##################

resource "confluent_flink_statement" "up_products_materialized_insert_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-products-materialized-v2-insert"
  statement =  <<-EOT
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
    EOT

  depends_on = [ confluent_flink_statement.up_products_materialized_create_v2 ]

}

resource "confluent_flink_statement" "up_orders_stream_insert_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-orders-stream-v2-insert"
  statement =  <<-EOT
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
  EOT

  depends_on = [ confluent_flink_statement.up_orders_stream_create_v2 ]

}

resource "confluent_flink_statement" "up_orders_more_than_10_quantities_insert_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name ="up-orders-more-than-10-quantities-v2-insert"
  statement =  <<-EOT
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
  EOT

  depends_on = [ confluent_flink_statement.up_orders_more_than_10_quantities_create_v2 ]

}

resource "confluent_flink_statement" "orders_product_enriched_insert_v2" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "orders-product-enriched-v2-insert"
  statement =  <<-EOT
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
    EOT

  depends_on = [ confluent_flink_statement.orders_product_enriched_create ]

}