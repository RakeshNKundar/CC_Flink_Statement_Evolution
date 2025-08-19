variable "CC_CLOUD_API_KEY" {
  type        = string
  description = "Cloud API Key of Confluent Cloud"
  default     = "CCK5Q77C75YTGUUP"
}

variable "CC_CLOUD_API_SECRET" {
  type        = string
  description = "Cloud API Key of Confluent Cloud"
  default     = "cfltI7LnKtX+p/DdDnnyK1HgIecsN9s8B2YBU+YeJgr/Rox43aBJvCHfTxFKcfNg"
}

variable "CLOUD_PROVIDER" {
  type        = string
  description = "Cloud Provider Name"
  default     = "AWS"
}

variable "REGION" {
  type        = string
  description = "Region within confluent cloud aws csp"
  default     = "us-east-2"
}

variable "ENVIRONMENT_ID" {
  type        = string
  description = "Environment ID of the Workspace"
  default     = "env-21zqrq"
}

variable "SCHEMA_REGISTRY_ID" {
  type        = string
  description = "Environment ID of the Workspace"
  default     = "lsrc-zzx6m0"
}

variable "SCHEMA_REGISTRY_REST_ENDPOINT" {
  type        = string
  description = "Environment ID of the Workspace"
  default     = "https://psrc-l622j.us-east-2.aws.confluent.cloud"
}

variable "SCHEMA_REGISTRY_API_KEY" {
  type        = string
  description = "Environment ID of the Workspace"
  default     = "HHR5UEOLD6M3WBUO"
}

variable "SCHEMA_REGISTRY_API_SECRET" {
  type        = string
  description = "Environment ID of the Workspace"
  default     = "lxTYZtlPST1Nafwp/gnkhq4nLxUTcX1SBldc6Brp+ibhIUCitRcdf6HekNYm/yD+"
}

variable "CONFLUENT_KAFKA_CLUSTER_ID" {
  type        = string
  description = "Kafka Cluster ID"
  default     = "lkc-z7zrjz"
}

variable "KAFKA_API_KEY" {
  type        = string
  description = "Kafka API Key"
  default     = "N4SBJ4A6VPXBSVJJ"
}

variable "KAFKA_API_SECRET" {
  type        = string
  description = "Kafka API Secret"
  default     = "cfltq5baoqKJiSbUhWm80kWZOfA/iC6MPkwt2uN7u4xVzJElWsqFKTMJRu45A64g"
}

variable "FLINK_API_KEY" {
  type        = string
  description = "Flink API Key"
  default     = "6JTLEYTLTYR62HQJ"
}

variable "FLINK_API_SECRET" {
  type        = string
  description = "Flink API Secret"
  default     = "cflttya1Ex26vdN4KTyMCEU6udDLmA7cCYqE4xNvETKrN/iEH3YbplS3sMYdtkpQ"
}

variable "FLINK_COMPUTE_POOL_ID" {
  type        = string
  description = "Flink Compute pool Id"
  default     = "lfcp-vmzvvn"
}

variable "CC_USER_ID" {
  type        = string
  description = "CC user id"
  default     = "u-mnrgm2"
}

variable "CC_ORGANIZATION_ID" {
  type        = string
  description = "CC Organization ID"
  default     = "5f242057-6c74-4ba5-9942-60d363203b93"
}

variable "CC_FLINK_REST_ENDPOINT" {
  type        = string
  description = "CC Flink REST Endpoint"
  default     = "https://flink.us-east-2.aws.confluent.cloud"
}


