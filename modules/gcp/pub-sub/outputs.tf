output "topic" {
  value       = google_pubsub_topic.topic
  description = "The created Pub/Sub topic resource."
}

output "topic_id" {
  value       = google_pubsub_topic.topic.id
  description = "The ID of the Pub/Sub topic."
}

output "topic_name" {
  value       = google_pubsub_topic.topic.name
  description = "The name of the Pub/Sub topic."
}

output "subscriptions" {
  value       = google_pubsub_subscription.subscriptions
  description = "Map of subscription resources created with the topic."
}

output "subscription_names" {
  value       = { for k, v in google_pubsub_subscription.subscriptions : k => v.name }
  description = "A map of subscription names created with the topic."
}
