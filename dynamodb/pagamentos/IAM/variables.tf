variable "lab_role" {
  description = "The ARN of the EKS node group role"
  type        = string
  default        = "arn:aws:iam::<ACCOUNT_ID>:role/LabRole"
}

variable "oidc_url" {
  description = "OIDC URL"
  type        = string
  default        = "https://oidc.eks.us-east-1.amazonaws.com/id/<CLUSTER_ID>"
}


