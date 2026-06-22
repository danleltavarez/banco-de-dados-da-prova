🏥 Clínica Médica — Banco de Dados

Sistema de banco de dados relacional para gerenciamento de uma clínica médica, desenvolvido com PostgreSQL 15 como projeto da disciplina de Desenvolvimento Web — 2º Bimestre 2026.


📋 Sobre o Projeto

O sistema foi desenvolvido para gerenciar o ciclo completo de atendimento de uma clínica médica: cadastro de pacientes e médicos, controle de convênios, agenda de horários e registro de consultas.

O banco é composto por 6 tabelas que se relacionam entre si:


convenio — planos de saúde parceiros (Unimed, Bradesco Saúde, SulAmérica, Amil)
especialidade — especialidades médicas disponíveis na clínica (Cardiologia, Dermatologia, Ortopedia, entre outras)
paciente — dados pessoais dos pacientes e vínculo com convênio
medico — cadastro dos médicos, CRM, especialidade e valor de consulta
agenda — dias da semana e horários disponíveis de cada médico
consulta — tabela central do sistema, registra cada atendimento ligando paciente e médico, com status, motivo, diagnóstico e valor cobrado



🗂️ Arquivos do Projeto

clinica-bd/
├── README.md
├── modelagem/
│   ├── der.png                  # Diagrama Entidade-Relacionamento
│   ├── modelo_logico.png        # Modelo Lógico Relacional
│   └── dicionario_dados.md      # Dicionário de dados completo
├── scripts/
│   ├── setup.sql                # Criação das tabelas, constraints e índices
│   └── dados_teste.sql          # Dados fictícios para teste (100+ registros)
├── queries/
│   └── consultas_avancadas.sql  # 5 consultas críticas do sistema
└── justificativa/
    └── arquitetura.md           # Justificativa técnica detalhada


🧠 Por que PostgreSQL?

O modelo de dados é relacional por natureza

Os dados da clínica possuem relacionamentos bem definidos e constantes: um paciente pertence a um convênio, um médico pertence a uma especialidade, uma consulta obrigatoriamente liga um paciente a um médico. Esse tipo de estrutura é exatamente o que bancos relacionais resolvem — os dados não existem de forma independente, eles dependem uns dos outros.

Usar um banco NoSQL como MongoDB aqui não faria sentido técnico, pois os dados não são documentos isolados. Forçar esse modelo em documentos significaria duplicar informações (guardar os dados do médico dentro de cada consulta, por exemplo), o que geraria inconsistência e dificuldade de manutenção.

Integridade garantida na camada de dados

O PostgreSQL permite definir regras diretamente no banco, independente da aplicação. No projeto foram aplicados:


Foreign Keys com ON DELETE SET NULL e ON DELETE CASCADE para garantir que nenhuma consulta fique órfã
CHECK constraints com expressão regular para validar CPF (^\d{3}\.\d{3}\.\d{3}-\d{2}$) e CNPJ dos convênios direto no banco
CHECK no status da consulta — o banco aceita apenas AGENDADA, REALIZADA, CANCELADA ou FALTA, rejeitando qualquer outro valor


Isso significa que mesmo que a aplicação tenha um bug e tente gravar um dado inválido, o banco barra a operação e mantém a consistência dos dados.

Recursos avançados utilizados

O PostgreSQL oferece funcionalidades que foram usadas nas consultas críticas do sistema:


FILTER (WHERE ...) dentro de agregações — permite contar e somar com condições diferentes numa única query, sem precisar de múltiplos SELECTs. Usado no relatório financeiro mensal para calcular total de realizadas, canceladas e faturamento ao mesmo tempo
DATE_TRUNC('month', CURRENT_DATE) — para filtrar consultas do mês atual de forma precisa
NULLIF(..., 0) — evita divisão por zero no cálculo de taxa de realização por especialidade
Índices B-Tree otimizados nas colunas de busca mais frequentes: CPF do paciente, data da consulta, médico e status


Por que não MySQL?

MySQL também é relacional e seria funcional para este projeto. A escolha do PostgreSQL se justifica pelos recursos de agregação condicional com FILTER, pelo suporte mais robusto a expressões regulares nos CHECK constraints e pela integração direta com o ambiente Docker usado no projeto de infraestrutura, onde já utilizamos a imagem oficial postgres:15-alpine.


📊 Dados de Teste

O arquivo dados_teste.sql contém dados fictícios coerentes com o domínio da clínica:

TabelaRegistrosConvênios5Especialidades8Médicos10Pacientes40Slots de agenda21Consultas60

As consultas estão distribuídas entre janeiro e maio de 2025, com status variados (realizadas, canceladas, agendadas e faltas), permitindo testar todos os cenários das queries críticas