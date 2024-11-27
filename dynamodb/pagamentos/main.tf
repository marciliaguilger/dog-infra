# Configuração do Provedor AWS
provider "aws" {
  region = "us-east-1"
  profile = "pos"
}

resource "aws_dynamodb_table" "pagamentos" {
    name         = "pagamentos"  # Nome da tabela
    billing_mode = "PAY_PER_REQUEST"  # Modo de pagamento, PAY_PER_REQUEST ou PROVISIONED

    # Definição das chaves
    hash_key  = "id"
    range_key = "pedidoId"

    attribute {
      name = "id"
      type = "S"  # Tipo de dados ('S' para String, 'N' para Number, 'B' para Binary)
    }

    attribute {
      name = "pedidoId"
      type = "S"
    }

    # Configurações opcionais de throughput (Necessário se billing_mode for PROVISIONED)
    # provisioned_throughput {
    #   read_capacity  = 5
    #   write_capacity = 5
    # }
  }
  