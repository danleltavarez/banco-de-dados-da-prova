-- ============================================================
-- CONSULTAS CRÍTICAS DO SISTEMA
-- 5 consultas relevantes com justificativa e otimização
-- ============================================================

-- ============================================================
-- CONSULTA 1 — Agenda do dia para um médico específico
-- IMPORTÂNCIA: Principal funcionalidade da recepção. Precisa
-- ser rápida pois é executada dezenas de vezes ao dia.
-- OTIMIZAÇÃO: Usa idx_consulta_medico + idx_consulta_data
-- ============================================================
SELECT
    c.id_consulta,
    c.data_consulta::TIME                  AS horario,
    p.nome                                 AS paciente,
    p.telefone,
    c.motivo,
    c.status,
    COALESCE(cv.nome, 'Particular')        AS convenio
FROM consulta c
JOIN paciente p ON p.id_paciente = c.id_paciente
LEFT JOIN convenio cv ON cv.id_convenio = p.id_convenio
WHERE c.id_medico = 1
  AND c.data_consulta::DATE = CURRENT_DATE
ORDER BY c.data_consulta;


-- ============================================================
-- CONSULTA 2 — Histórico completo de um paciente (pelo CPF)
-- IMPORTÂNCIA: Médico precisa ver todo o histórico antes
-- de atender. JOIN entre 3 tabelas.
-- OTIMIZAÇÃO: Usa idx_paciente_cpf + idx_consulta_paciente
-- ============================================================
SELECT
    c.data_consulta,
    m.nome                   AS medico,
    e.nome                   AS especialidade,
    c.motivo,
    c.diagnostico,
    c.status,
    c.valor_cobrado,
    CASE WHEN c.coberto_convenio THEN 'Sim' ELSE 'Não' END AS coberto_convenio
FROM consulta c
JOIN medico m      ON m.id_medico      = c.id_medico
JOIN especialidade e ON e.id_especialidade = m.id_especialidade
WHERE c.id_paciente = (
    SELECT id_paciente FROM paciente WHERE cpf = '001.002.003-04'
)
ORDER BY c.data_consulta DESC;


-- ============================================================
-- CONSULTA 3 — Relatório financeiro mensal por médico
-- IMPORTÂNCIA: Controle financeiro da clínica. Agregação
-- com GROUP BY + filtragem por período.
-- OTIMIZAÇÃO: Usa idx_consulta_data + idx_consulta_medico
-- ============================================================
SELECT
    m.nome                                  AS medico,
    e.nome                                  AS especialidade,
    COUNT(*)                                AS total_consultas,
    COUNT(*) FILTER (WHERE c.status = 'REALIZADA')  AS realizadas,
    COUNT(*) FILTER (WHERE c.status = 'CANCELADA')  AS canceladas,
    COUNT(*) FILTER (WHERE c.status = 'FALTA')       AS faltas,
    SUM(c.valor_cobrado)
        FILTER (WHERE c.status = 'REALIZADA')        AS faturamento_total,
    AVG(c.valor_cobrado)
        FILTER (WHERE c.status = 'REALIZADA')        AS ticket_medio
FROM consulta c
JOIN medico m       ON m.id_medico           = c.id_medico
JOIN especialidade e ON e.id_especialidade   = m.id_especialidade
WHERE c.data_consulta >= DATE_TRUNC('month', CURRENT_DATE)
  AND c.data_consulta <  DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
GROUP BY m.id_medico, m.nome, e.nome
ORDER BY faturamento_total DESC NULLS LAST;


-- ============================================================
-- CONSULTA 4 — Pacientes com consultas agendadas e sem retorno
-- há mais de 6 meses (identificar pacientes inativos)
-- IMPORTÂNCIA: Estratégia de reativação de pacientes.
-- Filtro por data + subquery de NOT EXISTS.
-- OTIMIZAÇÃO: Usa idx_consulta_paciente + idx_consulta_data
-- ============================================================
SELECT
    p.nome,
    p.cpf,
    p.telefone,
    p.email,
    MAX(c.data_consulta)::DATE              AS ultima_consulta,
    COALESCE(cv.nome, 'Particular')         AS convenio
FROM paciente p
JOIN consulta c    ON c.id_paciente  = p.id_paciente
LEFT JOIN convenio cv ON cv.id_convenio = p.id_convenio
WHERE c.status = 'REALIZADA'
GROUP BY p.id_paciente, p.nome, p.cpf, p.telefone, p.email, cv.nome
HAVING MAX(c.data_consulta) < CURRENT_DATE - INTERVAL '6 months'
ORDER BY ultima_consulta ASC;


-- ============================================================
-- CONSULTA 5 — Ranking de especialidades por demanda e receita
-- IMPORTÂNCIA: Auxilia gestão a decidir contratações e
-- alocação de recursos. Múltiplos JOINs + agregação.
-- OTIMIZAÇÃO: Usa idx_medico_especialidade + idx_consulta_data
-- ============================================================
SELECT
    e.nome                                       AS especialidade,
    COUNT(DISTINCT m.id_medico)                  AS qtd_medicos,
    COUNT(c.id_consulta)                         AS total_agendamentos,
    COUNT(c.id_consulta)
        FILTER (WHERE c.status = 'REALIZADA')    AS consultas_realizadas,
    ROUND(
        100.0 * COUNT(c.id_consulta) FILTER (WHERE c.status = 'REALIZADA')
        / NULLIF(COUNT(c.id_consulta), 0), 1
    )                                            AS taxa_realizacao_pct,
    SUM(c.valor_cobrado)
        FILTER (WHERE c.status = 'REALIZADA')    AS receita_total
FROM especialidade e
LEFT JOIN medico m    ON m.id_especialidade = e.id_especialidade AND m.ativo = TRUE
LEFT JOIN consulta c  ON c.id_medico        = m.id_medico
GROUP BY e.id_especialidade, e.nome
ORDER BY receita_total DESC NULLS LAST;