###################### The Local Variables Used in the given Code ########################


locals {

  Environment          = "dev"
  Terraform            = "true"
  Owner                = "RACHIT"
  name                 = "my-app"
  instance_type        = "t3a.small"
  instance-size        = "t3a.medium"
  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name
  key_name             = "rachit1"
  zone_id              = "Z04396102CK6SZVB04SXD"
  zone_id_alb          = "Z1H1FL5HABSF5"
  region               = "us-west-2"
  name_prefix          = "myapp"
  host_headers         = "myappvpn.rtd.squareops.co.in"
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
  pipeline_name        = "myapp-pipeline"
  output_artifacts     = "myapp_output"
  FullRepositoryId     = "rachit89/node-express-realworld-example-app"
  BranchName           = "master"
  group_name           = "myappMERN"
  stream_name          = "myappMERN"
  location             = "https://github.com/rachit89/node-express-realworld-example-app.git"
  image                = "aws/codebuild/standard:6.0"
  type                 = "LINUX_CONTAINER"
  compute_platform     = "Server"
  domain_name          = "rtd.squareops.co.in"
  evaluation_periods   = "5"
  statistic_period     = "60"
  endpoint             = "rachit.maheshwari@squareops.com"
  threshold            = "50"
  threshold_unhealthy  = "0"
  # mongo0	       = (element(module.myapp_ec2_instance,0)).id
  # mongo1               = (element(module.myapp_ec2_instance,1)).id
  # mongo2               = (element(module.myapp_ec2_instance,2)).id
  user_data            = <<EOF
#!/bin/bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-rachit -s
sudo systemctl restart amazon-cloudwatch-agent.service
EOF

}
