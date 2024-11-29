provider "aws" {
  region = "us-east-1"
  profile = "pos"
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
#
#resource "aws_iam_role" "eks_role" {
#  name               = "EKSServiceAccountRole"
#  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
#}

resource "aws_iam_policy" "dynamodb_access" {
     name        = "DynamoDBAccessPolicy"
     description = "Policy to allow EKS access DynamoDB table"
     policy      = jsonencode({
       Version = "2012-10-17"
       Statement = [
         {
           Effect = "Allow"
           Action = [
             "dynamodb:PutItem",
             "dynamodb:GetItem",
             "dynamodb:Scan",
             "dynamodb:Query",
             "dynamodb:UpdateItem",
             "dynamodb:DeleteItem"
           ]
           Resource = "arn:aws:dynamodb:us-east-1:781073238785:table/pagamentos"
         }
       ]
     })
   }


   #resource "aws_iam_role_policy_attachment" "attach_policy" {
   #  policy_arn = aws_iam_policy.dynamodb_access.arn
   #  role       = aws_iam_role.eks_role.name
   #}

   provider "kubernetes" {
     host                   = data.aws_eks_cluster.eks_cluster.endpoint
     cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
     token                  = data.aws_eks_cluster_auth.eks_cluster.token
   }

  resource "kubernetes_service_account" "dog_service_account" {
    metadata {
      name      = "dog-service-account"
      namespace = "default"
      annotations = {
        "eks.amazonaws.com/role-arn" = var.lab_role
      }
    }
  }

