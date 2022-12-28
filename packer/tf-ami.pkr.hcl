packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "rachit-node-ami-7" {
  source_ami_filter {
    filters = {
       virtualization-type = "hvm"
       name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20221201"
       root-device-type = "ebs"
    }
    owners = ["amazon"]
    most_recent = true
  }
  ami_name      = "rachit-node-ami-7"
  instance_type = "t3a.small"
  region        = "us-west-2"
  ssh_username = "ubuntu"
  iam_instance_profile = "rachit-codedeploy"
}

build {
  sources = [
    "source.amazon-ebs.rachit-node-ami-7"
  ]
  provisioner "shell" {
  script       = "./script.sh"
}
}

