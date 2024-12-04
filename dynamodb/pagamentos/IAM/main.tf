provider "aws" {
  region = "us-east-1"
  profile = "dog"
}

data "aws_eks_cluster" "eks_cluster" {
     name = "dog-eks-cluster"
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = data.aws_eks_cluster.eks_cluster.name
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:dog-service-account"]
    }
  }
}

resource "aws_iam_policy" "dynamodb_access" {
     name        = "DynamoDBAccessPolicy"
     description = "Policy to allow EKS access DynamoDB table"
     policy      = jsonencode({
       Version = "2012-10-17"
       Statement = [
         {
           Effect = "Allow"
           Action = [
             "dynamodb:*",
             "dynamodb:PutItem",
             "dynamodb:GetItem",
             "dynamodb:Scan",
             "dynamodb:Query",
             "dynamodb:UpdateItem",
             "dynamodb:DeleteItem"
           ]
           Resource = "arn:aws:dynamodb:us-east-1:764549915701:table/pagamentos"
         }
       ]
     })
   }


provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
}
   

resource "aws_iam_openid_connect_provider" "oidc" {
  url                   = var.oidc_url
  client_id_list        = ["sts.amazonaws.com"]
  thumbprint_list       = ["A031C46782E6E6C662C2C87C76DA9AA62CCABD8E"]
}

# IAM Role com a política de confiança
resource "aws_iam_role" "eks_dynamodb_access" {
  name = "eks_dynamodb_access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.oidc.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(replace(aws_iam_openid_connect_provider.oidc.url, "https://", ""), "/", ":")}:sub": "system:serviceaccount:default:dog-service-account"
        }
      }
    }
  ]
}
EOF
}
