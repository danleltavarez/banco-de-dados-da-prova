# 🏥 Sistema de Banco de Dados para Clínica Médica

## 📖 Descrição do Projeto

Este projeto apresenta o desenvolvimento de um banco de dados relacional para uma clínica médica, utilizando PostgreSQL. O sistema foi projetado para armazenar e gerenciar informações relacionadas a pacientes, médicos, consultas e demais processos administrativos da clínica.

O trabalho contempla todas as etapas de modelagem de banco de dados, desde a criação do Diagrama Entidade-Relacionamento (DER) até a implementação física e a elaboração de consultas avançadas para análise dos dados.

---

## 🎯 Objetivos

- Aplicar conceitos de modelagem de banco de dados;
- Desenvolver um banco de dados relacional utilizando PostgreSQL;
- Garantir a integridade e consistência dos dados;
- Implementar relacionamentos entre entidades;
- Criar consultas SQL para extração e análise de informações;
- Demonstrar boas práticas de modelagem e documentação.

---

## 📂 Estrutura do Projeto

```text
clinica-bd/
│
├── README.md
│
├── apresentacao/
│   └── clinica_apresentacao.html
│
├── consultas/
│   └── consultas_avancadas.sql
│
├── documentacao/
│   ├── arquitetura.md
│   └── dicionario_dados.md
│
├── modelagem/
│   ├── DER.png
│   └── modelo_logico.png
│
└── scripts/
    ├── setup.sql
    └── dados_teste.sql
```

---

## 🏗️ Modelagem do Banco de Dados

### Diagrama Entidade-Relacionamento (DER)

O DER representa visualmente as entidades do sistema e seus relacionamentos, servindo como base para a implementação do banco de dados.

**Arquivo:** `modelagem/DER.png`

### Modelo Lógico

O modelo lógico apresenta a estrutura das tabelas, atributos, chaves primárias e estrangeiras, além das regras de relacionamento entre as entidades.

**Arquivo:** `modelagem/modelo_logico.png`

---

## 🛠️ Tecnologias Utilizadas

- PostgreSQL
- SQL
- Git
- GitHub
- pgAdmin 4

---

## 🚀 Como Executar o Projeto

### 1. Clonar o Repositório

```bash
git clone https://github.com/danleltavarez/banco-de-dados-da-prova.git
cd banco-de-dados-da-prova/clinica-bd
```

### 2. Criar o Banco de Dados

No PostgreSQL, execute:

```sql
CREATE DATABASE clinica;
```

### 3. Executar o Script de Estrutura

Abra e execute o arquivo:

```text
scripts/setup.sql
```

Esse script criará:

- Tabelas;
- Relacionamentos;
- Chaves primárias;
- Chaves estrangeiras;
- Restrições de integridade.

### 4. Inserir os Dados de Teste

Execute o arquivo:

```text
scripts/dados_teste.sql
```

Esse script adicionará registros para testes e validação do banco.

### 5. Executar as Consultas

As consultas SQL desenvolvidas para o projeto estão disponíveis em:

```text
consultas/consultas_avancadas.sql
```

Essas consultas demonstram:

- JOINs;
- Agrupamentos;
- Filtros;
- Ordenações;
- Relatórios;
- Consultas avançadas.

---

## 📚 Documentação

### Arquitetura

Descrição da organização do banco de dados, suas entidades e relacionamentos.

**Arquivo:** `documentacao/arquitetura.md`

### Dicionário de Dados

Contém a descrição detalhada das tabelas, atributos e tipos de dados utilizados no projeto.

**Arquivo:** `documentacao/dicionario_dados.md`

---

## 🔍 Funcionalidades Demonstradas

- Cadastro de pacientes;
- Cadastro de médicos;
- Gerenciamento de consultas;
- Controle de relacionamentos entre entidades;
- Armazenamento estruturado de informações;
- Consultas para análise e extração de dados;
- Aplicação de integridade referencial.

---

## 📈 Conceitos Aplicados

- Modelo Entidade-Relacionamento (MER);
- Modelo Lógico Relacional;
- Normalização de Dados;
- Chaves Primárias e Estrangeiras;
- Integridade Referencial;
- Consultas SQL;
- PostgreSQL;
- Versionamento com Git e GitHub.

---

## 👨‍💻 Autor

**Daniel Junior**   **Matheus Borali**

Projeto acadêmico desenvolvido para a disciplina de Banco de Dados, com foco na modelagem, implementação e manipulação de dados utilizando PostgreSQL.