# Create an API Gateway Authorizer
resource "aws_apigatewayv2_authorizer" "authorizer" {
  api_id = aws_apigatewayv2_api.dog_restaurant_api.id
  authorizer_type = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name = "dog-authorizer-jwt"
  jwt_configuration {
    audience = [var.audience]
    issuer   = var.issuer
  }
}