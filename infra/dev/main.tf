terraform {
    backend "s3" {
        bucket         = "terraform-state-aws-redirect"
        key            = "terraform.tfstate"
        region         = "us-east-2"
        use_lockfile = true
    }
}

provider "aws" {
    region = var.region
}
