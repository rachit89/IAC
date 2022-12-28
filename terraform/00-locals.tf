locals {

  Environment          = "dev"
  Terraform            = "true"
  Owner                = "RACHIT"
  name                 = "rachit"
  ami                  = "ami-0530ca8899fac469f"
  instance_type        = "t3a.small"
  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name
  key_name         = "rachit1"
  zone_id          = "Z04396102CK6SZVB04SXD"
  zone_id_alb      = "Z1H1FL5HABSF5"
  region           = "us-west-2"                 
  certificate_arn  = "arn:aws:acm:us-west-2:421320058418:certificate/73b9c44b-3865-4f0a-b508-dc118857ae2e"
  image_id         = "ami-0a140e1d86b5d6a6b"                                                                         
  name_prefix      = "rachi"
  host_headers     = "rachitvpn.rtd.squareops.co.in"
  min_size         = 2
  max_size         = 3
  desired_capacity = 2
  user_data = <<EOF
  #!/bin/bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-rachit -s
sudo systemctl restart amazon-cloudwatch-agent.service
EOF

}
