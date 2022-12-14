# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.15"
     }
    helm = {
      source = "hashicorp/helm"
      #version = "2.5.1"
      version = "~> 2.5"
    } 
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-toantruyen"
    key    = "dev/eks-metrics-server/terraform.tfstate"
    region = "ap-southeast-2" 

    # For State Locking
    dynamodb_table = "dev-eks-metrics-server"    
  }     
}

# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

