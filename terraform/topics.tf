resource "confluent_kafka_topic" "up_orders" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.upvest_demo.id
  }
  topic_name       = "up_orders"
  rest_endpoint    = data.confluent_kafka_cluster.upvest_demo.rest_endpoint
  partitions_count = 3

  credentials {
    key    = var.KAFKA_API_KEY
    secret = var.KAFKA_API_SECRET
  }

  depends_on = [data.confluent_kafka_cluster.upvest_demo]
}

resource "confluent_kafka_topic" "up_products" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.upvest_demo.id
  }
  topic_name       = "up_products"
  rest_endpoint    = data.confluent_kafka_cluster.upvest_demo.rest_endpoint
  partitions_count = 3

  credentials {
    key    = var.KAFKA_API_KEY
    secret = var.KAFKA_API_SECRET
  }

  depends_on = [data.confluent_kafka_cluster.upvest_demo]
}


