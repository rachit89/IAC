####################### Resource SNS & ALARMS for ALB #################


resource "aws_sns_topic" "httpcode_target_5xx_count" {
  name = "${local.name}-httpcode_target_5xx_count"
}

resource "aws_sns_topic_subscription" "httpcode_target_5xx_count" {
  topic_arn = aws_sns_topic.httpcode_target_5xx_count.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.httpcode_target_5xx_count
  ]
}

resource "aws_sns_topic" "httpcode_lb_5xx_count" {
  name = "${local.name}-httpcode_lb_5xx_count"
}
resource "aws_sns_topic_subscription" "httpcode_lb_5xx_count" {
  topic_arn = aws_sns_topic.httpcode_lb_5xx_count.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.httpcode_lb_5xx_count
  ]
}

resource "aws_sns_topic" "target_response_time_average" {
  name = "${local.name}-target_response_time"
}

resource "aws_sns_topic_subscription" "target_response_time_average" {
  topic_arn = aws_sns_topic.target_response_time_average.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.target_response_time_average
  ]
}


resource "aws_sns_topic" "unhealthy_hosts" {
  name = "${local.name}-unhealthy_hosts"
}

resource "aws_sns_topic_subscription" "unhealthy_hosts" {
  topic_arn = aws_sns_topic.unhealthy_hosts.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.unhealthy_hosts
  ]
}


resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_count" {
  alarm_name          = "${local.name}-alb-tg-${module.alb.target_group_arn_suffixes[0]}-high5XXCount"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.evaluation_periods
  metric_name         = "${local.name}-alb-HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = local.statistic_period
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Average API 5XX target group error code count is too high"
  alarm_actions       = ["${aws_sns_topic.httpcode_target_5xx_count.arn}"]
  ok_actions          = ["${aws_sns_topic.httpcode_target_5xx_count.arn}"]

  dimensions = {
    "TargetGroup"  = "${module.alb.target_group_arn_suffixes[0]}"
    "LoadBalancer" = "${module.alb.lb_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_lb_5xx_count" {
  alarm_name          = "${local.name}alb-${module.alb.lb_id}-high5XXCount"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.evaluation_periods
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = local.statistic_period
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Average API 5XX load balancer error code count is too high"
  alarm_actions       = ["${aws_sns_topic.httpcode_lb_5xx_count.arn}"]
  ok_actions          = ["${aws_sns_topic.httpcode_lb_5xx_count.arn}"]

  dimensions = {
    "LoadBalancer" = "${module.alb.lb_arn_suffix}"
  }
}

resource "aws_cloudwatch_metric_alarm" "target_response_time_average" {
  alarm_name          = "${local.name}-alb-tg-${module.alb.target_group_arn_suffixes[0]}--highResponseTime"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.evaluation_periods
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = local.statistic_period
  statistic           = "Average"
  threshold           = local.threshold
  alarm_description   = format("Average API response time is greater than %s", local.threshold)
  alarm_actions       = ["${aws_sns_topic.target_response_time_average.arn}"]
  ok_actions          = ["${aws_sns_topic.target_response_time_average.arn}"]

  dimensions = {
    "TargetGroup"  = "${module.alb.target_group_arn_suffixes[0]}"
    "LoadBalancer" = "${module.alb.lb_arn_suffix}"
  }
}

resource "aws_cloudwatch_metric_alarm" "unhealthy_hosts" {
  alarm_name          = "${local.name}-alb-tg-${module.alb.target_group_arn_suffixes[0]}-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.evaluation_periods
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = local.statistic_period
  statistic           = "Minimum"
  threshold           = local.threshold_unhealthy
  alarm_description   = format("Unhealthy host count is greater than %s", local.threshold_unhealthy)
  alarm_actions       = ["${aws_sns_topic.unhealthy_hosts.arn}"]
  ok_actions          = ["${aws_sns_topic.unhealthy_hosts.arn}"]

  dimensions = {
    "TargetGroup"  = "${module.alb.target_group_arn_suffixes[0]}"
    "LoadBalancer" = "${module.alb.lb_arn_suffix}"
  }
}





# ########################## ALARMS FOR MONGO DB #####################


resource "aws_sns_topic" "CPU0" {
  name = "mongo-0-CPUhigh"
}

resource "aws_sns_topic_subscription" "CPU0" {
  topic_arn = aws_sns_topic.CPU0.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.CPU0
  ]
}


resource "aws_sns_topic" "CPU1" {
  name = "mongo-1-CPUhigh"
}

resource "aws_sns_topic_subscription" "CPU1" {
  topic_arn = aws_sns_topic.CPU1.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.CPU1
  ]
}

resource "aws_sns_topic" "CPU2" {
  name = "mongo-2-CPUhigh"
}

resource "aws_sns_topic_subscription" "CPU2" {
  topic_arn = aws_sns_topic.CPU2.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.CPU2
  ]
}

resource "aws_sns_topic" "mem_used_percent_mongo0" {
  name = "mongo_0_mem_used_percent"
}

resource "aws_sns_topic_subscription" "mem_used_percent_mongo0" {
  topic_arn = aws_sns_topic.mem_used_percent_mongo0.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.mem_used_percent_mongo0
  ]
}


resource "aws_sns_topic" "mem_used_percent_mongo1" {
  name = "mongo_1_mem_used_percemt"
}

resource "aws_sns_topic_subscription" "mem_used_percent_mongo1" {
  topic_arn = aws_sns_topic.mem_used_percent_mongo1.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.mem_used_percent_mongo1
  ]
}


resource "aws_sns_topic" "mem_used_percent_mongo2" {
  name = "mongo_2_mem_used"
}

resource "aws_sns_topic_subscription" "mem_used_percent_mongo2" {
  topic_arn = aws_sns_topic.mem_used_percent_mongo2.arn
  protocol  = "email"
  endpoint  = local.endpoint

  depends_on = [
    aws_sns_topic.mem_used_percent_mongo2
  ]
}


resource "aws_cloudwatch_metric_alarm" "CPU_Utilization0" {
  # defining the name of AWS cloudwatch alarm
  alarm_name          = "${local.mongodb_instance_0}-CPU_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = local.statistic_period
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 cpu utilization of mongo0 exceeding 70%"
  alarm_actions       = ["${aws_sns_topic.CPU0.arn}"]
  ok_actions          = ["${aws_sns_topic.CPU0.arn}"]


  dimensions = {
    InstanceId = "${module.myapp_ec2_instance["${local.mongodb_instance_0}"].id}"
  }
}


resource "aws_cloudwatch_metric_alarm" "CPUUtilization1" {
  # defining the name of AWS cloudwatch alarm
  alarm_name          = "${local.mongodb_instance_1}-CPU_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = local.statistic_period
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 cpu utilization of mongo1 exceeding 70%"
  alarm_actions       = ["${aws_sns_topic.CPU1.arn}"]
  ok_actions          = ["${aws_sns_topic.CPU1.arn}"]


  dimensions = {
    InstanceId = "${module.myapp_ec2_instance["${local.mongodb_instance_1}"].id}"
  }
}


resource "aws_cloudwatch_metric_alarm" "CPUUtilization2" {
  # defining the name of AWS cloudwatch alarm
  alarm_name          = "${local.mongodb_instance_2}-CPU_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = local.statistic_period
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 cpu utilization of mongo2 exceeding 70%"
  alarm_actions       = ["${aws_sns_topic.CPU2.arn}"]
  ok_actions          = ["${aws_sns_topic.CPU2.arn}"]


  dimensions = {
    InstanceId = "${module.myapp_ec2_instance["${local.mongodb_instance_2}"].id}"
  }
}



resource "aws_cloudwatch_metric_alarm" "mem_used_percent0" {
  # defining the name of AWS cloudwatch alarm
  alarm_name          = "${local.mongodb_instance_2}-memory-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "AWS/EC2"
  period              = local.statistic_period
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 mem_used_percent of mongo0 exceeding 70%"
  alarm_actions       = ["${aws_sns_topic.mem_used_percent_mongo0.arn}"]
  ok_actions          = ["${aws_sns_topic.mem_used_percent_mongo0.arn}"]


  dimensions = {
    InstanceId = "${module.myapp_ec2_instance["${local.mongodb_instance_0}"].id}"
  }
}





resource "aws_cloudwatch_metric_alarm" "mem_used_percent1" {
  # defining the name of AWS cloudwatch alarm
  alarm_name          = "${local.mongodb_instance_2}-memory-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "AWS/E"
  period              = local.statistic_period
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 mem_used_percent of mongo1 exceeding 70%"
  alarm_actions       = ["${aws_sns_topic.mem_used_percent_mongo1.arn}"]
  ok_actions          = ["${aws_sns_topic.mem_used_percent_mongo1.arn}"]


  dimensions = {
    InstanceId = "${module.myapp_ec2_instance["${local.mongodb_instance_1}"].id}"
  }
}





resource "aws_cloudwatch_metric_alarm" "mem_used_percent2" {
  # defining the name of AWS cloudwatch alarm
  alarm_name          = "${local.mongodb_instance_2}-memory-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "AWS/EC2"
  period              = local.statistic_period
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 mem_used_percent of mongo2 exceeding 70%"
  alarm_actions       = ["${aws_sns_topic.mem_used_percent_mongo2.arn}"]
  ok_actions          = ["${aws_sns_topic.mem_used_percent_mongo2.arn}"]


  dimensions = {
    InstanceId = "${module.myapp_ec2_instance["${local.mongodb_instance_2}"].id}"
  }
}

