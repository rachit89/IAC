############# CREATING VPN  ##############################




module "vpn" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 3.0"
  name                   = "${local.name}-vpn"
  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = [aws_security_group.pritunl-sg.id]
  subnet_id              = element(module.vpc.public_subnets, 0)
  iam_instance_profile   = resource.aws_iam_instance_profile.dev-resources-iam-profile.name
  user_data              = filebase64("pritunl.sh")




  tags = {
    Terraform   = local.Terraform
    Environment = local.Environment
  }
}


################ security group for pritunl ######################


################# Getting public ip for VPN CONNECT ##############



resource "aws_iam_instance_profile" "dev-resources-iam-profile" {
name = "ec2_profile"
role = aws_iam_role.dev-resources-iam-role.name
}
resource "aws_iam_role" "dev-resources-iam-role" {
name        = "dev-ssm-role"
description = "The role for the developer resources EC2"
assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": {
"Effect": "Allow",
"Principal": {"Service": "ec2.amazonaws.com"},
"Action": "sts:AssumeRole"
}
}
EOF
tags = {
stack = "test"
}
}
resource "aws_iam_role_policy_attachment" "dev-resources-ssm-policy" {
role       = aws_iam_role.dev-resources-iam-role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}



resource "aws_security_group" "pritunl-sg" {
  name   = "${local.name}-vpn-sg"
  vpc_id = module.vpc.vpc_id
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 19103
    to_port     = 19103
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name  = local.name
    Owner = local.Owner
  }
}


#################### CREATING VPC  #######################




module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "local.name"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  single_nat_gateway = true
  enable_nat_gateway = true

  tags = {
    Terraform   = local.Terraform
    Environment = local.Environment
    Owner       = "${local.name}-vpc"
  }
}



