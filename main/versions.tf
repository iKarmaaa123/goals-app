terraform {
    required_version = ">= 1.0"

required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

terraform {
    backend "s3" {
        bucket = "terraform-coderco-project"
        key = "statefile/terraform.tfstate"
        region = "us-east-1"
    }
}