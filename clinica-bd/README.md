# 🏥 Sistema de Banco de Dados para Clínica Médica

## 📋 Sobre o Projeto

Este projeto consiste na modelagem e implementação de um banco de dados relacional para gerenciamento de uma clínica médica.

O objetivo é armazenar e gerenciar informações relacionadas a pacientes, médicos, consultas, especialidades e demais processos envolvidos no funcionamento de uma clínica, garantindo organização, integridade e facilidade de consulta dos dados.

O projeto foi desenvolvido como atividade acadêmica da disciplina de Banco de Dados, contemplando todas as etapas de modelagem e implementação.

---

## 🎯 Objetivos

* Modelar um banco de dados para uma clínica médica.
* Aplicar conceitos de modelagem conceitual e lógica.
* Implementar tabelas, relacionamentos e restrições.
* Popular o banco com dados de teste.
* Criar consultas SQL para extração de informações relevantes.

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

## 🗄️ Modelagem do Banco

### DER (Diagrama Entidade Relacionamento)

O DER apresenta as entidades principais do sistema e seus relacionamentos.

Principais entidades:

* Paciente
* Médico
* Consulta
* Especialidade
* Convênio
* Recepcionista

O diagrama pode ser encontrado em:

```text
modelagem/DER.png
```

### Modelo Lógico

O modelo lógico representa a implementação das entidades em tabelas relacionais, incluindo:

* Chaves primárias (PK)
* Chaves estrangeiras (FK)
* Cardinalidades
* Restrições de integridade

Arquivo:

```text
modelagem/modelo_logico.png
```

---

## 🛠️ Tecnologias Utilizadas

* SQL
* MySQL 8+
* MySQL Workbench
* Git
* GitHub

---

## 🚀 Como Executar o Projeto

### 1. Clonar o Repositório

```bash
git clone https://github.com/danleltavarez/banco-de-dados-da-prova.git
```

### 2. Acessar a Pasta do Projeto

```bash
cd banco-de-dados-da-prova/clinica-bd
```

### 3. Criar o Banco de Dados

Abra o arquivo:

```text
scripts/setup.sql
```

e execute-o no MySQL Workbench ou em outro cliente SQL compatível.

Este script irá:

* Criar o banco de dados.
* Criar as tabelas.
* Configurar as chaves primárias.
* Configurar as chaves estrangeiras.
* Aplicar as restrições de integridade.

### 4. Inserir os Dados de Teste

Execute o arquivo:

```text
scripts/dados_teste.sql
```

Este script irá popular o banco com registros de exemplo para testes e consultas.

### 5. Executar Consultas

As consultas avançadas estão disponíveis em:

```text
consultas/consultas_avancadas.sql
```

Essas consultas demonstram:

* JOINs
* Agregações
* Filtros
* Relatórios
* Consultas complexas

---

## 📖 Documentação

### Arquitetura

Descrição geral da estrutura do banco de dados:

```text
documentacao/arquitetura.md
```

### Dicionário de Dados

Descrição detalhada das tabelas, atributos e relacionamentos:

```text
documentacao/dicionario_dados.md
```

---

## 📊 Funcionalidades Demonstradas

* Cadastro de pacientes
* Cadastro de médicos
* Controle de especialidades
* Agendamento de consultas
* Relacionamento entre pacientes e médicos
* Consultas SQL avançadas
* Geração de relatórios

---

## ✅ Conceitos Aplicados

* Modelagem Conceitual
* Modelo Entidade Relacionamento (MER)
* Modelo Lógico
* Normalização
* Integridade Referencial
* Chaves Primárias e Estrangeiras
* Consultas SQL Avançadas
* Boas Práticas de Banco de Dados

---

## 👨‍💻 Autor

Daniel Junior  Matheus Borali

Projeto desenvolvido para fins acadêmicos na disciplina de Banco de Dados.
