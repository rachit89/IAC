###################### LAUNCHING INSTANCES FOR MONGODB  ######################

resource "tls_private_key" "mongo" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "db" {
  key_name   = "mongo" 
  public_key = tls_private_key.mongo.public_key_openssh
  provisioner "local-exec" {       
  command = "echo '${tls_private_key.mongo.private_key_pem}' > ./keys/mongo.pem"
  }
}






module "myapp_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["mongo0", "mongo1", "mongo2"])

  name = "${local.name}-${each.key}"

  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = local.instance-size
  key_name               = aws_key_pair.db.key_name
  monitoring             = true
  vpc_security_group_ids = [resource.aws_security_group.myapp-sg-mongo.id]
  subnet_id              = module.vpc.private_subnets[0]

  user_data              = <<EOF
#!/bin/bash
apt-get update
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
apt-get update
sudo apt install mongodb-org -y
sudo systemctl start mongod
EOF


  tags = {
    Owner       = local.Owner
    Environment = local.Environment
    Terraform   = local.Terraform

  }
}




#################### Security Group of Mongo Instances  #######################




resource "aws_security_group" "myapp-sg-mongo" {
  name        = "${local.name}-sg-mongo"
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
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.rachit-sg-node.id]
    self            = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name        = "${local.name}-sg-mongo"
    Owner       = local.Owner
    Environment = local.Environment
    Terraform   = local.Terraform
  }
}
