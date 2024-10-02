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

variable "elb_uri" {
  description = "Elastic Load Balancer URI"
  type        = string
}