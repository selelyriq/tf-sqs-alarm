# Terraform AWS SQS CloudWatch Alarms Module

This Terraform module creates CloudWatch alarms for Amazon SQS queues based on AWS best practices. The module creates alarms for the following metrics:

- `ApproximateAgeOfOldestMessage` - Alerts when the oldest message in the queue exceeds a specified age threshold
- `ApproximateNumberOfMessagesVisible` - Alerts when the number of messages in the queue exceeds a specified threshold
- `ApproximateNumberOfMessagesNotVisible` - Alerts when the number of in-flight messages exceeds a specified threshold
- `NumberOfMessagesSent` - Alerts when the number of messages sent to the queue is less than or equal to a specified threshold (useful for detecting producer issues)

## Usage

```hcl
module "sqs_alarms" {
  source = "path/to/module"

  queue_name = "my-sqs-queue"
  queue_arn  = "arn:aws:sqs:us-east-1:123456789012:my-sqs-queue"
  
  alarm_actions = ["arn:aws:sns:us-east-1:123456789012:my-sns-topic"]
  
  # Optional: Customize thresholds
  oldest_message_threshold_seconds = 3600  # 1 hour
  messages_visible_threshold       = 100
  messages_not_visible_threshold   = 100
  messages_sent_threshold          = 0     # Alert when no messages are sent
  
  # Optional: Customize alarm evaluation
  evaluation_periods  = 2
  period              = 300  # 5 minutes
  datapoints_to_alarm = 2
  treat_missing_data  = "missing"
  
  tags = {
    Environment = "production"
    Owner       = "team-name"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| queue_name | Name of the SQS queue to monitor | `string` | n/a | yes |
| queue_arn | ARN of the SQS queue to monitor | `string` | n/a | yes |
| alarm_prefix | Prefix for alarm names | `string` | `"SQS-Alarm"` | no |
| alarm_actions | List of ARNs to notify when alarm transitions to ALARM state | `list(string)` | `[]` | no |
| ok_actions | List of ARNs to notify when alarm transitions to OK state | `list(string)` | `[]` | no |
| insufficient_data_actions | List of ARNs to notify when alarm transitions to INSUFFICIENT_DATA state | `list(string)` | `[]` | no |
| oldest_message_threshold_seconds | Threshold in seconds for ApproximateAgeOfOldestMessage alarm | `number` | `3600` | no |
| messages_visible_threshold | Threshold for ApproximateNumberOfMessagesVisible alarm | `number` | `100` | no |
| messages_not_visible_threshold | Threshold for ApproximateNumberOfMessagesNotVisible alarm | `number` | `100` | no |
| messages_sent_threshold | Threshold for NumberOfMessagesSent alarm (set to 0 to detect when no messages are being sent) | `number` | `0` | no |
| evaluation_periods | Number of periods to evaluate for the alarm | `number` | `2` | no |
| period | Duration in seconds over which the metric is evaluated | `number` | `300` | no |
| namespace | The namespace for the CloudWatch metrics | `string` | `"AWS/SQS"` | no |
| datapoints_to_alarm | The number of datapoints within the evaluation period that must be breaching to trigger the alarm | `number` | `2` | no |
| treat_missing_data | How to treat missing data when evaluating the alarm | `string` | `"missing"` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| oldest_message_age_alarm_id | ID of the ApproximateAgeOfOldestMessage alarm |
| oldest_message_age_alarm_arn | ARN of the ApproximateAgeOfOldestMessage alarm |
| messages_visible_alarm_id | ID of the ApproximateNumberOfMessagesVisible alarm |
| messages_visible_alarm_arn | ARN of the ApproximateNumberOfMessagesVisible alarm |
| messages_not_visible_alarm_id | ID of the ApproximateNumberOfMessagesNotVisible alarm |
| messages_not_visible_alarm_arn | ARN of the ApproximateNumberOfMessagesNotVisible alarm |
| messages_sent_alarm_id | ID of the NumberOfMessagesSent alarm |
| messages_sent_alarm_arn | ARN of the NumberOfMessagesSent alarm |
| all_alarm_arns | Map of all alarm ARNs created by this module |

## License

This module is licensed under the MIT License. # tf-sqs-alarm
