# SNS Topic for Notifications
resource "aws_sns_topic" "eks_alerts" {
  name = var.sns_topic_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }
        Action = "SNS:Publish"
        Resource = "*"
      }
    ]
  })
}

# Subscription to SNS Topic
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.eks_alerts.arn
  protocol  = "email"
  endpoint  = var.email_endpoint
}

# CloudWatch Metric Alarm for High CPU Utilization
resource "aws_cloudwatch_metric_alarm" "high_cpu_usage" {
  alarm_name          = "HighCPUUsage"
  alarm_description   = "Alert when CPU utilization exceeds ${var.cpu_threshold}% for ${var.evaluation_period} minutes"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  period              = var.evaluation_period * 60
  evaluation_periods  = 1
  threshold           = var.cpu_threshold
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  alarm_actions = [aws_sns_topic.eks_alerts.arn]
}

# CloudWatch Metric Alarm for High Memory Utilization
resource "aws_cloudwatch_metric_alarm" "high_memory_usage" {
  alarm_name          = "HighMemoryUsage"
  alarm_description   = "Alert when Memory utilization exceeds ${var.memory_threshold}% for ${var.evaluation_period} minutes"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  statistic           = "Average"
  period              = var.evaluation_period * 60
  evaluation_periods  = 1
  threshold           = var.memory_threshold
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  alarm_actions = [aws_sns_topic.eks_alerts.arn]
}
