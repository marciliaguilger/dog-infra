# Create an API Gateway Route
resource "aws_apigatewayv2_route" "http_route_client" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "GET /clientes"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_clientes.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "http_route_client_post" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "POST /clientes"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_clients_post.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

# Create an API Gateway Route
resource "aws_apigatewayv2_route" "http_route_client_by_cpf" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "GET /clientes/{cpf}"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_clientes_cpf.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

# Create an API Gateway Route
resource "aws_apigatewayv2_route" "http_route_products" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "GET /produtos"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_products.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "http_route_products_name" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "GET /produtos/nome/{nome}"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_products_by_name.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

# Create an API Gateway Route
resource "aws_apigatewayv2_route" "http_route_products_by_id" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "GET /produtos/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_products_by_id.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

# Create an API Gateway Route
resource "aws_apigatewayv2_route" "http_route_products_categories" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "GET /produtos/categorias"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_products_cateogories.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

# Create an API Gateway Route
resource "aws_apigatewayv2_route" "http_route_orders" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "GET /pedidos"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_orders.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}

# Create an API Gateway Route for POST /produtos
resource "aws_apigatewayv2_route" "http_route_products_post" {
  api_id    = aws_apigatewayv2_api.dog_restaurant_api.id
  route_key = "POST /produtos"
  target    = "integrations/${aws_apigatewayv2_integration.http_integration_products_post.id}"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "JWT"
}
