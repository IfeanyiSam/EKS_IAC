variable "sns_topic_name" {
  description = "Name of the SNS topic for EKS alerts"
  type        = string
  default     = "EKS-Alerts"
}

variable "email_endpoint" {
  description = "Email address to subscribe to the SNS topic"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization threshold for alarm (percentage)"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Memory utilization threshold for alarm (percentage)"
  type        = number
  default     = 75
}

variable "evaluation_period" {
  description = "The evaluation period for the CloudWatch alarms in minutes"
  type        = number
  default     = 5
}

variable "autoscaling_group_name" {
  description = "Name of the AutoScaling Group to monitor"
  type        = string
}
