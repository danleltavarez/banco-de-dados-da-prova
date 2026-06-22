-- ============================================================
-- SISTEMA DE CLÍNICA MÉDICA - SCRIPT DDL
-- Banco de Dados: PostgreSQL
-- ============================================================

-- Remover tabelas se já existirem (ordem inversa das dependências)
DROP TABLE IF EXISTS consulta CASCADE;
DROP TABLE IF EXISTS agenda CASCADE;
DROP TABLE IF EXISTS medico CASCADE;
DROP TABLE IF EXISTS especialidade CASCADE;
DROP TABLE IF EXISTS paciente CASCADE;
DROP TABLE IF EXISTS convenio CASCADE;

-- ============================================================
-- TABELA: convenio
-- ============================================================
CREATE TABLE convenio (
    id_convenio     SERIAL          PRIMARY KEY,
    nome            VARCHAR(100)    NOT NULL,
    cnpj            CHAR(18)        NOT NULL UNIQUE,
    telefone        VARCHAR(20),
    ativo           BOOLEAN         NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_cnpj CHECK (cnpj ~ '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$')
);

-- ============================================================
-- TABELA: especialidade
-- ============================================================
CREATE TABLE especialidade (
    id_especialidade    SERIAL          PRIMARY KEY,
    nome                VARCHAR(100)    NOT NULL UNIQUE,
    descricao           TEXT
);

-- ============================================================
-- TABELA: paciente
-- ============================================================
CREATE TABLE paciente (
    id_paciente     SERIAL          PRIMARY KEY,
    nome            VARCHAR(150)    NOT NULL,
    cpf             CHAR(14)        NOT NULL UNIQUE,
    data_nascimento DATE            NOT NULL,
    sexo            CHAR(1)         NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(150),
    logradouro      VARCHAR(200),
    cidade          VARCHAR(100),
    estado          CHAR(2),
    id_convenio     INT             REFERENCES convenio(id_convenio) ON DELETE SET NULL,
    data_cadastro   TIMESTAMP       NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_cpf   CHECK (cpf ~ '^\d{3}\.\d{3}\.\d{3}-\d{2}$'),
    CONSTRAINT chk_sexo  CHECK (sexo IN ('M', 'F', 'O'))
);

-- ============================================================
-- TABELA: medico
-- ============================================================
CREATE TABLE medico (
    id_medico           SERIAL          PRIMARY KEY,
    nome                VARCHAR(150)    NOT NULL,
    crm                 VARCHAR(20)     NOT NULL UNIQUE,
    cpf                 CHAR(14)        NOT NULL UNIQUE,
    telefone            VARCHAR(20),
    email               VARCHAR(150),
    id_especialidade    INT             NOT NULL REFERENCES especialidade(id_especialidade),
    valor_consulta      NUMERIC(10,2)   NOT NULL CHECK (valor_consulta > 0),
    ativo               BOOLEAN         NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_cpf_med CHECK (cpf ~ '^\d{3}\.\d{3}\.\d{3}-\d{2}$')
);

-- ============================================================
-- TABELA: agenda
-- Representa os horários disponíveis de cada médico
-- ============================================================
CREATE TABLE agenda (
    id_agenda       SERIAL          PRIMARY KEY,
    id_medico       INT             NOT NULL REFERENCES medico(id_medico) ON DELETE CASCADE,
    dia_semana      SMALLINT        NOT NULL CHECK (dia_semana BETWEEN 0 AND 6), -- 0=Domingo
    hora_inicio     TIME            NOT NULL,
    hora_fim        TIME            NOT NULL,
    CONSTRAINT chk_horario CHECK (hora_fim > hora_inicio),
    CONSTRAINT uq_agenda UNIQUE (id_medico, dia_semana, hora_inicio)
);

-- ============================================================
-- TABELA: consulta
-- ============================================================
CREATE TABLE consulta (
    id_consulta         SERIAL          PRIMARY KEY,
    id_paciente         INT             NOT NULL REFERENCES paciente(id_paciente),
    id_medico           INT             NOT NULL REFERENCES medico(id_medico),
    data_consulta       TIMESTAMP       NOT NULL,
    status              VARCHAR(20)     NOT NULL DEFAULT 'AGENDADA',
    motivo              TEXT,
    diagnostico         TEXT,
    valor_cobrado       NUMERIC(10,2)   CHECK (valor_cobrado >= 0),
    coberto_convenio    BOOLEAN         NOT NULL DEFAULT FALSE,
    data_criacao        TIMESTAMP       NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_status CHECK (status IN ('AGENDADA','REALIZADA','CANCELADA','FALTA'))
);

-- ============================================================
-- ÍNDICES
-- ============================================================

-- Buscas frequentes por CPF do paciente
CREATE INDEX idx_paciente_cpf        ON paciente(cpf);

-- Filtros por data de consulta (relatórios, agenda do dia)
CREATE INDEX idx_consulta_data       ON consulta(data_consulta);

-- Filtros por status de consulta
CREATE INDEX idx_consulta_status     ON consulta(status);

-- Busca de consultas por paciente
CREATE INDEX idx_consulta_paciente   ON consulta(id_paciente);

-- Busca de consultas por médico
CREATE INDEX idx_consulta_medico     ON consulta(id_medico);

-- Busca de médicos por especialidade
CREATE INDEX idx_medico_especialidade ON medico(id_especialidade);