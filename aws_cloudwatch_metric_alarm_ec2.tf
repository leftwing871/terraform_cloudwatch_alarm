//CPUUtilization
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_ec2_NamingRule_ec2_CPUUtilization" {
  count   = length(var.InstanceId)
  
  alarm_name                = "NamingRule_${var.InstanceId[count.index]}_ec2_CPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  /*
    https://selleo.com/til/posts/l5ugt5xxbz-handling-missing-data-points-in-aws-metrics
    notBreaching – Missing data points are treated as “good” and within the threshold
    breaching – Missing data points are treated as “bad” and breaching the threshold
    ignore – The current alarm state is maintained
    missing – If all data points in the alarm evaluation range are missing, the alarm transitions to INSUFFICIENT_DATA.
  */
  
  actions_enabled     = "true"
  alarm_actions       = ["${var.alarm_action_sns_arn}"]

  dimensions = {
        InstanceId = "${var.InstanceId[count.index]}"
  }
  
  tags = {
    Name = "${var.InstanceId[count.index]}.CPUUtilization"
  }

}


//StatusCheckFailed
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_ec2_NamingRule_ec2_StatusCheckFailed" {
  count                     = length(var.InstanceId)
  alarm_name                = "NamingRule_${var.InstanceId[count.index]}_ec2_StatusCheckFailed"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "1"
  alarm_description         = "This metric monitors ec2 StatusCheckFailed"
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  
  actions_enabled     = "true"
  alarm_actions       = ["${var.alarm_action_sns_arn}"]

  dimensions = {
        InstanceId = "${var.InstanceId[count.index]}"
  }
  
  tags = {
    Name = "${var.InstanceId[count.index]}.StatusCheckFailed"
  }

}


//Memory
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_ec2_NamingRule_ec2_memory" {
  count   = length(var.InstanceId)
  alarm_name = "NamingRule_${var.InstanceId[count.index]}_ec2_Memory"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name = "mem_used_percent"
  namespace = "CWAgent"
  period = "300"
  statistic = "Average"
  threshold = "15"
  alarm_description = "This metric monitors ec2 memory utilization"
  alarm_actions = ["${var.alarm_action_sns_arn}"]

  dimensions = {
    InstanceId = "${var.InstanceId[count.index]}"
    ImageId = "${var.ImageId}"
    InstanceType = "${var.InstanceType[count.index]}"
  }

  tags = {
    Name = "${var.InstanceId[count.index]}.memory"
  }
}


//Disk_Used_Percent
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_ec2_NamingRule_ec2_diskusage" {
  count   = length(var.InstanceId)
  
  alarm_name = "NamingRule_${var.InstanceId[count.index]}_ec2_DiskUsage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name = "disk_used_percent"
  namespace = "CWAgent"
  period = "300"
  statistic = "Average"
  threshold = "30"
  alarm_description = "This metric monitors ec2 memory diskusage"
  alarm_actions = ["${var.alarm_action_sns_arn}"]

  dimensions = {
    ImageId = "${var.ImageId}"
    InstanceId = "${var.InstanceId[count.index]}"
    InstanceType = "${var.InstanceType[count.index]}"
    device = "xvda1"
    fstype = "xfs"
    path = "/"
  }

  # tags = {
  #   Environment = "${var.env}"
  #   Project = "${var.project}"
  #   Provisioner="cloudwatch"
  #   Name = "${local.name}.memory"
  # }
  
  tags = {
    Name = "${var.InstanceId[count.index]}.diskusage"
  }
}
