
# Projeto Terraform: Infraestrutura AWS para Kubernetes

## Descrição

Este projeto Terraform automatiza a criação de uma infraestrutura completa na AWS, destinada a executar serviços conteinerizados orquestrados pelo Kubernetes. A infraestrutura inclui configuração de rede, sub-redes, e roteamento, utilizando diversos serviços da AWS.

## Componentes da Infraestrutura

O projeto utiliza os seguintes recursos e serviços da AWS:

### Configurações de Rede

- **VPC (Virtual Private Cloud):**
  - **CIDR Block:** `10.0.0.0/16`

- **Sub-redes:**
  - **Públicas:**
    - `10.0.1.0/24`
    - `10.0.2.0/24`
  - **Privadas:**
    - `10.0.3.0/24`
    - `10.0.4.0/24`

- **Tabelas de Roteamento:**
  - Tabela de Roteamento Pública
  - Tabela de Roteamento Privada

- **Internet Gateway:**
  - Para permitir o tráfego de entrada e saída para a VPC.

- **NAT Gateways:**
  - Dois NAT Gateways para fornecer acesso à internet para as instâncias em sub-redes privadas.

- **Elastic IPs:**
  - Dois Elastic IPs associados aos NAT Gateways para garantir a persistência do endereço IP externo.

## Estrutura do Projeto

1. **Módulo de Rede (`modules/network`):**
   - Criação e configuração da VPC.
   - Criação de sub-redes públicas e privadas.
   - Configuração de tabelas de roteamento e associações.
   - Configuração de Internet Gateway e NAT Gateways.

2. **Configuração Principal (`main.tf`):**
   - Chamada ao módulo de rede.
   - Definição de outputs para IDs das sub-redes.

## Ferramentas e Requisitos

- **Terraform:** A infraestrutura é gerida utilizando a ferramenta Terraform.
- **Pre-commit:** Utiliza hooks para garantir a formatação e validação do código Terraform.
  - **Hooks incluídos:**
    - `terraform fmt` - Formatação do código.
    - `terraform validate` - Validação do código.

## Como Utilizar

1. **Pré-requisitos:**
   - Certifique-se de ter o Terraform e o `pre-commit` instalados.

2. **Inicializar o Terraform:**
   ```bash
   terraform init
   ```

3. **Verificar a Formatação e Validação do Código:**
   ```bash
   pre-commit run --all-files
   ```

4. **Planejar a Aplicação:**
   ```bash
   terraform plan
   ```

5. **Aplicar as Configurações:**
   ```bash
   terraform apply
   ```

6. **Visualizar Outputs:**
   Após a aplicação, os IDs das sub-redes podem ser visualizados nos outputs definidos.

## Status do Projeto

- **Em Desenvolvimento:** A configuração de rede foi finalizada. O projeto está atualmente em fase de desenvolvimento para a integração com outros componentes e serviços.

## Contato

Para dúvidas ou contribuições, entre em contato com [Seu Nome] em [wellyntonjeronimo@outlook.com].

