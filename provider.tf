terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = "AKIA5TOVFN6VWY2V76G2"
  secret_key = "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"
}