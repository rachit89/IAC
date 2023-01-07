{
    "widgets": [
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "CWAgent", "disk_inodes_free", "path", "/sys/fs/cgroup", "InstanceId", "i-0808cedd9c6eaf837", "AutoScalingGroupName", "Rachit-asg-node-2022122602090948680000000a", "ImageId", "ami-06b348680d34507ff", "InstanceType", "t3a.small", "device", "tmpfs", "fstype", "tmpfs", { "visible": false } ],
                    [ ".", "disk_used_percent", ".", "/snap/amazon-ssm-agent/6312", ".", ".", ".", ".", ".", ".", ".", ".", ".", "loop0", ".", "squashfs", { "visible": false } ],
                    [ ".", "disk_inodes_free", ".", "/snap/core18/2667", ".", "i-040c022304a14743e", ".", ".", ".", ".", ".", ".", ".", "loop5", ".", ".", { "visible": false } ],
                    [ ".", "disk_used_percent", ".", "/snap/core20/1738", ".", ".", ".", ".", ".", ".", ".", ".", ".", "loop6", ".", ".", { "visible": false } ],
                    [ ".", "cpu_usage_user", "InstanceId", "i-0e2650adf64b2f2bc", "AutoScalingGroupName", "Rachit-asg-node-2022122602090948680000000a", "ImageId", "ami-081082894eb6cd9fc", "cpu", "cpu0", ".", "t3a.medium", { "visible": false } ],
                    [ ".", "cpu_usage_idle", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "cpu_usage_system", ".", "i-077cc486e168436b9", ".", ".", ".", ".", ".", "cpu1", ".", ".", { "visible": false } ],
                    [ ".", "cpu_usage_idle", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "cpu_usage_user", ".", ".", ".", ".", ".", ".", ".", "cpu0", ".", ".", { "visible": false } ],
                    [ ".", "mem_used_percent", ".", "i-0ad99a553c2c4ddaf" ],
                    [ ".", "cpu_usage_idle", ".", "." ],
                    [ ".", "cpu_usage_system", ".", "." ],
                    [ ".", "cpu_usage_user", ".", "." ],
                    [ ".", "disk_used_percent", ".", "i-04ebb8533dd4022c8" ],
                    [ ".", "mem_used_percent", ".", "." ],
                    [ ".", "cpu_usage_user", ".", "." ],
                    [ ".", "cpu_usage_system", ".", "." ],
                    [ ".", "cpu_usage_idle", ".", "." ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-west-2",
                "period": 300,
                "stat": "Average"
            }
        },
        {
            "height": 9,
            "width": 24,
            "y": 11,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/ApplicationELB", "UnhealthyStateRouting", "TargetGroup", "targetgroup/rachit20221226020906270000000008/bfcf8d6c3cfb9009", "LoadBalancer", "app/rachit-alb/28157dcac2aae11e", "AvailabilityZone", "us-west-2b", { "visible": false } ],
                    [ ".", "UnhealthyStateDNS", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "UnhealthyRoutingRequestCount", ".", ".", ".", ".", ".", "us-west-2a", { "visible": false } ],
                    [ ".", "UnhealthyStateDNS", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "HealthyStateDNS", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "RequestCount", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ "...", "us-west-2b", { "visible": false } ],
                    [ ".", "RequestCountPerTarget", ".", ".", ".", ".", ".", "us-west-2a", { "visible": false } ],
                    [ ".", "HealthyStateRouting", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "UnhealthyStateRouting", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "RequestCountPerTarget", ".", ".", ".", ".", ".", "us-west-2b", { "visible": false } ],
                    [ ".", "UnHealthyHostCount", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ "...", "us-west-2a", { "visible": false } ],
                    [ ".", "HealthyHostCount", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ "...", "us-west-2b", { "visible": false } ],
                    [ ".", "HealthyStateDNS", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "HealthyStateRouting", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ ".", "HTTPCode_Target_4XX_Count", ".", ".", ".", ".", ".", ".", { "visible": false } ],
                    [ "...", "us-west-2a", { "visible": false } ],
                    [ ".", "TargetResponseTime", ".", ".", ".", ".", ".", "us-west-2b", { "visible": false } ],
                    [ "...", "us-west-2a", { "visible": false } ],
                    [ ".", "HTTPCode_Target_4XX_Count", "LoadBalancer", "app/rachit-alb/0e290da162a65454" ],
                    [ ".", "HTTPCode_ELB_4XX_Count", ".", "." ],
                    [ ".", "HTTPCode_Target_2XX_Count", ".", "." ],
                    [ ".", "TargetResponseTime", ".", "." ],
                    [ ".", "HTTPCode_Target_3XX_Count", ".", "." ],
                    [ ".", "RequestCount", ".", "." ],
                    [ ".", "HTTPCode_ELB_3XX_Count", ".", "." ],
                    [ ".", "HTTP_Redirect_Count", ".", "." ],
                    [ ".", "NewConnectionCount", ".", "." ],
                    [ ".", "HTTPCode_ELB_5XX_Count", ".", "." ],
                    [ ".", "HTTPCode_ELB_502_Count", ".", "." ],
                    [ ".", "ActiveConnectionCount", ".", "." ],
                    [ ".", "RuleEvaluations", ".", "." ],
                    [ ".", "UnhealthyRoutingRequestCount", ".", "." ],
                    [ ".", "ProcessedBytes", ".", "." ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "us-west-2",
                "period": 300,
                "stat": "Average"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 6,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "i-08eb27954ab11d9c0", { "visible": false } ],
                    [ ".", "EBSReadOps", ".", ".", { "visible": false } ],
                    [ ".", "NetworkPacketsIn", ".", ".", { "visible": false } ],
                    [ ".", "NetworkPacketsOut", ".", ".", { "visible": false } ],
                    [ ".", "CPUCreditBalance", ".", ".", { "visible": false } ],
                    [ ".", "CPUCreditUsage", ".", ".", { "visible": false } ],
                    [ ".", "StatusCheckFailed_Instance", ".", ".", { "visible": false } ],
                    [ ".", "StatusCheckFailed", ".", ".", { "visible": false } ],
                    [ ".", "EBSReadOps", ".", "i-098cb8b357cd688ec", { "visible": false } ],
                    [ ".", "EBSReadBytes", ".", ".", { "visible": false } ],
                    [ ".", "NetworkPacketsIn", ".", ".", { "visible": false } ],
                    [ ".", "NetworkPacketsOut", ".", ".", { "visible": false } ],
                    [ ".", "CPUUtilization", ".", ".", { "visible": false } ],
                    [ ".", "StatusCheckFailed", ".", ".", { "visible": false } ],
                    [ ".", "StatusCheckFailed_Instance", ".", ".", { "visible": false } ],
                    [ ".", "CPUUtilization", ".", "i-06e9f3c18f83faf1d", { "visible": false } ],
                    [ ".", "EBSReadBytes", ".", ".", { "visible": false } ],
                    [ ".", "EBSReadOps", ".", ".", { "visible": false } ],
                    [ ".", "EBSWriteOps", ".", ".", { "visible": false } ],
                    [ ".", "EBSWriteBytes", ".", ".", { "visible": false } ],
                    [ ".", "NetworkPacketsOut", ".", ".", { "visible": false } ],
                    [ ".", "NetworkPacketsIn", ".", ".", { "visible": false } ],
                    [ ".", "StatusCheckFailed", ".", ".", { "visible": false } ],
                    [ ".", "StatusCheckFailed_Instance", ".", ".", { "visible": false } ],
                    [ ".", "CPUUtilization", ".", "i-04ebb8533dd4022c8" ],
                    [ ".", "EBSReadOps", ".", "." ],
                    [ ".", "EBSWriteOps", ".", "." ],
                    [ ".", "NetworkPacketsIn", ".", "." ],
                    [ ".", "NetworkPacketsOut", ".", "." ],
                    [ ".", "NetworkIn", ".", "." ],
                    [ ".", "NetworkOut", ".", "." ],
                    [ ".", "EBSReadOps", ".", "i-0ad99a553c2c4ddaf" ],
                    [ ".", "EBSWriteOps", ".", "." ],
                    [ ".", "CPUUtilization", ".", "." ],
                    [ ".", "NetworkPacketsIn", ".", "." ],
                    [ ".", "NetworkPacketsOut", ".", "." ],
                    [ ".", "NetworkIn", ".", "." ],
                    [ ".", "NetworkOut", ".", "." ]
                ],
                "view": "timeSeries",
                "stacked": true,
                "region": "us-west-2",
                "period": 300,
                "stat": "Average"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 25,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "bar",
                "metrics": [
                    [ "AWS/Logs", "IncomingLogEvents", "LogGroupName", "rachit-app-error2.log" ],
                    [ ".", "IncomingBytes", ".", "." ],
                    [ ".", "IncomingLogEvents", ".", "rachit-app-out2.log" ],
                    [ ".", "IncomingBytes", ".", "." ]
                ],
                "region": "us-west-2"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 12,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": true,
                "metrics": [
                    [ "AWS/EC2", "NetworkPacketsIn", "InstanceId", "i-0214aca75b91e4720" ],
                    [ ".", "NetworkPacketsOut", ".", "." ],
                    [ ".", "StatusCheckFailed_Instance", ".", "." ],
                    [ ".", "StatusCheckFailed", ".", "." ],
                    [ ".", "CPUUtilization", ".", "." ],
                    [ ".", "EBSReadOps", ".", "." ],
                    [ ".", "EBSWriteOps", ".", "." ],
                    [ ".", "NetworkIn", ".", "." ],
                    [ ".", "NetworkOut", ".", "." ],
                    [ ".", "NetworkPacketsOut", ".", "i-08f31a1dd22d66f2a" ],
                    [ ".", "NetworkIn", ".", "." ],
                    [ ".", "NetworkOut", ".", "." ],
                    [ ".", "CPUUtilization", ".", "." ],
                    [ ".", "EBSReadOps", ".", "." ],
                    [ ".", "EBSWriteOps", ".", "." ],
                    [ ".", "StatusCheckFailed_Instance", ".", "." ],
                    [ ".", "NetworkIn", ".", "i-09ae966fe4e6c10a9" ],
                    [ ".", "NetworkOut", ".", "." ],
                    [ ".", "NetworkPacketsOut", ".", "." ],
                    [ ".", "NetworkPacketsIn", ".", "." ],
                    [ ".", "EBSWriteOps", ".", "." ],
                    [ ".", "EBSReadOps", ".", "." ],
                    [ ".", "CPUUtilization", ".", "." ],
                    [ ".", "StatusCheckFailed", ".", "." ],
                    [ ".", "StatusCheckFailed_Instance", ".", "." ]
                ],
                "region": "us-west-2"
            }
        },
        {
            "height": 6,
            "width": 24,
            "y": 31,
            "x": 0,
            "type": "log",
            "properties": {
                "query": "SOURCE 'rachit-app-error.log' | fields @timestamp, @message\n| sort @timestamp desc\n| limit 20",
                "region": "us-west-2",
                "stacked": false,
                "view": "table"
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 6,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupMinSize", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Minimum Group Size (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 6,
            "x": 6,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupMaxSize", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Maximum Group Size (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 6,
            "x": 12,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupDesiredCapacity", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Desired Capacity (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 0,
            "x": 18,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupInServiceInstances", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "In Service Instances (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 5,
            "x": 18,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupTotalInstances", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Total Instances (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 20,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "singleValue",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupInServiceCapacity", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "In Service Capacity Units (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 20,
            "x": 6,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupTerminatingCapacity", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Terminating Capacity Units (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 20,
            "x": 18,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupTotalCapacity", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Total Capacity Units (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 20,
            "x": 12,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupAndWarmPoolDesiredCapacity", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Group and Warm Pool Desired Capacity (Count)",
                "region": "us-west-2",
                "period": 60
            }
        },
        {
            "height": 5,
            "width": 6,
            "y": 25,
            "x": 6,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/AutoScaling", "GroupAndWarmPoolTotalCapacity", "AutoScalingGroupName", "rachit-asg-node-2022122700481955740000000a" ]
                ],
                "title": "Group and Warm Pool Total Capacity Units launched (Count)",
                "region": "us-west-2",
                "period": 60
            }
        }
    ]
}
