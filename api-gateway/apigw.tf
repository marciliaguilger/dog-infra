provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
# Create an API Gateway HTTP API
resource "aws_apigatewayv2_api" "dog_restaurant_api" {
  name          = "dog-restaurant-api"
  protocol_type = "HTTP"
}

# Create a security group
resource "aws_security_group" "balancers_security_group" {
  name        = "balancers-security-group"
  description = "Permitir trafego do api gateway ate o eks"
  vpc_id      = var.vpc_id

  # Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Anywhere-IPv4
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "balancers-security-group"
  }
}

resource "aws_apigatewayv2_stage" "http_stage" {
  api_id      = aws_apigatewayv2_api.dog_restaurant_api.id
  name        = "default"
  auto_deploy = true
}

# Create a VPC Link
resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name = "dog-restaurant-vpc-link"
  subnet_ids = [var.private_subnet_a_id, var.private_subnet_b_id]
  security_group_ids = [aws_security_group.balancers_security_group.id]
}