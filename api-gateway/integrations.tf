# Create an API Gateway Integration Clientes
resource "aws_apigatewayv2_integration" "http_integration_clientes" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri = "${var.elb_uri}${var.client_route}"
  integration_method = "GET"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration Clientes Por Cpf
resource "aws_apigatewayv2_integration" "http_integration_clientes_cpf" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri = "${var.elb_uri}/clientes/{cpf}"
  integration_method = "GET"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration Produtos
resource "aws_apigatewayv2_integration" "http_integration_products" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri = "${var.elb_uri}${var.products_route}"
  integration_method = "GET"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration Produtos Por Id
resource "aws_apigatewayv2_integration" "http_integration_products_by_id" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = "${var.elb_uri}/produtos/{id}"
  integration_method = "GET"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration Produtos Por Nome
resource "aws_apigatewayv2_integration" "http_integration_products_by_name" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = "${var.elb_uri}/produtos/nome/{nome}"
  integration_method = "GET"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration Produtos Categorias
resource "aws_apigatewayv2_integration" "http_integration_products_cateogories" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri = "${var.elb_uri}${var.products_categories_route}"
  integration_method = "GET"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration Pedidos
resource "aws_apigatewayv2_integration" "http_integration_orders" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri = "${var.elb_uri}/pedidos"
  integration_method = "GET"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration for POST /produtos
resource "aws_apigatewayv2_integration" "http_integration_products_post" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = "${var.elb_uri}/produtos"
  integration_method = "POST"
  payload_format_version = "1.0"
}

# Create an API Gateway Integration for POST /produtos
resource "aws_apigatewayv2_integration" "http_integration_clients_post" {
  api_id           = aws_apigatewayv2_api.dog_restaurant_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = "${var.elb_uri}/clientes"
  integration_method = "POST"
  payload_format_version = "1.0"
}