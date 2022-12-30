############### Filter Amazon Images For Ubuntu20.04 ###############




data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

    owners = ["amazon"]
}




############### Filter Custom Image Build with Packer For ASG ###############



data "aws_ami" "packer-image" {
    most_recent = true

    filter {
        name   = "name"
        values = ["myapp-node-ami-*"]  
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    filter {
    name   = "root-device-type"
    values = ["ebs"]
    }
    filter {
    name   = "architecture"
    values = ["x86_64"]
    }

   

    owners = ["self"]
}