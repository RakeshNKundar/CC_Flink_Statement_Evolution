data "confluent_flink_compute_pool" "upvest_compute_pool" {
  id = var.FLINK_COMPUTE_POOL_ID
  environment {
    id = data.confluent_environment.rakesh_workspace_environment.id
  }
}

data "confluent_flink_region" "flink_region" {
  cloud   = var.CLOUD_PROVIDER
  region  = var.REGION
}

data "confluent_user" "rakesh" {
  id = var.CC_USER_ID
}

resource "confluent_flink_statement" "up_products_materialized_create" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-products-materialized-create"
  statement =  file("${path.module}/../flink_sql/create_up_products_materialized.sql")
  
}

resource "confluent_flink_statement" "up_products_materialized_insert" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-products-materialized-insert"
  statement =  file("${path.module}/../flink_sql/insert_up_products_materialized.sql")

  stopped = false

  depends_on = [ confluent_flink_statement.up_products_materialized_insert ]

}

resource "confluent_flink_statement" "up_orders_stream_create" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-orders-stream-create"
  statement =  file("${path.module}/../flink_sql/create_up_orders_stream.sql")

}

resource "confluent_flink_statement" "up_orders_stream_insert" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-orders-stream-insert"
  statement =  file("${path.module}/../flink_sql/insert_up_orders_stream.sql")

  stopped = false

  depends_on = [ confluent_flink_statement.up_orders_stream_create ]

}

resource "confluent_flink_statement" "up_orders_more_than_10_quantities_create" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "up-orders-more-than-10-quantities-create"
  statement =  file("${path.module}/../flink_sql/create_up_orders_more_than_10_quantities.sql")

}

resource "confluent_flink_statement" "up_orders_more_than_10_quantities_insert" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name ="up-orders-more-than-10-quantities-insert"
  statement =  file("${path.module}/../flink_sql/insert_up_orders_more_than_10_quantities.sql")

  stopped = false

  depends_on = [ confluent_flink_statement.up_orders_more_than_10_quantities_create ]

}

resource "confluent_flink_statement" "orders_product_enriched_create" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name = "orders-product-enriched-create"
  statement =  file("${path.module}/../flink_sql/create_orders_product_enriched.sql")

}

resource "confluent_flink_statement" "orders_product_enriched_insert" {
  properties = {
    "sql.current-catalog"  = data.confluent_environment.rakesh_workspace_environment.display_name
    "sql.current-database" = data.confluent_kafka_cluster.upvest_demo.display_name
  }
  statement_name =  "orders-product-enriched-insert"
  statement =  file("${path.module}/../flink_sql/insert_orders_product_enriched.sql")

  stopped = false

  depends_on = [ confluent_flink_statement.orders_product_enriched_create ]

}

