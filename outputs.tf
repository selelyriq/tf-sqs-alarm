output "oldest_message_age_alarm_id" {
  description = "ID of the ApproximateAgeOfOldestMessage alarm"
  value       = aws_cloudwatch_metric_alarm.oldest_message_age.id
}

output "oldest_message_age_alarm_arn" {
  description = "ARN of the ApproximateAgeOfOldestMessage alarm"
  value       = aws_cloudwatch_metric_alarm.oldest_message_age.arn
}

output "messages_visible_alarm_id" {
  description = "ID of the ApproximateNumberOfMessagesVisible alarm"
  value       = aws_cloudwatch_metric_alarm.messages_visible.id
}

output "messages_visible_alarm_arn" {
  description = "ARN of the ApproximateNumberOfMessagesVisible alarm"
  value       = aws_cloudwatch_metric_alarm.messages_visible.arn
}

output "messages_not_visible_alarm_id" {
  description = "ID of the ApproximateNumberOfMessagesNotVisible alarm"
  value       = aws_cloudwatch_metric_alarm.messages_not_visible.id
}

output "messages_not_visible_alarm_arn" {
  description = "ARN of the ApproximateNumberOfMessagesNotVisible alarm"
  value       = aws_cloudwatch_metric_alarm.messages_not_visible.arn
}

output "messages_sent_alarm_id" {
  description = "ID of the NumberOfMessagesSent alarm"
  value       = aws_cloudwatch_metric_alarm.messages_sent.id
}

output "messages_sent_alarm_arn" {
  description = "ARN of the NumberOfMessagesSent alarm"
  value       = aws_cloudwatch_metric_alarm.messages_sent.arn
}

output "all_alarm_arns" {
  description = "Map of all alarm ARNs created by this module"
  value = {
    oldest_message_age   = aws_cloudwatch_metric_alarm.oldest_message_age.arn
    messages_visible     = aws_cloudwatch_metric_alarm.messages_visible.arn
    messages_not_visible = aws_cloudwatch_metric_alarm.messages_not_visible.arn
    messages_sent        = aws_cloudwatch_metric_alarm.messages_sent.arn
  }
}
