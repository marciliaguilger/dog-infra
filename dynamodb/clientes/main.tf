# Configuração do Provedor AWS
provider "aws" {
  region = "us-east-1",
  profile = "lab"
}

# Criação da Tabela DynamoDB
resource "aws_dynamodb_table" "dog-customers" {
  name           = "dog-customers"
  billing_mode   = "PROVISIONED"  # Modo de capacidade provisionada
  read_capacity  = 1  # Capacidade de leitura mínima
  write_capacity = 1  # Capacidade de escrita mínima
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "document"
    type = "S"
  }

  local_secondary_index {
    name               = "document_index"
    range_key          = "document_index"
    projection_type    = "ALL"  # Pode ser KEYS_ONLY, INCLUDE ou ALL
  }

  tags = {
    Name        = "dog-customers"
    Environment = "dev"
  }
}