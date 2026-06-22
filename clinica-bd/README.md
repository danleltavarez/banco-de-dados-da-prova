# 🏥 Clínica Médica — Banco de Dados

> Banco de dados relacional para sistema de gerenciamento de clínica médica.
> Desenvolvido com **PostgreSQL 15**, rodando via **Docker**.

---

## 📁 Estrutura do Repositório

```
clinica-bd/
├── README.md
├── modelagem/
│   ├── der.png                   # Diagrama Entidade-Relacionamento
│   ├── modelo_logico.png         # Modelo Lógico Relacional
│   └── dicionario_dados.md       # Dicionário de dados
├── scripts/
│   ├── setup.sql                 # DDL: criação de todas as tabelas e índices
│   └── dados_teste.sql           # Seed: dados fictícios para teste (100+ registros)
├── queries/
│   └── consultas_avancadas.sql   # 5 consultas críticas do sistema
└── justificativa/
    └── arquitetura.md            # Justificativa da escolha tecnológica
```

---

## 🗄️ Tabelas do Banco

| Tabela | Descrição |
|---|---|
| `convenio` | Planos de saúde parceiros da clínica |
| `especialidade` | Especialidades médicas disponíveis |
| `paciente` | Dados pessoais dos pacientes |
| `medico` | Cadastro dos médicos e seus valores de consulta |
| `agenda` | Horários disponíveis de cada médico por dia da semana |
| `consulta` | Registro de todos os atendimentos agendados e realizados |

---

## ⚙️ Pré-requisitos

Tenha instalado na máquina (WSL2 ou Linux):

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- `psql` (cliente PostgreSQL) — opcional, para rodar comandos manuais

Verificar se o Docker está rodando:
```bash
docker --version
docker ps
```

---

## 🚀 Como Executar (passo a passo)

### Opção 1 — Via Docker Compose (junto com a aplicação)

Se você estiver usando o projeto completo com `docker-compose.yml`, o banco já sobe automaticamente. Na raiz do projeto:

```bash
docker compose up -d --build
```

Aguarde o container `clinica_db` ficar saudável, depois rode os scripts:

```bash
# Criar as tabelas
docker exec -i clinica_db psql -U clinica_user -d clinica_db < scripts/setup.sql

# Popular com dados de teste
docker exec -i clinica_db psql -U clinica_user -d clinica_db < scripts/dados_teste.sql
```

---

### Opção 2 — Apenas o banco (sem a aplicação)

Sobe um container PostgreSQL isolado:

```bash
docker run -d \
  --name clinica_db \
  -e POSTGRES_USER=clinica_user \
  -e POSTGRES_PASSWORD=clinica_pass \
  -e POSTGRES_DB=clinica_db \
  -v clinica_pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:15-alpine
```

Aguardar o banco inicializar (uns 5 segundos), depois executar os scripts:

```bash
# Criar as tabelas, constraints e índices
docker exec -i clinica_db psql -U clinica_user -d clinica_db < scripts/setup.sql

# Inserir dados de teste
docker exec -i clinica_db psql -U clinica_user -d clinica_db < scripts/dados_teste.sql
```

---

## ✅ Verificando se tudo funcionou

### Listar tabelas criadas
```bash
docker exec -it clinica_db psql -U clinica_user -d clinica_db -c "\dt"
```

Saída esperada:
```
          List of relations
 Schema |     Name     | Type  |    Owner
--------+--------------+-------+-------------
 public | agenda       | table | clinica_user
 public | consulta     | table | clinica_user
 public | convenio     | table | clinica_user
 public | especialidade| table | clinica_user
 public | medico       | table | clinica_user
 public | paciente     | table | clinica_user
```

### Contar registros inseridos
```bash
docker exec -it clinica_db psql -U clinica_user -d clinica_db -c "
SELECT 'convenio'     AS tabela, COUNT(*) AS registros FROM convenio
UNION ALL
SELECT 'especialidade', COUNT(*) FROM especialidade
UNION ALL
SELECT 'medico',        COUNT(*) FROM medico
UNION ALL
SELECT 'paciente',      COUNT(*) FROM paciente
UNION ALL
SELECT 'agenda',        COUNT(*) FROM agenda
UNION ALL
SELECT 'consulta',      COUNT(*) FROM consulta;
"
```

Saída esperada:
```
    tabela     | registros
---------------+-----------
 convenio      |         5
 especialidade |         8
 medico        |        10
 paciente      |        40
 agenda        |        21
 consulta      |        60
```

### Listar índices criados
```bash
docker exec -it clinica_db psql -U clinica_user -d clinica_db -c "\di"
```

---

## 🧪 Testando as Consultas Críticas

As 5 consultas principais do sistema estão em `queries/consultas_avancadas.sql`. Para rodar todas de uma vez:

```bash
docker exec -i clinica_db psql -U clinica_user -d clinica_db < queries/consultas_avancadas.sql
```

Ou rode uma por vez entrando no psql interativo:

```bash
docker exec -it clinica_db psql -U clinica_user -d clinica_db
```

Exemplo — histórico de um paciente pelo CPF:
```sql
SELECT c.data_consulta, m.nome AS medico, e.nome AS especialidade, c.motivo, c.diagnostico
FROM consulta c
JOIN medico m       ON m.id_medico       = c.id_medico
JOIN especialidade e ON e.id_especialidade = m.id_especialidade
WHERE c.id_paciente = (
    SELECT id_paciente FROM paciente WHERE cpf = '001.002.003-04'
)
ORDER BY c.data_consulta DESC;
```

---

## 💾 Testando a Persistência dos Dados

Reinicie o container e confirme que os dados continuam existindo (Named Volume garante isso):

```bash
# Reiniciar o banco
docker restart clinica_db

# Aguardar 3 segundos e verificar
sleep 3
docker exec -it clinica_db psql -U clinica_user -d clinica_db \
  -c "SELECT COUNT(*) AS pacientes FROM paciente;"
```

Se retornar `40`, a persistência está funcionando corretamente.

---

## 🔒 Segurança e Variáveis de Ambiente

As credenciais do banco são gerenciadas via arquivo `.env`. **Nunca commite senhas reais no repositório.**

Crie o arquivo `.env` baseado no exemplo:
```bash
cp .env.example .env
```

Conteúdo do `.env.example`:
```env
POSTGRES_USER=clinica_user
POSTGRES_PASSWORD=sua_senha_aqui
POSTGRES_DB=clinica_db
DATABASE_URL=postgresql://clinica_user:sua_senha_aqui@db:5432/clinica_db
```

> ⚠️ O `.gitignore` já ignora o arquivo `.env`. Nunca remova essa linha.

---

## 🔧 Troubleshooting

**Erro: `could not connect to server`**
```bash
# Verificar se o container está rodando
docker ps | grep clinica_db

# Se não estiver, iniciar
docker start clinica_db
```

**Erro: `FATAL: role "clinica_user" does not exist`**
```bash
docker exec -it clinica_db psql -U postgres -c \
  "CREATE USER clinica_user WITH PASSWORD 'clinica_pass';"
docker exec -it clinica_db psql -U postgres -c \
  "CREATE DATABASE clinica_db OWNER clinica_user;"
```

**Erro: `port 5432 already in use`**
```bash
# Verificar o que está usando a porta
sudo lsof -i :5432

# Parar o PostgreSQL local se estiver rodando
sudo service postgresql stop
```

**Tabelas não existem após subir o container**
```bash
# Rodar o setup novamente
docker exec -i clinica_db psql -U clinica_user -d clinica_db < scripts/setup.sql
```

**Dados não aparecem após reiniciar**
```bash
# Verificar se o volume existe
docker volume ls | grep clinica_pgdata

# Se não existir, recriar e rodar os scripts novamente
```

---

## 🧹 Limpeza de Recursos

```bash
# Parar e remover o container (mantém os dados no volume)
docker stop clinica_db && docker rm clinica_db

# Parar e remover tudo, incluindo os dados (CUIDADO — irreversível)
docker stop clinica_db && docker rm clinica_db
docker volume rm clinica_pgdata

# Via Docker Compose (remove containers e volumes)
docker compose down -v
```
