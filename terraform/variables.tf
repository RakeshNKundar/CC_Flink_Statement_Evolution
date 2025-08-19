variable "CC_CLOUD_API_KEY" {
  type        = string
  description = "Cloud API Key of Confluent Cloud"
}

variable "CC_CLOUD_API_SECRET" {
  type        = string
  description = "Cloud API Key of Confluent Cloud"
}

variable "CLOUD_PROVIDER" {
  type        = string
  description = "Cloud Provider Name"
}

variable "REGION" {
  type        = string
  description = "Region within confluent cloud aws csp"
}

variable "ENVIRONMENT_ID" {
  type        = string
  description = "Environment ID of the Workspace"
}

variable "SCHEMA_REGISTRY_ID" {
  type        = string
  description = "Schema Registry ID on Confluent Cloud"
}

variable "SCHEMA_REGISTRY_REST_ENDPOINT" {
  type        = string
  description = "Environment ID of the Workspace"
}

variable "SCHEMA_REGISTRY_API_KEY" {
  type        = string
  description = "Environment ID of the Workspace"
}

variable "SCHEMA_REGISTRY_API_SECRET" {
  type        = string
  description = "Environment ID of the Workspace"
}

variable "CONFLUENT_KAFKA_CLUSTER_ID" {
  type        = string
  description = "Kafka Cluster ID"
}

variable "KAFKA_API_KEY" {
  type        = string
  description = "Kafka API Key"
}

variable "KAFKA_API_SECRET" {
  type        = string
  description = "Kafka API Secret"
}

variable "FLINK_API_KEY" {
  type        = string
  description = "Flink API Key"
}

variable "FLINK_API_SECRET" {
  type        = string
  description = "Flink API Secret"
}

variable "FLINK_COMPUTE_POOL_ID" {
  type        = string
  description = "Flink Compute pool Id"
}

variable "CC_USER_ID" {
  type        = string
  description = "CC user id"
}

variable "CC_ORGANIZATION_ID" {
  type        = string
  description = "CC Organization ID"
}

variable "CC_FLINK_REST_ENDPOINT" {
  type        = string
  description = "CC Flink REST Endpoint"
}


