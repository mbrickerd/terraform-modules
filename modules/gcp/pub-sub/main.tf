resource "google_pubsub_topic" "topic" {
  name                       = var.topic_name
  project                    = var.project_id
  labels                     = var.labels
  message_retention_duration = var.message_retention_duration
  kms_key_name               = var.kms_key_name

  dynamic "message_storage_policy" {
    for_each = var.message_storage_policy != null ? [var.message_storage_policy] : []
    content {
      allowed_persistence_regions = message_storage_policy.value.allowed_persistence_regions
    }
  }

  dynamic "schema_settings" {
    for_each = var.schema_settings != null ? [var.schema_settings] : []
    content {
      schema   = schema_settings.value.schema
      encoding = schema_settings.value.encoding
    }
  }
}

resource "google_pubsub_subscription" "subscriptions" {
  for_each = var.subscriptions

  name    = each.value.name
  topic   = google_pubsub_topic.topic.name
  project = var.project_id

  ack_deadline_seconds       = lookup(each.value, "ack_deadline_seconds", 10)
  retain_acked_messages      = lookup(each.value, "retain_acked_messages", false)
  message_retention_duration = lookup(each.value, "message_retention_duration", null)
  filter                     = lookup(each.value, "filter", null)

  dynamic "expiration_policy" {
    for_each = lookup(each.value, "expiration_policy_ttl", null) != null ? [each.value.expiration_policy_ttl] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = lookup(each.value, "dead_letter_policy", null) != null ? [each.value.dead_letter_policy] : []
    content {
      dead_letter_topic     = dead_letter_policy.value.dead_letter_topic
      max_delivery_attempts = lookup(dead_letter_policy.value, "max_delivery_attempts", 5)
    }
  }

  dynamic "retry_policy" {
    for_each = lookup(each.value, "retry_policy", null) != null ? [each.value.retry_policy] : []
    content {
      minimum_backoff = lookup(retry_policy.value, "minimum_backoff", null)
      maximum_backoff = lookup(retry_policy.value, "maximum_backoff", null)
    }
  }

  dynamic "push_config" {
    for_each = lookup(each.value, "push_config", null) != null ? [each.value.push_config] : []
    content {
      push_endpoint = push_config.value.push_endpoint

      dynamic "oidc_token" {
        for_each = lookup(push_config.value, "oidc_token", null) != null ? [push_config.value.oidc_token] : []
        content {
          service_account_email = oidc_token.value.service_account_email
          audience              = lookup(oidc_token.value, "audience", null)
        }
      }

      attributes = lookup(push_config.value, "attributes", null)
    }
  }

  depends_on = [google_pubsub_topic.topic]
}
