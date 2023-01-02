
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${local.name}-dashboard"

  dashboard_body = <<EOF

{
   "start": "-PT9H",
   "periodOverride": "inherit",
   "widgets": [
      {
         "type":"metric",
         "x":0,
         "y":0,
         "width":12,
         "height":6,
         "properties":{
            "metrics":[
               [
                  "AWS/EC2",
                  "CPUUtilization",
                  "InstanceId",
                  "${module.vpn.id}"
               ],
               [
                  "AWS/EC2",
                  "NetworkIn",
                  "InstanceId",
                  "${module.vpn.id}",
                  {
                    "yAxis":"right",
                    "label":"NetworkIn",
                    "period":3600,
                    "stat":"Maximum"
                  }
                ],
                [
                  "AWS/EC2",
                  "NetworkOut",
                  "InstanceId",
                  "${module.vpn.id}",
                  {
                    "yAxis":"right",
                    "label":"NetworkOut",
                    "period":3600,
                    "stat":"Maximum"
                  }
                ]
                ],
                    "period":60,
                    "stat":"Average",
                    "region":"${local.region}",
                    "title":"CPU , Network IN & Out Usage of VPN",
                    "liveData": true,
                    "legend": {
                        "position": "right"
         }
      }
      },
      {
         "type": "metric",
                          "x": 0,
                          "y": 0,
                          "width": 9,
                          "height": 6,
                          "properties": {
                              "view": "bar",
                              "stacked": false,
                              "metrics": [
                                  [ "AWS/AutoScaling", "GroupDesiredCapacity", "AutoScalingGroupName", "${module.asg.autoscaling_group_name}" ],
                                  [ ".", "GroupMaxSize", ".", "." ],
                                  [ ".", "GroupTotalCapacity", ".", "." ],
                                  [ ".", "GroupTotalInstances", ".", "." ],
                                  [ ".", "GroupInServiceInstances", ".", "." ]
                              ],
                              "region": "${local.region}",
                              "title": " ${module.asg.autoscaling_group_name}-stats"
         }
      },
      {
            "type": "explorer",
            "x": 0,
            "y": 6,
            "width": 24,
            "height": 15,
            "properties": {
                "metrics": [
                    {
                        "metricName": "CPUUtilization",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "NetworkIn",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "DiskReadOps",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "DiskWriteOps",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "NetworkOut",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    }
                ],
                	"aggregateBy": {
                    	"key": "InstanceId",
                    	"func": "AVG"
                },
                	"labels": [
                    {	
                        "key": "aws:autoscaling:groupName",
                        "value": "${module.asg.autoscaling_group_name}"
                    }
                ],
                	"widgetOptions": {
                    	"legend": {
                        "position": "bottom"
                    },
                    	"view": "timeSeries",
                    	"stacked": false,
                    	"rowsPerPage": 40,
                    	"widgetsPerRow": 3
                },
                	"period": 10,
                	"splitBy": "",
                	"title": "${module.asg.autoscaling_group_name}"
               }
            },
	    {
                 "type": "explorer",
                 "x": 0,
                 "y": 6,
                 "width": 24,
                 "height": 15,
                 "properties": {
                  "metrics": [
                    {
                        "metricName": "ActiveConnectionCount",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
                    {
                        "metricName": "ELBAuthError:",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
                    {
                        "metricName": "HTTP_Fixed_Response_Count",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
                    {
                        "metricName": "HTTPCode_ELB_3XX_Count",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
                    {
                        "metricName": "HTTPCode_ELB_4XX_Count",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
			{
                        "metricName": "HTTPCode_ELB_5XX_Count",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
			{
                        "metricName": "HTTPCode_ELB_502_Count",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
			{
                        "metricName": "HTTPCode_ELB_503_Count",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
			{
                        "metricName": "HTTPCode_ELB_504_Count",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
			{
                        "metricName": "RequestCount",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    },
			{
                        "metricName": "SurgeQueueLength",
                        "resourceType": "AWS::ElasticLoadBalancingV2::LoadBalancer/ApplicationELB",
                        "stat": "Average"
                    }

                ],
                	"aggregateBy": {
                    	"key": "Name",
                    	"func": "AVG"
                },
                	"labels": [
                    {	
                        "key": "Name",
                        "value": "${local.name}-alb"
                    }
                ],
                	"widgetOptions": {
                    	"legend": {
                        "position": "bottom"
                    },
                    	"view": "timeSeries",
                    	"stacked": false,
                    	"rowsPerPage": 40,
                    	"widgetsPerRow": 3
                },
                	"period": 10,
                	"splitBy": "",
                	"title": "${module.alb.lb_dns_name}"
	    }
            },

	    {
            "type": "explorer",
            "x": 0,
            "y": 6,
            "width": 24,
            "height": 15,
            "properties": {
                "metrics": [
                    {
                        "metricName": "CPUUtilization",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "NetworkIn",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "DiskReadOps",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "DiskWriteOps",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    },
                    {
                        "metricName": "NetworkOut",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Average"
                    }
                ],
                	"aggregateBy": {
                    	"key": "SecurityGroupId",
                    	"func": "AVG"
                },
                	"labels": [
                    {	
                        "key": "SecurityGroupId",
                        "value": "${aws_security_group.myapp-sg-mongo.id}"
                    }
                ],
                	"widgetOptions": {
                    	"legend": {
                        "position": "bottom"
                    },
                    	"view": "timeSeries",
                    	"stacked": false,
                    	"rowsPerPage": 40,
                    	"widgetsPerRow": 3
                },
                	"period": 10,
                	"splitBy": "",
                	"title": "Parameters Of Mongo Db"
               }
            }

]
}

EOF
}

# resource "aws_cloudwatch_composite_alarm" "EC2" {
#   alarm_description = "Composite alarm that monitors CPUUtilization "
#   alarm_name        = "EC2_Composite_Alarm"
#   alarm_actions = [aws_sns_topic.EC2_topic.arn]

#   alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.EBS_WriteOperations.alarm_name})"

#   depends_on = [
#     aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm,
#     aws_sns_topic.EC2_topic,
#     aws_sns_topic_subscription.EC2_Subscription
#   ]
# }


# # Creating the AWS CLoudwatch Alarm that will autoscale the AWS EC2 instance based on CPU utilization.
# resource "aws_cloudwatch_metric_alarm" "EC2_CPU_Usage_Alarm" {
# # defining the name of AWS cloudwatch alarm
#   alarm_name          = "EC2_CPU_Usage_Alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods = "2"
# # Defining the metric_name according to which scaling will happen (based on CPU) 
#   metric_name = "CPUUtilization"
# # The namespace for the alarm's associated metric
#   namespace = "AWS/EC2"
# # After AWS Cloudwatch Alarm is triggered, it will wait for 60 seconds and then autoscales
#   period = "60"
#   statistic = "Average"
# # CPU Utilization threshold is set to 10 percent
#   threshold = "70"
# alarm_description     = "This metric monitors ec2 cpu utilization exceeding 70%"


# resource "aws_cloudwatch_log_group" "ebs_log_group" {
#   name = "ebs_log_group"
#   retention_in_days = 30
# }


# resource "aws_cloudwatch_log_stream" "ebs_log_stream" {
#   name           = "ebs_log_stream"
#   log_group_name = aws_cloudwatch_log_group.ebs_log_group.name
# }


# resource "aws_sns_topic" "EC2_topic" {
#   name = "EC2_topic"
# }

# resource "aws_sns_topic_subscription" "EC2_Subscription" {
#   topic_arn = aws_sns_topic.EC2_topic.arn
#   protocol  = "email"
#   endpoint  = "automateinfra@gmail.com"

#   depends_on = [
#     aws_sns_topic.EC2_topic
#   ]
# }
