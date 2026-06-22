# 🏥 Clínica Médica — Banco de Dados

Sistema de banco de dados para gerenciamento de uma clínica médica, desenvolvido com **PostgreSQL 15**, como projeto da disciplina de Desenvolvimento Web — 2º Bimestre 2026.

---

## 📋 Sobre o Projeto

O sistema foi desenvolvido para gerenciar o ciclo completo de atendimento de uma clínica médica, incluindo:

- Cadastro de pacientes e médicos  
- Controle de consultas  
- Gestão de agenda de horários  
- Registro completo dos atendimentos  

O banco é composto por **6 tabelas principais**, relacionadas entre si:

- **convênio** — planos de saúde parceiros (Unimed, Bradesco Saúde, SulAmérica, Amil)  
- **especialidade** — especialidades médicas (Cardiologia, Dermatologia, Ortopedia, etc.)  
- **paciente** — dados pessoais e vínculo com convênio  
- **médico** — cadastro de médicos, CRM, especialidade e valor de consulta  
- **agenda** — dias da semana e horários disponíveis  
- **consulta** — tabela central do sistema, registrando cada atendimento com paciente, médico, status, motivo, diagnóstico e valor cobrado  

---

## 🗂️ Arquivos do Projeto


clinica-bd/
├── README.md
├── modelagem/
│ ├── der.png # Diagrama Entidade-Relacionamento
│ ├── modelo_logico.png # Modelo Lógico Relacional
│ └── dicionario_dados.md # Dicionário de dados completos
├── scripts/
│ ├── setup.sql # Criação das tabelas, restrições e índices
│ └── dados_teste.sql # Dados fictícios para teste (100+ registros)
├── queries/
│ └── consultas_avancadas.sql # Consultas avançadas do sistema
└── justificativa/
└── arquitetura.md # Justificativa técnica detalhada


---

## 🧠 Por que PostgreSQL?

### 📌 Modelo de dados relacional por natureza

O sistema foi modelado de forma totalmente relacional.

Os dados da clínica possuem relações bem definidas:

- Um paciente pertence a um convênio  
- Um médico pertence a uma especialidade  
- Uma consulta liga obrigatoriamente paciente e médico  

Esse tipo de estrutura é ideal para bancos relacionais.

Usar um banco NoSQL (como MongoDB) exigiria duplicação de dados, como embutir informações de médico dentro de cada consulta, o que geraria inconsistência e dificuldade de manutenção.

---

### 🔐 Integridade garantida na camada de dados

O PostgreSQL permite aplicar regras diretamente no banco de dados, garantindo consistência mesmo em caso de falhas na aplicação:

- **Foreign Keys**
  - `ON DELETE SET NULL`
  - `ON DELETE CASCADE`
- **CHECK constraints**
  - Validação de CPF com regex:  
    `^\d{3}\.\d{3}\.\d{3}-\d{2}$`
  - Validação de status da consulta:
    - AGENDADA  
    - REALIZADA  
    - CANCELADA  
    - FALTA  

Isso garante que dados inválidos nunca sejam gravados.

---

### ⚙️ Recursos avançados utilizados

Foram utilizados recursos avançados do PostgreSQL nas consultas:

- **FILTER (WHERE ...)**  
  Permite agregações condicionais em uma única query (ex: relatórios financeiros)

- **DATE_TRUNC('month', CURRENT_DATE)**  
  Filtragem precisa por mês atual

- **NULLIF(..., 0)**  
  Evita divisão por zero em cálculos de taxa

- **Índices B-Tree**  
  Otimização de consultas em colunas frequentes:
  - CPF do paciente  
  - Médico  
  - Status da consulta  

---

### ❓ Por que não MySQL?

O MySQL também seria funcional para este projeto, porém o PostgreSQL foi escolhido por:

- Suporte mais avançado a **agregações com FILTER**
- Melhor suporte a **expressões regulares em constraints**
- Integração com ambiente **Docker (postgres:15-alpine)**
- Maior robustez em validações e consultas analíticas

---

## 📊 Dados de Teste

O arquivo `dados_teste.sql` contém dados fictícios consistentes com o domínio da clínica:

| Entidade         | Quantidade |
|------------------|------------|
| Convênios        | 5          |
| Especialidades   | 8          |
| Médicos          | 10         |
| Pacientes        | 40         |
| Agenda           | 21         |
| Consultas        | 60         |

As consultas estão distribuídas entre **janeiro e maio de 2025**, com diferentes status:

- Agendadas  
- Realizadas  
- Canceladas  
- Faltas  

Isso permite testar todos os cenários do sistema.

📌 Observação Importante (Apresentação)

Conforme alinhado com o professor Gustavo, foi acordado que a apresentação será realizada executando o banco de dados localmente na máquina dos integrantes.

O projeto foi inicialmente dividido em dois repositórios, sendo:

Um repositório do banco de dados funcional
Outro repositório para apresentação da modelagem e estrutura

Essa divisão foi feita com o objetivo de facilitar a demonstração em sala de aula, mostrando:

Como foi criada a base de dados
A estrutura do banco
E como o sistema funcionaria na prática durante a apresentação