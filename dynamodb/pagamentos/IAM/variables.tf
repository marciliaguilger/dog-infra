variable "lab_role" {
  description = "The ARN of the EKS node group role"
  type        = string
  default        = "arn:aws:iam::781073238785:role/LabRole"
}

variable "oidc_url" {
  description = "OIDC URL"
  type        = string
  default        = "https://oidc.eks.us-east-1.amazonaws.com/id/8554ACCD2228CB1CCE5FE71A74BAB5F1"
}


