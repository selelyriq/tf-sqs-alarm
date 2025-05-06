variable "queue_name" {
  description = "Name of the SQS queue to monitor"
  type        = string
}

variable "alarm_prefix" {
  description = "Prefix for alarm names"
  type        = string
  default     = "SQS-Alarm"
}

variable "queue_arn" {
  description = "ARN of the SQS queue to monitor"
  type        = string
}

variable "alarm_actions" {
  description = "List of ARNs to notify when alarm transitions to ALARM state"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "List of ARNs to notify when alarm transitions to OK state"
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "List of ARNs to notify when alarm transitions to INSUFFICIENT_DATA state"
  type        = list(string)
  default     = []
}

variable "oldest_message_threshold_seconds" {
  description = "Threshold in seconds for ApproximateAgeOfOldestMessage alarm"
  type        = number
  default     = 3600 # 1 hour
}

variable "messages_visible_threshold" {
  description = "Threshold for ApproximateNumberOfMessagesVisible alarm"
  type        = number
  default     = 100
}

variable "messages_not_visible_threshold" {
  description = "Threshold for ApproximateNumberOfMessagesNotVisible alarm"
  type        = number
  default     = 100
}

variable "messages_sent_threshold" {
  description = "Threshold for NumberOfMessagesSent alarm (set to 0 to detect when no messages are being sent)"
  type        = number
  default     = 0
}

variable "evaluation_periods" {
  description = "Number of periods to evaluate for the alarm"
  type        = number
  default     = 2
}

variable "period" {
  description = "Duration in seconds over which the metric is evaluated"
  type        = number
  default     = 300 # 5 minutes
}

variable "namespace" {
  description = "The namespace for the CloudWatch metrics"
  type        = string
  default     = "AWS/SQS"
}

variable "datapoints_to_alarm" {
  description = "The number of datapoints within the evaluation period that must be breaching to trigger the alarm"
  type        = number
  default     = 2
}

variable "treat_missing_data" {
  description = "How to treat missing data when evaluating the alarm"
  type        = string
  default     = "missing"
  validation {
    condition     = contains(["missing", "ignore", "breaching", "notBreaching"], var.treat_missing_data)
    error_message = "Valid values are: missing, ignore, breaching, notBreaching."
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
