terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
resource "aws_cloudwatch_metric_alarm" "oldest_message_age" {
  alarm_name                = "${var.alarm_prefix}-${var.queue_name}-OldestMessageAge"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = "Maximum"
  threshold                 = var.oldest_message_threshold_seconds
  alarm_description         = "Alarm when the oldest message in the ${var.queue_name} queue exceeds ${var.oldest_message_threshold_seconds} seconds"
  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions
  treat_missing_data        = var.treat_missing_data
  datapoints_to_alarm       = var.datapoints_to_alarm

  dimensions = {
    QueueName = var.queue_name
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "messages_visible" {
  alarm_name                = "${var.alarm_prefix}-${var.queue_name}-MessagesVisible"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = "Maximum"
  threshold                 = var.messages_visible_threshold
  alarm_description         = "Alarm when the number of visible messages in the ${var.queue_name} queue exceeds ${var.messages_visible_threshold}"
  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions
  treat_missing_data        = var.treat_missing_data
  datapoints_to_alarm       = var.datapoints_to_alarm

  dimensions = {
    QueueName = var.queue_name
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "messages_not_visible" {
  alarm_name                = "${var.alarm_prefix}-${var.queue_name}-MessagesNotVisible"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "ApproximateNumberOfMessagesNotVisible"
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = "Maximum"
  threshold                 = var.messages_not_visible_threshold
  alarm_description         = "Alarm when the number of in-flight messages in the ${var.queue_name} queue exceeds ${var.messages_not_visible_threshold}"
  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions
  treat_missing_data        = var.treat_missing_data
  datapoints_to_alarm       = var.datapoints_to_alarm

  dimensions = {
    QueueName = var.queue_name
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "messages_sent" {
  alarm_name                = "${var.alarm_prefix}-${var.queue_name}-MessagesSent"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.evaluation_periods
  metric_name               = "NumberOfMessagesSent"
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = "Sum"
  threshold                 = var.messages_sent_threshold
  alarm_description         = "Alarm when the number of messages sent to the ${var.queue_name} queue is less than or equal to ${var.messages_sent_threshold} (indicates possible producer issues)"
  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions
  treat_missing_data        = var.treat_missing_data
  datapoints_to_alarm       = var.datapoints_to_alarm

  dimensions = {
    QueueName = var.queue_name
  }

  tags = var.tags
}
