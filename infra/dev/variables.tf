variable "region" {
    description = "The AWS region"
    type        = string
    default     = "us-east-2"
}

variable "subdomain" {
    description = "The subdomain for the S3 bucket"
    type        = string
    default     = "aws"
}

variable "hosted_zone_id" {
    description = "The ID of the Route 53 hosted zone"
    type        = string
    default     = "Z02094773JGQHZW2IP2KB"
}

variable "redirect_domain" {
    description = "The domain name for the redirect"
    type        = string
    default     = "https://d-9a67636455.awsapps.com/start/#/console?account_id=902448871458&role_name=SystemAdministrator"
}