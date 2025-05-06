provider "aws" {
  region = "us-east-1"
}

# Example SQS Queue for demonstration
resource "aws_sqs_queue" "example" {
  name = "example-queue"

  # Optional: Set up queue parameters
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400  # 1 day
  max_message_size           = 262144 # 256 KB
  delay_seconds              = 0

  tags = {
    Environment = "example"
  }
}

# Create an SNS topic for alarm notifications
resource "aws_sns_topic" "alarm_notifications" {
  name = "sqs-alarm-notifications"
}

# Example email subscription for the SNS topic (requires confirmation)
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = "your-email@example.com" # Replace with your email
}

# Apply the SQS CloudWatch Alarms module
module "sqs_alarms" {
  source = "../../" # Path to the module

  queue_name = aws_sqs_queue.example.name
  queue_arn  = aws_sqs_queue.example.arn

  # Send alarm notifications to the SNS topic
  alarm_actions = [aws_sns_topic.alarm_notifications.arn]
  ok_actions    = [aws_sns_topic.alarm_notifications.arn]

  # Customize thresholds for this example
  oldest_message_threshold_seconds = 1800 # 30 minutes
  messages_visible_threshold       = 50
  messages_not_visible_threshold   = 25
  messages_sent_threshold          = 0 # Alert when no messages are sent

  tags = {
    Environment = "example"
    Module      = "sqs-alarms"
  }
} 