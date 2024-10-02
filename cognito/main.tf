provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
# Create an API Gateway HTTP API
resource "aws_apigatewayv2_api" "dog_restaurant_api" {
  name          = "dog-restaurant-api"
  protocol_type = "HTTP"
}


# Create a Cognito User Pool
resource "aws_cognito_user_pool" "dog_restaurant_user_pool" {
  name = "dog-restaurant-user-pool"

  # Advanced security settings
  advanced_security_mode = "OFF"

  # Schema attributes
  schema {
    attribute_data_type = "String"
    name                = "custom:cpf"
    mutable             = true
    required            = false
  }

  # Domain configuration
  domain {
    domain = "dog-restaurant"
  }

  # Tags
  tags = {
    Name = "dog-restaurant-user-pool"
  }
}

# Create a Cognito User Pool Client
resource "aws_cognito_user_pool_client" "client1" {
  name         = "client1"
  user_pool_id = aws_cognito_user_pool.dog_restaurant_user_pool.id

  # Authentication flows
  allowed_oauth_flows = [
    "code",
    "implicit"
  ]

  allowed_oauth_scopes = [
    "email",
    "openid",
    "phone"
  ]

  allowed_oauth_flows_user_pool_client = true

  # Callback URLs
  callback_urls = [
    "https://imissmycafe.com/"
  ]

  # Token expiration settings
  access_token_validity      = 120
  id_token_validity          = 60
  refresh_token_validity     = 120
  auth_session_validity      = 3

  # Enable token revocation and prevent user existence errors
  enable_token_revocation = true
  prevent_user_existence_errors = "ENABLED"

  # Supported authentication flows
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  # Tags
  tags = {
    Name = "client1"
  }
}

# Output the User Pool ID and Client ID
output "user_pool_id" {
  value = aws_cognito_user_pool.dog_restaurant_user_pool.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.client1.id
}

output "client_secret" {
  value = aws_cognito_user_pool_client.client1.client_secret
}