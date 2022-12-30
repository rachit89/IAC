
################## CREATING ALB  #######################



module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name               = "my-app-alb"
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [resource.aws_security_group.sg-lb.id]

  target_groups = [
    {
      name_prefix          = local.name_prefix
      backend_protocol     = "HTTP"
      backend_port         = 3000
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200,404"

      }
    },
    {
      name_prefix          = "vpn"
      backend_protocol     = "HTTPS"
      backend_port         = 443
      target_type          = "ELB"
      deregistration_delay = 10
      target_type          = "instance"
      targets = {
        my_target = {
          target_id = module.vpn.id
          port      = 443
        }
      }
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/login"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "400"
      }
    }
  ]
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "${local.certificate_arn}"
      target_group_index = 0
    }
  ]
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  tags = {
    Environment = local.Environment
    name        = "${local.name}-tg"
    Owner       = local.Owner
  }

  https_listener_rules = [
    {
      https_listener_index = 0

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{
        host_headers = ["${local.host_headers}"]
      }]
    }
  ]
}



############# SG for ALB  ######################




resource "aws_security_group" "sg-lb" {
  name        = "${local.name}-sg-lb"
  description = "Allow TLS inbound and outbund traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name        = "${local.name}-sg-lb"
    Owner       = local.Owner
    Environment = local.Environment
    Terraform   = local.Terraform
  }
}




###################### Creating Record for Backend in Route53 ###########################




module "route53-record" {
    allow_overwrite = true
    source  = "clouddrove/route53-record/aws"
    version = "1.0.1"
    zone_id = local.zone_id
    name    = "myapp.rtd.squareops.co.in"
    type    = "A"
    alias   = {
      name  = module.alb.lb_dns_name
      zone_id = local.zone_id_alb                       ########### HOSTED ZONE IF OF ALB WHICH IS ACCORDING TO REGION IN WHICH IT IS HOSTED ###########
      evaluate_target_health = true
    }
  }


########## Creating Record for VPN In Route53 #############################



module "rachit_route53-record" {
    allow_overwrite = true
    source  = "clouddrove/route53-record/aws"
    version = "1.0.1"
    zone_id = local.zone_id
    name    = local.host_headers
    type    = "A"
    alias   = {
      name  = module.alb.lb_dns_name
      zone_id = local.zone_id_alb
      evaluate_target_health = true
    }
  }




################ CREATING ASG ##########################



module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "${local.name}-asg"

  min_size                  = local.min_size
  max_size                  = local.max_size
  desired_capacity          = local.desired_capacity
  wait_for_capacity_timeout = 0
  health_check_type         = "ELB"
  vpc_zone_identifier       = module.vpc.private_subnets

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  #################### Launch template ###########################




  launch_template_name        = "${local.name}-lt-node"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id                  = "${data.aws_ami.packer-image.id}"
  instance_type             = local.instance-size
  key_name                  = aws_key_pair.app.key_name
  ebs_optimized             = true
  enable_monitoring         = true
  target_group_arns         = [module.alb.target_group_arns[0]]
  iam_instance_profile_name = aws_iam_instance_profile.instance-profile.name
  security_groups           = [aws_security_group.rachit-sg-node.id]
  user_data                 = base64encode(local.user_data) 

  tags = {
    Environment = local.Environment
    Owner       = local.Owner
  }
}

############ Scaling Policy ###############



resource "aws_autoscaling_policy" "asg-policy" {
  count                     = 1
  name                      = "${local.name}asg-cpu-policy"
  autoscaling_group_name    = module.asg.autoscaling_group_name
  estimated_instance_warmup = 60
  policy_type               = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

################### Security Group for NodeApp Instance  ########################



resource "aws_security_group" "rachit-sg-node" {
  name        = "${local.name}-sg-node"
  description = "Allow TLS inbound and outbund traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description     = "TLS from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.pritunl-sg.id]
  }
  ingress {
    description     = "TLS from VPC"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-lb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name        = "${local.name}-sg-node"
    Owner       = local.Owner
    Environment = local.Environment
    Terraform   = local.Terraform
  }
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "${local.name}-profile"
  role = aws_iam_role.instance-role.name
}

resource "aws_iam_role" "instance-role" {
  name = "${local.name}-instance-profile"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm-policy" {
role       = aws_iam_role.instance-role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}


resource "aws_iam_role_policy" "instance-profile" {
  name = "${local.name}-deploy-policy"
  role = aws_iam_role.instance-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:CompleteLifecycleAction",
                "autoscaling:DeleteLifecycleHook",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLifecycleHooks",
                "autoscaling:PutLifecycleHook",
                "autoscaling:RecordLifecycleActionHeartbeat",
                "autoscaling:CreateAutoScalingGroup",
                "autoscaling:UpdateAutoScalingGroup",
                "autoscaling:EnableMetricsCollection",
                "autoscaling:DescribePolicies",
                "autoscaling:DescribeScheduledActions",
                "autoscaling:DescribeNotificationConfigurations",
                "autoscaling:SuspendProcesses",
                "autoscaling:ResumeProcesses",
                "autoscaling:AttachLoadBalancers",
                "autoscaling:AttachLoadBalancerTargetGroups",
                "autoscaling:PutScalingPolicy",
                "autoscaling:PutScheduledUpdateGroupAction",
                "autoscaling:PutNotificationConfiguration",
                "autoscaling:PutWarmPool",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:DeleteAutoScalingGroup",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "ec2:TerminateInstances",
                "tag:GetResources",
                "sns:Publish",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:PutMetricAlarm",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeInstanceHealth",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:DeregisterTargets"
            ],
            "Resource": "*"
        },
       {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole",
                "ec2:CreateTags",
                "ec2:RunInstances"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

