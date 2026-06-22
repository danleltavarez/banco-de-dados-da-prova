# Dicionário de Dados — Sistema de Clínica Médica

## Tabela: `convenio`

| Coluna | Tipo | Nulo | Padrão | Descrição |
|---|---|---|---|---|
| id_convenio | SERIAL | NÃO | auto | PK — identificador do convênio |
| nome | VARCHAR(100) | NÃO | — | Nome do plano de saúde |
| cnpj | CHAR(18) | NÃO | — | CNPJ formatado (único) |
| telefone | VARCHAR(20) | SIM | — | Telefone de contato |
| ativo | BOOLEAN | NÃO | TRUE | Se o convênio está ativo |

---

## Tabela: `especialidade`

| Coluna | Tipo | Nulo | Padrão | Descrição |
|---|---|---|---|---|
| id_especialidade | SERIAL | NÃO | auto | PK — identificador da especialidade |
| nome | VARCHAR(100) | NÃO | — | Nome da especialidade (único) |
| descricao | TEXT | SIM | — | Descrição detalhada |

---

## Tabela: `paciente`

| Coluna | Tipo | Nulo | Padrão | Descrição |
|---|---|---|---|---|
| id_paciente | SERIAL | NÃO | auto | PK — identificador do paciente |
| nome | VARCHAR(150) | NÃO | — | Nome completo |
| cpf | CHAR(14) | NÃO | — | CPF no formato 000.000.000-00 (único) |
| data_nascimento | DATE | NÃO | — | Data de nascimento |
| sexo | CHAR(1) | NÃO | — | M = Masculino, F = Feminino, O = Outro |
| telefone | VARCHAR(20) | SIM | — | Telefone para contato |
| email | VARCHAR(150) | SIM | — | Email do paciente |
| logradouro | VARCHAR(200) | SIM | — | Rua, número, bairro |
| cidade | VARCHAR(100) | SIM | — | Cidade |
| estado | CHAR(2) | SIM | — | UF (ex: SP, RJ) |
| id_convenio | INT | SIM | — | FK → convenio; NULL se particular |
| data_cadastro | TIMESTAMP | NÃO | NOW() | Data de cadastro no sistema |

---

## Tabela: `medico`

| Coluna | Tipo | Nulo | Padrão | Descrição |
|---|---|---|---|---|
| id_medico | SERIAL | NÃO | auto | PK — identificador do médico |
| nome | VARCHAR(150) | NÃO | — | Nome completo |
| crm | VARCHAR(20) | NÃO | — | CRM (único, ex: CRM/SP-123456) |
| cpf | CHAR(14) | NÃO | — | CPF no formato 000.000.000-00 (único) |
| telefone | VARCHAR(20) | SIM | — | Telefone de contato |
| email | VARCHAR(150) | SIM | — | Email profissional |
| id_especialidade | INT | NÃO | — | FK → especialidade |
| valor_consulta | NUMERIC(10,2) | NÃO | — | Valor cobrado por consulta |
| ativo | BOOLEAN | NÃO | TRUE | Se o médico está ativo na clínica |

---

## Tabela: `agenda`

| Coluna | Tipo | Nulo | Padrão | Descrição |
|---|---|---|---|---|
| id_agenda | SERIAL | NÃO | auto | PK — identificador do horário |
| id_medico | INT | NÃO | — | FK → medico |
| dia_semana | SMALLINT | NÃO | — | 0=Dom, 1=Seg, 2=Ter, 3=Qua, 4=Qui, 5=Sex, 6=Sáb |
| hora_inicio | TIME | NÃO | — | Hora de início do expediente |
| hora_fim | TIME | NÃO | — | Hora de fim do expediente |

---

## Tabela: `consulta`

| Coluna | Tipo | Nulo | Padrão | Descrição |
|---|---|---|---|---|
| id_consulta | SERIAL | NÃO | auto | PK — identificador da consulta |
| id_paciente | INT | NÃO | — | FK → paciente |
| id_medico | INT | NÃO | — | FK → medico |
| data_consulta | TIMESTAMP | NÃO | — | Data e hora da consulta |
| status | VARCHAR(20) | NÃO | 'AGENDADA' | AGENDADA / REALIZADA / CANCELADA / FALTA |
| motivo | TEXT | SIM | — | Motivo da consulta informado pelo paciente |
| diagnostico | TEXT | SIM | — | Diagnóstico registrado pelo médico (após realização) |
| valor_cobrado | NUMERIC(10,2) | SIM | — | Valor efetivamente cobrado |
| coberto_convenio | BOOLEAN | NÃO | FALSE | Se a consulta foi coberta pelo convênio |
| data_criacao | TIMESTAMP | NÃO | NOW() | Data de registro no sistema |