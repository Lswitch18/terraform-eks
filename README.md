# 🏗️ Terraform: AWS Infrastructure for EKS (Kubernetes)

Este projeto utiliza **Terraform** para automatizar o provisionamento de uma infraestrutura robusta e escalável na AWS, desenhada especificamente para suportar clusters **Amazon EKS (Elastic Kubernetes Service)**.

---

## 🛠️ Stack Tecnológica
- **IaC:** Terraform
- **Cloud Provider:** AWS
- **Orquestração:** Kubernetes (EKS)
- **CI/CD Quality:** Pre-commit hooks (fmt, validate)

---

## 🌐 Arquitetura de Rede

A infraestrutura segue as melhores práticas de segregação de rede:

- **VPC Customizada:** CIDR `10.0.0.0/16`
- **Subnets Públicas:** Camada de borda para Internet Gateway e NAT Gateways.
- **Subnets Privadas:** Camada isolada para os nodes do Kubernetes, garantindo que as cargas de trabalho não fiquem expostas diretamente à internet.
- **Conectividade:** 
  - **Internet Gateway** para saída/entrada pública.
  - **NAT Gateways** com Elastic IPs para permitir que nodes privados baixem atualizações com segurança.

---

## 📂 Estrutura do Código

```bash
.
├── main.tf            # Ponto de entrada (chamada de módulos)
├── variables.tf       # Definição de variáveis globais
├── outputs.tf         # Exportação de atributos (VPC IDs, Subnet IDs)
└── modules/
    └── network/       # Módulo encapsulado de rede (VPC, IGW, NAT, Routes)
```

---

## 🚀 Como Utilizar

### 1. Pré-requisitos
- Terraform instalado (v1.0+)
- AWS CLI configurado com permissões de Administrador
- [pre-commit](https://pre-commit.com/) instalado para validação de código

### 2. Inicialização
```bash
terraform init
```

### 3. Validação e Formatação
```bash
# Executa os hooks de validação em todos os arquivos
pre-commit run --all-files
```

### 4. Deploy
```bash
# Verifique o plano de execução
terraform plan

# Aplique as mudanças
terraform apply
```

---

## 📈 Status do Projeto
- [x] Módulo de Rede (VPC, Subnets, Routing)
- [ ] Configuração do Cluster EKS (Control Plane)
- [ ] Configuração de Managed Node Groups
- [ ] Add-ons (CoreDNS, kube-proxy, aws-node)

---

## 🤝 Contribuições
Sinta-se à vontade para abrir **Issues** ou enviar **Pull Requests** para melhorias na infraestrutura.

---
**Status:** 🚧 Em Desenvolvimento Ativo
