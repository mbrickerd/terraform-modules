variable "project_id" {
  type        = string
  description = "The ID of the project where the Pub/Sub topic will be created."
}

variable "topic_name" {
  type        = string
  description = "The name of the Pub/Sub topic."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "A set of key/value label pairs to assign to the topic."
}

variable "message_retention_duration" {
  type        = string
  default     = null
  description = "Indicates the minimum duration to retain a message after it is published to the topic."
}

variable "kms_key_name" {
  type        = string
  default     = null
  description = "The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic."
}

variable "message_storage_policy" {
  type = object({
    allowed_persistence_regions = list(string)
  })
  default     = null
  description = "Policy constraining the set of Google Cloud Platform regions where messages published to the topic may be stored."
}

variable "schema_settings" {
  type = object({
    schema   = string
    encoding = string
  })
  default     = null
  description = "Settings for validating messages published against a schema."
}

variable "subscriptions" {
  type = map(object({
    name                       = string
    ack_deadline_seconds       = optional(number)
    retain_acked_messages      = optional(bool)
    message_retention_duration = optional(string)
    filter                     = optional(string)
    expiration_policy_ttl      = optional(string)
    dead_letter_policy = optional(object({
      dead_letter_topic     = string
      max_delivery_attempts = optional(number)
    }))
    retry_policy = optional(object({
      minimum_backoff = optional(string)
      maximum_backoff = optional(string)
    }))
    push_config = optional(object({
      push_endpoint = string
      attributes    = optional(map(string))
      oidc_token = optional(object({
        service_account_email = string
        audience              = optional(string)
      }))
    }))
  }))
  default     = {}
  description = "A map of subscription configurations to create for the topic."
}
