packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "myapp-node-ami-1" {
  source_ami_filter {
    filters = {
       virtualization-type = "hvm"
       name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20221201"
       root-device-type = "ebs"
    }
    owners = ["amazon"]
    most_recent = true
  }
  ami_name      = "myapp-node-ami-1"
  instance_type = "t3a.small"
  region        = "us-west-2"
  ssh_username = "ubuntu"
  iam_instance_profile = "rachit-codedeploy"
}

build {
  sources = [
    "source.amazon-ebs.myapp-node-ami-1"
  ]
  provisioner "shell" {
  script       = "./script.sh"
}
}

