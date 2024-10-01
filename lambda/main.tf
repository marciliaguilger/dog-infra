provider "aws" {
  region  = var.aws_region
  #profile = var.aws_profile
}

data "aws_s3_bucket_object" "lambda_zip" {
  bucket = var.lambda_s3_bucket
  key    = var.lambda_s3_key
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda_authorizer" {
  function_name = "lambda_authorizer"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  source_code_hash = data.aws_s3_bucket_object.lambda_zip.etag

}