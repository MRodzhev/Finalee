terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }



    backend "s3" {
        encrypt = true
        bucket  = "mrodzhev-s3-bucket"
        region  = "eu-central-1"
        key     = "terraform.tfstate"
    }

