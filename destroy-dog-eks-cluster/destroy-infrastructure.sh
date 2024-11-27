AWS_PROFILE="dog"

# Diretório onde os arquivos de configuração do Terraform estão localizados
TERRAFORM_DIR="/home/marciliadasilvaguilguer/Documentos/repos/pos-tech/fase3/dog-infra/dog-infra/dog-eks-cluster"

# Exportar o perfil AWS
export AWS_PROFILE=$AWS_PROFILE

# Navegar para o diretório do Terraform
cd $TERRAFORM_DIR

# Inicializar o Terraform (necessário se o backend ou os provedores mudaram)
terraform init

# Destruir a infraestrutura
terraform destroy -auto-approve

# comando
# chmod +x destroy-infrastructure.sh

## LEMBRETE!! EXCLUIR LOADBALANCER MANUALMENTE ANTES DE EXECUTAR O SCRIPT