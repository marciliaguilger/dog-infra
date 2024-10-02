variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "bia"
}

variable "elb_uri" {
  description = "Elastic Load Balancer URI"
  type        = string
}

variable "client_route" {
  description = "Client Route"
  type        = string
  default     = "/clientes"
}

variable "products_route" {
  description = "Products Route"
  type        = string
  default     = "/produtos"
}

variable "products_route_by_id" {
  description = "Products By Id Route"
  type        = string
  default     = "/produtos/{id}"
}

variable "products_categories_route" {
  description = "Products Route"
  type        = string
  default     = "/produtos/categorias"
}


variable "audience" {
  description = "Cognito Client Audience"
  type        = string
}

variable "issuer" {
  description = "Cognito Client issuer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_a_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_b_id" {
  description = "VPC ID"
  type        = string
}