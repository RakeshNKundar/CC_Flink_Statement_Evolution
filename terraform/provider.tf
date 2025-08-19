terraform {
  required_version = ">= 1.10.4"

  required_providers {

    confluent = {
      source  = "confluentinc/confluent"
      version = "2.36.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.CC_CLOUD_API_KEY    # optionally use CONFLUENT_CLOUD_API_KEY env var
  cloud_api_secret = var.CC_CLOUD_API_SECRET # optionally use CONFLUENT_CLOUD_API_SECRET env var

  organization_id       = var.CC_ORGANIZATION_ID            # optionally use CONFLUENT_ORGANIZATION_ID env var
  environment_id        = var.ENVIRONMENT_ID             # optionally use CONFLUENT_ENVIRONMENT_ID env var
  flink_compute_pool_id = var.FLINK_COMPUTE_POOL_ID      # optionally use FLINK_COMPUTE_POOL_ID env var
  flink_rest_endpoint   = var.CC_FLINK_REST_ENDPOINT        # optionally use FLINK_REST_ENDPOINT env var
  flink_api_key         = var.FLINK_API_KEY              # optionally use FLINK_API_KEY env var
  flink_api_secret      = var.FLINK_API_SECRET           # optionally use FLINK_API_SECRET env var
  flink_principal_id    = var.CC_USER_ID         # optionally use FLINK_PRINCIPAL_ID env var
}