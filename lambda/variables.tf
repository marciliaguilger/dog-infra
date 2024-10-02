variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "pos"
}


variable "lambda_s3_bucket" {
  description = "lambda s3 bucket"
  type        = string
}

variable "lambda_s3_key" {
  description = "lambda s3 key"
  type        = string
}
