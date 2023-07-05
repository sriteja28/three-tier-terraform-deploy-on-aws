# backend.tf
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "three-tier-architecture.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}
