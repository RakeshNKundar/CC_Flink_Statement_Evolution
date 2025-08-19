data "confluent_organization" "sts" {}

data "confluent_environment" "rakesh_workspace_environment" {
  id = var.ENVIRONMENT_ID
}

# output "rakesh_workspace_environment" {
#   value = data.confluent_environment.rakesh_workspace_environment
# }


data "confluent_kafka_cluster" "upvest_demo" {
  id = var.CONFLUENT_KAFKA_CLUSTER_ID
  environment {
    id = data.confluent_environment.rakesh_workspace_environment.id
  }
}

