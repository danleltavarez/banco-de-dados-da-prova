-- ============================================================
-- SEED — Dados fictícios para teste
-- Mínimo de 100 registros relevantes
-- ============================================================

-- ============================================================
-- CONVÊNIOS (5)
-- ============================================================
INSERT INTO convenio (nome, cnpj, telefone) VALUES
('Unimed',          '12.345.678/0001-90', '(11) 3000-1000'),
('Bradesco Saúde',  '23.456.789/0001-01', '(11) 3000-2000'),
('SulAmérica',      '34.567.890/0001-12', '(11) 3000-3000'),
('Amil',            '45.678.901/0001-23', '(11) 3000-4000'),
('Particular',      '56.789.012/0001-34', NULL);

-- ============================================================
-- ESPECIALIDADES (8)
-- ============================================================
INSERT INTO especialidade (nome, descricao) VALUES
('Clínica Geral',     'Atendimento geral e triagem'),
('Cardiologia',       'Doenças do coração e sistema cardiovascular'),
('Dermatologia',      'Doenças da pele, cabelo e unhas'),
('Ortopedia',         'Sistema musculoesquelético'),
('Pediatria',         'Saúde de crianças e adolescentes'),
('Ginecologia',       'Saúde da mulher'),
('Neurologia',        'Sistema nervoso central e periférico'),
('Oftalmologia',      'Saúde ocular e visão');

-- ============================================================
-- MÉDICOS (10)
-- ============================================================
INSERT INTO medico (nome, crm, cpf, telefone, email, id_especialidade, valor_consulta) VALUES
('Dr. Carlos Souza',       'CRM/SP-123456', '111.222.333-44', '(11) 98000-0001', 'carlos@clinica.com',  1, 150.00),
('Dra. Ana Lima',          'CRM/SP-234567', '222.333.444-55', '(11) 98000-0002', 'ana@clinica.com',     2, 300.00),
('Dr. Roberto Fernandes',  'CRM/SP-345678', '333.444.555-66', '(11) 98000-0003', 'roberto@clinica.com', 3, 250.00),
('Dra. Patrícia Martins',  'CRM/SP-456789', '444.555.666-77', '(11) 98000-0004', 'patricia@clinica.com',4, 280.00),
('Dr. Felipe Oliveira',    'CRM/SP-567890', '555.666.777-88', '(11) 98000-0005', 'felipe@clinica.com',  5, 200.00),
('Dra. Mariana Costa',     'CRM/SP-678901', '666.777.888-99', '(11) 98000-0006', 'mariana@clinica.com', 6, 260.00),
('Dr. Gustavo Pereira',    'CRM/SP-789012', '777.888.999-00', '(11) 98000-0007', 'gustavo@clinica.com', 7, 320.00),
('Dra. Juliana Rocha',     'CRM/SP-890123', '888.999.000-11', '(11) 98000-0008', 'juliana@clinica.com', 8, 240.00),
('Dr. André Nascimento',   'CRM/SP-901234', '999.000.111-22', '(11) 98000-0009', 'andre@clinica.com',   1, 160.00),
('Dra. Fernanda Alves',    'CRM/SP-012345', '000.111.222-33', '(11) 98000-0010', 'fernanda@clinica.com',2, 310.00);

-- ============================================================
-- AGENDAS DOS MÉDICOS
-- ============================================================
INSERT INTO agenda (id_medico, dia_semana, hora_inicio, hora_fim) VALUES
(1, 1, '08:00', '12:00'), (1, 3, '08:00', '12:00'), (1, 5, '08:00', '12:00'),
(2, 2, '09:00', '17:00'), (2, 4, '09:00', '17:00'),
(3, 1, '13:00', '18:00'), (3, 3, '13:00', '18:00'),
(4, 2, '07:00', '12:00'), (4, 5, '07:00', '12:00'),
(5, 1, '08:00', '17:00'), (5, 4, '08:00', '17:00'),
(6, 3, '09:00', '15:00'), (6, 5, '09:00', '15:00'),
(7, 2, '10:00', '18:00'), (7, 4, '10:00', '18:00'),
(8, 1, '08:00', '13:00'), (8, 3, '08:00', '13:00'),
(9, 2, '13:00', '18:00'), (9, 5, '13:00', '18:00'),
(10,4, '08:00', '14:00'), (10,1, '08:00', '14:00');

-- ============================================================
-- PACIENTES (40)
-- ============================================================
INSERT INTO paciente (nome, cpf, data_nascimento, sexo, telefone, email, logradouro, cidade, estado, id_convenio) VALUES
('Lucas Andrade',        '001.002.003-04', '1990-03-15', 'M', '(11) 91000-0001', 'lucas@email.com',    'Rua das Flores, 10',       'São Paulo',   'SP', 1),
('Beatriz Santos',       '002.003.004-05', '1985-07-22', 'F', '(11) 91000-0002', 'beatriz@email.com',  'Av. Brasil, 200',          'São Paulo',   'SP', 2),
('Marcos Ribeiro',       '003.004.005-06', '1978-11-30', 'M', '(11) 91000-0003', 'marcos@email.com',   'Rua Pinheiros, 55',        'Campinas',    'SP', 3),
('Camila Ferreira',      '004.005.006-07', '1995-01-10', 'F', '(11) 91000-0004', 'camila@email.com',   'Rua do Sol, 300',          'São Paulo',   'SP', 1),
('Pedro Carvalho',       '005.006.007-08', '2000-06-18', 'M', '(11) 91000-0005', 'pedro@email.com',    'Av. Paulista, 1000',       'São Paulo',   'SP', 4),
('Isabela Mendes',       '006.007.008-09', '1992-09-05', 'F', '(11) 91000-0006', 'isabela@email.com',  'Rua das Acácias, 88',      'Guarulhos',   'SP', 2),
('Rafael Lima',          '007.008.009-10', '1988-04-20', 'M', '(11) 91000-0007', 'rafael@email.com',   'Rua XV de Novembro, 45',   'Santo André', 'SP', 5),
('Juliana Gomes',        '008.009.010-11', '1975-12-01', 'F', '(11) 91000-0008', 'juliana@email.com',  'Rua da Paz, 12',           'São Paulo',   'SP', 3),
('Thiago Almeida',       '009.010.011-12', '2003-02-28', 'M', '(11) 91000-0009', 'thiago@email.com',   'Av. Norte, 500',           'Osasco',      'SP', 1),
('Larissa Barbosa',      '010.011.012-13', '1998-08-14', 'F', '(11) 91000-0010', 'larissa@email.com',  'Rua Sul, 77',              'São Paulo',   'SP', 4),
('Bruno Castro',         '011.012.013-14', '1982-05-09', 'M', '(11) 91000-0011', 'bruno@email.com',    'Rua Leste, 33',            'Campinas',    'SP', 2),
('Fernanda Dias',        '012.013.014-15', '1970-10-25', 'F', '(11) 91000-0012', 'fernanda@email.com', 'Av. Oeste, 900',           'São Paulo',   'SP', 1),
('Guilherme Nunes',      '013.014.015-16', '1993-03-03', 'M', '(11) 91000-0013', 'guilherme@email.com','Rua Nova, 66',             'São Paulo',   'SP', 3),
('Amanda Teixeira',      '014.015.016-17', '1987-07-17', 'F', '(11) 91000-0014', 'amanda@email.com',   'Rua Velha, 21',            'Guarulhos',   'SP', 5),
('Vinicius Pinto',       '015.016.017-18', '2001-11-11', 'M', '(11) 91000-0015', 'vinicius@email.com', 'Rua das Rosas, 14',        'São Paulo',   'SP', 2),
('Carolina Moura',       '016.017.018-19', '1996-04-04', 'F', '(11) 91000-0016', 'carolina@email.com', 'Rua dos Ipês, 250',        'Jundiaí',     'SP', 4),
('Eduardo Correia',      '017.018.019-20', '1979-08-08', 'M', '(11) 91000-0017', 'eduardo@email.com',  'Av. Central, 400',         'São Paulo',   'SP', 1),
('Mariana Freitas',      '018.019.020-21', '1991-02-14', 'F', '(11) 91000-0018', 'mariana@email.com',  'Rua do Campo, 18',         'São Paulo',   'SP', 3),
('Rodrigo Cardoso',      '019.020.021-22', '1984-06-30', 'M', '(11) 91000-0019', 'rodrigo@email.com',  'Rua do Mar, 90',           'Santos',      'SP', 2),
('Natália Cavalcanti',   '020.021.022-23', '1999-09-09', 'F', '(11) 91000-0020', 'natalia@email.com',  'Av. Beira Rio, 5',         'São Paulo',   'SP', 5),
('Felipe Azevedo',       '021.022.023-24', '1986-01-19', 'M', '(11) 91000-0021', 'felipea@email.com',  'Rua da Serra, 120',        'Campinas',    'SP', 1),
('Priscila Borges',      '022.023.024-25', '1973-05-23', 'F', '(11) 91000-0022', 'priscila@email.com', 'Rua do Vale, 60',          'São Paulo',   'SP', 4),
('Leonardo Cunha',       '023.024.025-26', '2002-10-10', 'M', '(11) 91000-0023', 'leonardo@email.com', 'Av. Flores, 800',          'São Paulo',   'SP', 2),
('Tatiana Duarte',       '024.025.026-27', '1994-03-27', 'F', '(11) 91000-0024', 'tatiana@email.com',  'Rua das Palmeiras, 35',    'Sorocaba',    'SP', 3),
('Henrique Esteves',     '025.026.027-28', '1981-07-07', 'M', '(11) 91000-0025', 'henrique@email.com', 'Rua Girassóis, 11',        'São Paulo',   'SP', 1),
('Bruna Figueiredo',     '026.027.028-29', '1997-12-12', 'F', '(11) 91000-0026', 'bruna@email.com',    'Rua Hortênsias, 70',       'São Paulo',   'SP', 5),
('Matheus Guimarães',    '027.028.029-30', '1989-04-16', 'M', '(11) 91000-0027', 'matheus@email.com',  'Rua Margaridas, 99',       'Guarulhos',   'SP', 4),
('Vanessa Henriques',    '028.029.030-31', '1977-08-21', 'F', '(11) 91000-0028', 'vanessa@email.com',  'Av. das Nações, 300',      'São Paulo',   'SP', 2),
('Diego Ibarra',         '029.030.031-32', '2004-01-01', 'M', '(11) 91000-0029', 'diego@email.com',    'Rua dos Lagos, 55',        'Campinas',    'SP', 1),
('Aline Jacinto',        '030.031.032-33', '1983-06-06', 'F', '(11) 91000-0030', 'aline@email.com',    'Rua dos Rios, 22',         'São Paulo',   'SP', 3),
('Caio Lacerda',         '031.032.033-34', '1990-10-14', 'M', '(11) 91000-0031', 'caio@email.com',     'Rua dos Montes, 48',       'São Paulo',   'SP', 5),
('Débora Machado',       '032.033.034-35', '1972-02-20', 'F', '(11) 91000-0032', 'debora@email.com',   'Av. dos Ventos, 150',      'Santos',      'SP', 4),
('Igor Nogueira',        '033.034.035-36', '1995-07-25', 'M', '(11) 91000-0033', 'igor@email.com',     'Rua da Chuva, 63',         'São Paulo',   'SP', 2),
('Sabrina Oliveira',     '034.035.036-37', '1988-11-11', 'F', '(11) 91000-0034', 'sabrina@email.com',  'Rua do Trovão, 17',        'Osasco',      'SP', 1),
('Thales Pacheco',       '035.036.037-38', '2001-03-03', 'M', '(11) 91000-0035', 'thales@email.com',   'Rua da Neve, 84',          'São Paulo',   'SP', 3),
('Viviane Queiroz',      '036.037.038-39', '1976-09-18', 'F', '(11) 91000-0036', 'viviane@email.com',  'Rua do Sol Nascente, 9',   'Campinas',    'SP', 2),
('André Ramos',          '037.038.039-40', '1993-05-05', 'M', '(11) 91000-0037', 'andrer@email.com',   'Av. Sunset, 420',          'São Paulo',   'SP', 1),
('Patrícia Sampaio',     '038.039.040-41', '1980-01-15', 'F', '(11) 91000-0038', 'patricias@email.com','Rua Aurora, 31',           'Jundiaí',     'SP', 4),
('Renato Torres',        '039.040.041-42', '1968-04-28', 'M', '(11) 91000-0039', 'renato@email.com',   'Rua Crepúsculo, 57',       'São Paulo',   'SP', 5),
('Letícia Vieira',       '040.041.042-43', '2005-08-08', 'F', '(11) 91000-0040', 'leticia@email.com',  'Rua Horizonte, 200',       'São Paulo',   'SP', 1);

-- ============================================================
-- CONSULTAS (60+)
-- ============================================================
INSERT INTO consulta (id_paciente, id_medico, data_consulta, status, motivo, diagnostico, valor_cobrado, coberto_convenio) VALUES
(1,  1, '2025-01-05 08:00', 'REALIZADA', 'Dor de cabeça frequente',     'Cefaleia tensional',         150.00, TRUE),
(2,  2, '2025-01-06 09:00', 'REALIZADA', 'Dor no peito ao esforço',     'Angina estável',             300.00, TRUE),
(3,  3, '2025-01-07 13:00', 'REALIZADA', 'Manchas na pele',             'Dermatite atópica',          250.00, TRUE),
(4,  4, '2025-01-08 07:00', 'REALIZADA', 'Dor no joelho',               'Condromalácia patelar',      280.00, TRUE),
(5,  5, '2025-01-09 08:00', 'REALIZADA', 'Febre persistente (criança)', 'Faringite bacteriana',       200.00, FALSE),
(6,  6, '2025-01-10 09:00', 'REALIZADA', 'Exame de rotina ginecológico','Normal',                     260.00, TRUE),
(7,  7, '2025-01-13 10:00', 'REALIZADA', 'Tontura e formigamento',      'Neuropatia periférica leve', 320.00, FALSE),
(8,  8, '2025-01-14 08:00', 'REALIZADA', 'Visão embaçada',              'Miopia progressiva',         240.00, TRUE),
(9,  1, '2025-01-15 08:00', 'REALIZADA', 'Gripe',                       'Síndrome gripal',            150.00, TRUE),
(10, 2, '2025-01-16 09:00', 'REALIZADA', 'Palpitações',                 'Arritmia benigna',           300.00, TRUE),
(11, 3, '2025-01-20 13:00', 'REALIZADA', 'Acne severa',                 'Acne grau III',              250.00, FALSE),
(12, 9, '2025-01-21 13:00', 'REALIZADA', 'Check-up geral',              'Sem alterações',             160.00, TRUE),
(13, 4, '2025-01-22 07:00', 'REALIZADA', 'Lombalgia',                   'Hérnia de disco L4-L5',      280.00, TRUE),
(14, 5, '2025-01-23 08:00', 'REALIZADA', 'Consulta pediátrica rotina',  'Desenvolvimento normal',     200.00, TRUE),
(15, 6, '2025-01-27 09:00', 'CANCELADA', 'Dor pélvica',                  NULL,                        260.00, FALSE),
(16,10, '2025-01-28 08:00', 'REALIZADA', 'Dor no peito (2ª opinião)',   'Pericardite',                310.00, TRUE),
(17, 7, '2025-01-29 10:00', 'FALTA',     'Enxaqueca crônica',            NULL,                        320.00, FALSE),
(18, 8, '2025-02-03 08:00', 'REALIZADA', 'Olho vermelho',               'Conjuntivite viral',         240.00, TRUE),
(19, 1, '2025-02-04 08:00', 'REALIZADA', 'Pressão alta',                'Hipertensão estágio 1',      150.00, FALSE),
(20, 2, '2025-02-05 09:00', 'REALIZADA', 'Exame pré-operatório',        'Liberado para cirurgia',     300.00, TRUE),
(21, 3, '2025-02-10 13:00', 'REALIZADA', 'Queda de cabelo',             'Alopecia androgenética',     250.00, TRUE),
(22, 4, '2025-02-11 07:00', 'REALIZADA', 'Dor no ombro',               'Tendinite do manguito',       280.00, TRUE),
(23, 5, '2025-02-12 08:00', 'REALIZADA', 'Tosse prolongada',           'Asma brônquica',              200.00, FALSE),
(24, 6, '2025-02-13 09:00', 'REALIZADA', 'Menstruação irregular',       'SOP confirmado',             260.00, TRUE),
(25, 9, '2025-02-17 13:00', 'REALIZADA', 'Cansaço excessivo',          'Anemia ferropriva',           160.00, TRUE),
(26,10, '2025-02-18 08:00', 'REALIZADA', 'Controle cardiológico',       'Estável',                    310.00, TRUE),
(27, 7, '2025-02-19 10:00', 'REALIZADA', 'Dor de cabeça intensa',      'Enxaqueca com aura',          320.00, FALSE),
(28, 8, '2025-02-20 08:00', 'REALIZADA', 'Pressão no olho',            'Glaucoma suspeito',           240.00, TRUE),
(29, 1, '2025-02-24 08:00', 'AGENDADA',  'Retorno pressão',             NULL,                         150.00, TRUE),
(30, 2, '2025-02-25 09:00', 'AGENDADA',  'ECG de controle',             NULL,                         300.00, TRUE),
(31, 3, '2025-03-03 13:00', 'REALIZADA', 'Psoríase',                    'Psoríase em placas',         250.00, FALSE),
(32, 4, '2025-03-04 07:00', 'REALIZADA', 'Pé chato',                    'Pé plano grau 2',            280.00, TRUE),
(33, 5, '2025-03-05 08:00', 'REALIZADA', 'Vacinação em atraso',         'Calendário atualizado',      200.00, TRUE),
(34, 6, '2025-03-10 09:00', 'REALIZADA', 'Pré-natal',                   '12 semanas, normal',         260.00, TRUE),
(35, 7, '2025-03-11 10:00', 'REALIZADA', 'Formigamento na mão',        'Síndrome do túnel do carpo',  320.00, TRUE),
(36,10, '2025-03-12 08:00', 'REALIZADA', 'Controle colesterol',        'LDL elevado',                  310.00, FALSE),
(37, 9, '2025-03-17 13:00', 'REALIZADA', 'Dor abdominal',              'Gastrite crônica',             160.00, TRUE),
(38, 8, '2025-03-18 08:00', 'REALIZADA', 'Catarata inicial',           'Aguardar evolução',            240.00, TRUE),
(39, 1, '2025-03-19 08:00', 'REALIZADA', 'Infecção urinária',          'ITU simples',                  150.00, FALSE),
(40, 2, '2025-03-20 09:00', 'CANCELADA', 'Dor no peito noturna',        NULL,                          300.00, TRUE),
(1,  3, '2025-03-24 13:00', 'REALIZADA', 'Alergia cutânea',            'Urticária aguda',              250.00, TRUE),
(2,  7, '2025-03-25 10:00', 'REALIZADA', 'Cefaleia recorrente',        'Enxaqueca sem aura',           320.00, TRUE),
(3,  9, '2025-03-26 13:00', 'REALIZADA', 'Check-up anual',             'Colesterol borderline',        160.00, TRUE),
(4,  8, '2025-03-31 08:00', 'AGENDADA',  'Dificuldade de visão noturna', NULL,                         240.00, FALSE),
(5,  6, '2025-04-01 09:00', 'REALIZADA', 'Consulta pediátrica',        'Peso e altura normais',        260.00, TRUE),
(6,  4, '2025-04-02 07:00', 'REALIZADA', 'Dor nas costas',             'Contratura muscular',          280.00, TRUE),
(7,  2, '2025-04-07 09:00', 'REALIZADA', 'Holter 24h resultado',       'Extrassístoles isoladas',      300.00, FALSE),
(8,  1, '2025-04-08 08:00', 'REALIZADA', 'Renovação receita',          'Manutenção',                   150.00, TRUE),
(9,  5, '2025-04-09 08:00', 'REALIZADA', 'Otite',                      'Otite média aguda',            200.00, TRUE),
(10, 3, '2025-04-10 13:00', 'AGENDADA',  'Consulta dermatológica',      NULL,                          250.00, TRUE),
(11, 1, '2025-04-14 08:00', 'REALIZADA', 'Dor de garganta',            'Amigdalite',                   150.00, FALSE),
(12, 7, '2025-04-15 10:00', 'REALIZADA', 'Dor de cabeça',              'Cefaleia por tensão',          320.00, TRUE),
(13, 6, '2025-04-16 09:00', 'CANCELADA', 'Menstruação irregular',       NULL,                          260.00, TRUE),
(14, 2, '2025-04-22 09:00', 'AGENDADA',  'Revisão cardiológica',        NULL,                          300.00, TRUE),
(15, 4, '2025-04-23 07:00', 'AGENDADA',  'Pós-operatório joelho',       NULL,                          280.00, FALSE),
(16, 9, '2025-04-28 13:00', 'AGENDADA',  'Check-up',                    NULL,                          160.00, TRUE),
(17, 8, '2025-04-29 08:00', 'AGENDADA',  'Revisão óculos',              NULL,                          240.00, FALSE),
(18,10, '2025-04-30 08:00', 'AGENDADA',  'Exame ecocardiograma',        NULL,                          310.00, TRUE),
(19, 3, '2025-05-05 13:00', 'AGENDADA',  'Mancha nova na pele',         NULL,                          250.00, FALSE),
(20, 5, '2025-05-06 08:00', 'AGENDADA',  'Vacinação infantil',          NULL,                          200.00, TRUE);