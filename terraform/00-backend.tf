terraform {
  backend "s3" {
    bucket         = "rachit-tfstate"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "app-state"
  }
}

