# 🏥 Sistema de Clínica Médica — Banco de Dados

Projeto de banco de dados relacional para gerenciamento de consultas em clínica médica.

## 🗂️ Estrutura do Repositório

```
├── README.md
├── modelagem/
│   ├── dicionario_dados.md       ← Dicionário completo de todas as tabelas
│   └── (der.png + modelo_logico.png — gerar via dbdiagram.io)
├── scripts/
│   ├── setup.sql                 ← DDL completo (CREATE TABLE + índices)
│   └── seed/
│       └── dados_teste.sql       ← 100+ registros fictícios para testes
├── queries/
│   └── consultas_avancadas.sql   ← 5 consultas críticas otimizadas
└── justificativa/
    └── arquitetura.md            ← Decisões técnicas justificadas
```

---

## ⚙️ Tecnologia

| Item | Escolha |
|---|---|
| Tipo | SQL Relacional |
| SGBD | PostgreSQL 15+ |
| Justificativa | Dados relacionais, integridade ACID, consultas complexas |

---

## 🗃️ Entidades do Sistema

```
convenio ──────────────────────────────────────────────────────┐
                                                               │
especialidade ─────────────┐                                   │
                           ↓                                   ↓
                         medico ──────── consulta ──────── paciente
                           │
                         agenda
```

| Tabela | Registros (seed) | Descrição |
|---|---|---|
| `convenio` | 5 | Planos de saúde aceitos |
| `especialidade` | 8 | Especialidades médicas |
| `medico` | 10 | Médicos da clínica |
| `agenda` | 21 | Horários de atendimento |
| `paciente` | 40 | Pacientes cadastrados |
| `consulta` | 60+ | Consultas (jan–mai 2025) |

---

## 🚀 Como Executar

```bash
# 1. Criar o banco no PostgreSQL
createdb clinica_db

# 2. Executar o DDL (tabelas + índices)
psql -d clinica_db -f scripts/setup.sql

# 3. Popular com dados de teste
psql -d clinica_db -f scripts/seed/dados_teste.sql

# 4. Executar as consultas críticas
psql -d clinica_db -f queries/consultas_avancadas.sql
```

---

## 📊 Consultas Críticas (resumo)

| # | Consulta | Uso | Índices utilizados |
|---|---|---|---|
| 1 | Agenda do dia por médico | Recepção diária | `idx_consulta_medico`, `idx_consulta_data` |
| 2 | Histórico do paciente por CPF | Atendimento médico | `idx_paciente_cpf`, `idx_consulta_paciente` |
| 3 | Relatório financeiro mensal | Gestão financeira | `idx_consulta_data` |
| 4 | Pacientes inativos (+6 meses) | Marketing/retenção | `idx_consulta_paciente`, `idx_consulta_data` |
| 5 | Ranking de especialidades | Decisão estratégica | `idx_medico_especialidade` |

---

## 📐 Normalização Aplicada

- **1FN**: Atributos atômicos. Endereço dividido em logradouro, cidade, estado.
- **2FN**: Todas as tabelas usam chave primária simples (SERIAL), sem dependências parciais.
- **3FN**: Nome do convênio não repete em `paciente`; nome da especialidade não repete em `medico`. Buscados via FK.

---

## 🔑 Índices

| Índice | Tabela | Campo | Tipo | Motivo |
|---|---|---|---|---|
| `idx_paciente_cpf` | `paciente` | `cpf` | B-Tree | Busca na recepção |
| `idx_consulta_data` | `consulta` | `data_consulta` | B-Tree | Filtros de data |
| `idx_consulta_status` | `consulta` | `status` | B-Tree | Filtro por status |
| `idx_consulta_paciente` | `consulta` | `id_paciente` | B-Tree | Histórico do paciente |
| `idx_consulta_medico` | `consulta` | `id_medico` | B-Tree | Agenda do médico |
| `idx_medico_especialidade` | `medico` | `id_especialidade` | B-Tree | Busca por especialidade |

![alt text](image.png)

![alt text](image.png)