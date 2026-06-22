# Justificativa Técnica da Arquitetura

## 1. Escolha Tecnológica

### Banco de Dados: PostgreSQL (SQL Relacional)

**Por que SQL e não NoSQL?**

O sistema de clínica médica apresenta características que favorecem fortemente o modelo relacional:

| Critério | SQL (PostgreSQL) | NoSQL (MongoDB) |
|---|---|---|
| Integridade referencial | ✅ Nativo via FK | ❌ Responsabilidade da aplicação |
| Transações ACID | ✅ Nativo | ⚠️ Parcial |
| Relacionamentos entre entidades | ✅ JOINs eficientes | ❌ Embutir/referenciar manual |
| Consultas ad-hoc | ✅ SQL flexível | ⚠️ Limitado |
| Dados médicos críticos | ✅ Constraints fortes | ⚠️ Schema flexível demais |

**Por que PostgreSQL especificamente?**
- Gratuito e open-source
- Suporte nativo a tipos como `DATE`, `TIME`, `TIMESTAMP`, `NUMERIC`
- Constraints avançadas com `CHECK` e `REGEX`
- Excelente suporte a índices B-Tree, Hash, GIN
- Amplamente usado em produção e bem documentado

---

## 2. Objetivo do Sistema

Gerenciar o agendamento e controle de consultas de uma clínica médica, permitindo:
- Cadastro de pacientes com ou sem convênio
- Cadastro de médicos por especialidade
- Agendamento e controle de consultas
- Relatórios financeiros e operacionais

---

## 3. Principais Entidades

| Entidade | Descrição |
|---|---|
| `paciente` | Dados pessoais e convênio do paciente |
| `medico` | Dados do médico com CRM e especialidade |
| `especialidade` | Especialidades médicas disponíveis |
| `convenio` | Planos de saúde aceitos pela clínica |
| `agenda` | Horários disponíveis de cada médico |
| `consulta` | Registro de cada consulta (agendada, realizada, etc.) |

---

## 4. Volume e Usuários Estimados

| Métrica | Estimativa |
|---|---|
| Pacientes cadastrados | ~5.000 |
| Médicos | ~20 |
| Consultas por mês | ~1.500 |
| Usuários simultâneos (pico) | ~10 (recepcionistas + médicos) |
| Volume de dados (5 anos) | ~100 MB |

Com esse volume, PostgreSQL em um servidor simples (2 vCPUs, 4 GB RAM) suporta tranquilamente sem necessidade de sharding ou cluster.

---

## 5. Normalização

### 1ª Forma Normal (1FN)
> Atributos atômicos, sem grupos repetidos.

✅ Aplicada: cada coluna guarda um único valor. O endereço foi dividido em `logradouro`, `cidade` e `estado` ao invés de um campo único.

### 2ª Forma Normal (2FN)
> Sem dependências parciais em chaves compostas.

✅ Aplicada: todas as tabelas possuem chave primária simples (`SERIAL`), eliminando a possibilidade de dependências parciais.

### 3ª Forma Normal (3FN)
> Sem dependências transitivas.

✅ Aplicada: o nome do convênio não está na tabela `paciente` — é buscado via `id_convenio` (FK). O nome da especialidade não está em `medico` — é buscado via `id_especialidade` (FK). Isso evita redundância e anomalias de atualização.

---

## 6. Estratégia de Indexação

| Campo | Tabela | Tipo | Motivo |
|---|---|---|---|
| `cpf` | `paciente` | B-Tree | Busca de paciente por CPF na recepção |
| `data_consulta` | `consulta` | B-Tree | Filtros por data (agenda do dia, relatórios mensais) |
| `status` | `consulta` | B-Tree | Filtrar por AGENDADA, REALIZADA, CANCELADA |
| `id_paciente` | `consulta` | B-Tree | Histórico do paciente |
| `id_medico` | `consulta` | B-Tree | Agenda do médico |
| `id_especialidade` | `medico` | B-Tree | Busca de médicos por área |

---

## 7. Access Patterns Principais

1. **Recepção**: "Qual a agenda do Dr. X hoje?" → filtro por `id_medico` + `data_consulta`
2. **Médico**: "Histórico do paciente Y" → filtro por `cpf` → `id_paciente`
3. **Gerência**: "Faturamento deste mês" → agregação por `data_consulta` + `status`
4. **Marketing**: "Pacientes sem consulta há 6 meses" → `MAX(data_consulta)` por paciente
5. **Gestão**: "Qual especialidade mais rentável?" → JOIN especialidade + médico + consulta