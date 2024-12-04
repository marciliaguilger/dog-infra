# Configuração do Provedor AWS
provider "aws" {
  region = "us-east-1"
  profile = "dog"
}

resource "aws_dynamodb_table" "pagamentos" {
    name         = "produtos"  # Nome da tabela
    billing_mode = "PAY_PER_REQUEST"  # Modo de pagamento, PAY_PER_REQUEST ou PROVISIONED

    # Definição das chaves
    hash_key  = "id"

    attribute {
      name = "id"
      type = "S"  
    }
}
  