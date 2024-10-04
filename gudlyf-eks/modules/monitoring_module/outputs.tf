output "sns_topic_arn" {
  description = "The ARN of the SNS topic for EKS alerts"
  value       = aws_sns_topic.eks_alerts.arn
}

output "sns_subscription_arn" {
  description = "The ARN of the email subscription to the SNS topic"
  value       = aws_sns_topic_subscription.email.arn
}
