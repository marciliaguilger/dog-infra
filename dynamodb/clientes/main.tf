# Configuração do Provedor AWS
provider "aws" {
  region = "us-east-1"
  profile = "dog"
}

resource "aws_dynamodb_table" "clientes" {
    name         = "clientes"  # Nome da tabela
    billing_mode = "PAY_PER_REQUEST"  # Modo de pagamento, PAY_PER_REQUEST ou PROVISIONED

    # Definição das chaves
    hash_key  = "id"
    range_key = "documento"

    attribute {
      name = "id"
      type = "S"  # Tipo de dados ('S' para String, 'N' para Number, 'B' para Binary)
    }

    attribute {
      name = "documento"
      type = "S"
    }

    global_secondary_index {
      name            = "documento-index"
      hash_key        = "documento"  
      projection_type = "ALL"  
    }

}
  