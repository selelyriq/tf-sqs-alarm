output "queue_name" {
  description = "Name of the created SQS queue"
  value       = aws_sqs_queue.example.name
}

output "queue_url" {
  description = "URL of the created SQS queue"
  value       = aws_sqs_queue.example.url
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alarm notifications"
  value       = aws_sns_topic.alarm_notifications.arn
}

output "all_alarm_arns" {
  description = "Map of all CloudWatch alarm ARNs"
  value       = module.sqs_alarms.all_alarm_arns
} 