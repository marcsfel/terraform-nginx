provider "aws" {
    region = "us-east-2"
    version = "="
}

terraform {
    backend "s3" {
        bucket = "value"
        key = "value"
        region = "us-east-2"      
    }
}