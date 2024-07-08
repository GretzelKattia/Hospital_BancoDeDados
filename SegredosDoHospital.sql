-- MySQL Script gerado por Gretzel Kattia
-- Data: 2024-07-08

CREATE DATABASE IF NOT EXISTS SegredosDoHospital; 

USE SegredosDoHospital;

-- Cria a tabela Endereco
DROP TABLE IF EXISTS Endereco;
CREATE TABLE Endereco (
    CEP INT(8) ZEROFILL NOT NULL,
    Numero INT(5) NOT NULL,
    Rua VARCHAR(255) NOT NULL,
    Bairro VARCHAR(255) NOT NULL,
    Cidade VARCHAR(255) NOT NULL,
    PRIMARY KEY (CEP, Numero)
);

-- Cria a tabela Telefone
DROP TABLE IF EXISTS Telefone;
CREATE TABLE Telefone (
    DDD INT(3) ZEROFILL NOT NULL,
    Numero VARCHAR(11) NOT NULL,
    PRIMARY KEY (DDD, Numero)
);

-- Cria a tabela Documento
DROP TABLE IF EXISTS Documento;
CREATE TABLE Documento (
    CPF VARCHAR(13) NOT NULL,
    RG VARCHAR(15) NOT NULL,
    PRIMARY KEY (CPF)
);

-- Cria a tabela Medico
DROP TABLE IF EXISTS Medico;
CREATE TABLE Medico (
    CRM VARCHAR(100) NOT NULL,
    Endereco_CEP INT(8) ZEROFILL NULL,
    Endereco_Numero INT(5) NULL,
    Telefone_DDD INT(2) ZEROFILL NOT NULL,
    Telefone_Numero VARCHAR(9) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Email VARCHAR(105) NULL,
    PRIMARY KEY (CRM),
    CONSTRAINT FK_Medico_Endereco1
        FOREIGN KEY (Endereco_CEP , Endereco_Numero)
        REFERENCES Endereco (CEP , Numero),
    CONSTRAINT FK_Medico_Telefone1
        FOREIGN KEY (Telefone_DDD , Telefone_Numero)
        REFERENCES Telefone (DDD , Numero)
);

-- Cria a tabela Especialidade
DROP TABLE IF EXISTS Especialidade;
CREATE TABLE Especialidade (
    ID_Especialidade INT NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_Especialidade)
);

-- Cria a tabela MedicoEspecialidade
DROP TABLE IF EXISTS MedicoEspecialidade;
CREATE TABLE MedicoEspecialidade (
    CRM VARCHAR(100) NOT NULL,
    ID_Especialidade INT NOT NULL,
    PRIMARY KEY (CRM, ID_Especialidade),
    CONSTRAINT FK_MedicoEspecialidade_Medico
        FOREIGN KEY (CRM)
        REFERENCES Medico (CRM),
    CONSTRAINT FK_MedicoEspecialidade_Especialidade
        FOREIGN KEY (ID_Especialidade)
        REFERENCES Especialidade (ID_Especialidade)
);

-- Cria a tabela Convenio
DROP TABLE IF EXISTS Convenio;
CREATE TABLE Convenio (
    ID_Convenio INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(20) NOT NULL,
    Tempo_Carencia VARCHAR(10) NOT NULL,
    PRIMARY KEY (ID_Convenio)
);

-- Cria a tabela Paciente
DROP TABLE IF EXISTS Paciente;
CREATE TABLE Paciente (
    ID_Paciente VARCHAR(45) NOT NULL,
    Convenio_ID_Convenio INT NOT NULL,
    Endereco_Numero INT(5) NOT NULL,
    Endereco_CEP INT(8) ZEROFILL NOT NULL,
    Telefone_DDD INT(2) ZEROFILL NOT NULL,
    Telefone_Numero VARCHAR(12) NOT NULL,
    Documento_CPF VARCHAR(15) NOT NULL,
    PRIMARY KEY (ID_Paciente),
    CONSTRAINT FK_Paciente_Convenio1
        FOREIGN KEY (Convenio_ID_Convenio)
        REFERENCES Convenio (ID_Convenio),
    CONSTRAINT FK_Paciente_Documento1
        FOREIGN KEY (Documento_CPF)
        REFERENCES Documento (CPF),
    CONSTRAINT FK_Paciente_Telefone1
        FOREIGN KEY (Telefone_DDD , Telefone_Numero)
        REFERENCES Telefone (DDD , Numero),
    CONSTRAINT FK_Paciente_Endereco1
        FOREIGN KEY (Endereco_CEP , Endereco_Numero)
        REFERENCES Endereco (CEP , Numero)
);

-- Cria a tabela Tipo_Quarto
DROP TABLE IF EXISTS Tipo_Quarto;
CREATE TABLE Tipo_Quarto (
    Tipo_Quarto VARCHAR(255) NOT NULL,
    Descricao VARCHAR(255) NULL,
    Valor_Diario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Tipo_Quarto)
);

-- Cria a tabela Quarto
DROP TABLE IF EXISTS Quarto;
CREATE TABLE Quarto (
    ID_Quarto INT NOT NULL AUTO_INCREMENT,
    Tipo_Quarto VARCHAR(255) NOT NULL,
    Numeracao INT NOT NULL,
    PRIMARY KEY (ID_Quarto),
    INDEX FK_Quarto_Tipo_Quarto1_idx (Tipo_Quarto ASC),
    CONSTRAINT FK_Quarto_Tipo_Quarto1
        FOREIGN KEY (Tipo_Quarto)
        REFERENCES Tipo_Quarto (Tipo_Quarto)
);

-- Cria a tabela Enfermeiro
DROP TABLE IF EXISTS Enfermeiro;
CREATE TABLE Enfermeiro (
    CRE VARCHAR(100) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    Telefone_DDD INT(2) ZEROFILL NOT NULL,
    Telefone_Numero VARCHAR(9) NOT NULL,
    Email VARCHAR(105) NULL,
    Endereco_CEP INT(8) ZEROFILL NULL,
    Endereco_Numero INT(5) NULL,
    PRIMARY KEY (CRE),
    CONSTRAINT FK_Enfermeiro_Endereco
        FOREIGN KEY (Endereco_CEP , Endereco_Numero)
        REFERENCES Endereco (CEP , Numero)
);

-- Cria a tabela Internacao
DROP TABLE IF EXISTS Internacao;
CREATE TABLE Internacao (
    ID_Internacao INT NOT NULL AUTO_INCREMENT,
    CRM VARCHAR(100) NOT NULL,
    CRE VARCHAR(100) NULL,
    ID_Paciente VARCHAR(45) NOT NULL,
    ID_Quarto INT NOT NULL,
    Data_Entrada DATE NOT NULL,
    Data_Previsao_Alta DATE NOT NULL,
    Data_Efetiva_Alta DATE NULL,
    Procedimento VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_Internacao),
    CONSTRAINT FK_Internacao_Medico
        FOREIGN KEY (CRM)
        REFERENCES Medico (CRM),
    CONSTRAINT FK_Internacao_Enfermeiro
        FOREIGN KEY (CRE)
        REFERENCES Enfermeiro (CRE),
    CONSTRAINT FK_Internacao_Paciente
        FOREIGN KEY (ID_Paciente)
        REFERENCES Paciente (ID_Paciente),
    CONSTRAINT FK_Internacao_Quarto
        FOREIGN KEY (ID_Quarto)
        REFERENCES Quarto (ID_Quarto)
);

-- Cria a tabela EnfermeiroInternacao
DROP TABLE IF EXISTS EnfermeiroInternacao;
CREATE TABLE EnfermeiroInternacao (
    CRE VARCHAR(100) NOT NULL,
    ID_Internacao INT NOT NULL,
    PRIMARY KEY (CRE, ID_Internacao),
    CONSTRAINT FK_EnfermeiroInternacao_Enfermeiro
        FOREIGN KEY (CRE)
        REFERENCES Enfermeiro (CRE),
    CONSTRAINT FK_EnfermeiroInternacao_Internacao
        FOREIGN KEY (ID_Internacao)
        REFERENCES Internacao (ID_Internacao)
);

-- Cria a tabela Consulta
DROP TABLE IF EXISTS Consulta;
CREATE TABLE Consulta (
    ID_Consulta INT NOT NULL AUTO_INCREMENT,
    ID_Paciente VARCHAR(45) NOT NULL,
    CRM VARCHAR(100) NOT NULL,
    ID_Especialidade INT NOT NULL,
    ID_Convenio INT NULL,
    Data_Consulta DATE NOT NULL,
    Numero_Carteirinha VARCHAR(45) NULL,
    Valor DECIMAL(10,2) NULL,
    PRIMARY KEY (ID_Consulta),
    CONSTRAINT FK_Consulta_Paciente1
        FOREIGN KEY (ID_Paciente)
        REFERENCES Paciente (ID_Paciente),
    CONSTRAINT FK_Consulta_Medico1
        FOREIGN KEY (CRM)
        REFERENCES Medico (CRM),
    CONSTRAINT FK_Consulta_Especialidade
        FOREIGN KEY (ID_Especialidade)
        REFERENCES Especialidade (ID_Especialidade),
    CONSTRAINT FK_Consulta_Convenio
        FOREIGN KEY (ID_Convenio)
        REFERENCES Convenio (ID_Convenio)
);

-- Cria a tabela Receita
DROP TABLE IF EXISTS Receita;
CREATE TABLE Receita (
    ID_Receita INT NOT NULL AUTO_INCREMENT,
    ID_Consulta INT NOT NULL,
    Medicamento VARCHAR(255) NOT NULL,
    Quantidade INT NOT NULL,
    Instrucoes_Uso VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_Receita),
    CONSTRAINT FK_Receita_Consulta1
        FOREIGN KEY (ID_Consulta)
        REFERENCES Consulta (ID_Consulta)
);


-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- INSERIR DADOS TESTES - PARTE 3
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

-- Inserir dados na tabela Endereco
INSERT INTO Endereco (CEP, Numero, Rua, Bairro, Cidade) VALUES
    ('12345678', 100, 'Rua das Flores', 'Jardim das Rosas', 'São Paulo'),
    ('87654321', 200, 'Avenida Paulista', 'Bela Vista', 'São Paulo'),
    ('45678901', 300, 'Rua Oscar Freire', 'Jardins', 'São Paulo'),
    ('12345678', 104, 'Rua das Flores', 'Jardim das Rosas', 'São Paulo'); 

-- Inserir dados na tabela Documento
INSERT INTO Documento (CPF, RG) VALUES
    ('12345678901', '12.345.678-9'),
    ('98765432109', '23.456.789-0'),
    ('45678901234', '34.567.890-1'),
    ('11122233344', '45.678.901-2'),
    ('55566677788', '56.789.012-3'),
    ('99988877755', '67.890.123-4'),
    ('33344455566', '78.901.234-5'),
    ('77788899900', '89.012.345-6'),
    ('22233344455', '90.123.456-7'),
    ('66677788899', '01.234.567-8'),
    ('88899900011', '12.345.678-9'),
    ('12345678903', '23.456.789-0'), 
    ('11122233345', '34.567.890-1'),
    ('55566677789', '45.678.901-2'),
    ('99988877766', '56.789.012-3'); 

-- Inserir dados na tabela Medico com endereços existentes na tabela Endereco
INSERT INTO Medico (CRM, Endereco_CEP, Endereco_Numero, Telefone_DDD, Telefone_Numero, Nome, Data_Nascimento, Email) VALUES
    ('CRM123', '12345678', 100, '11', '999998888', 'Dr. João', '1980-05-15', 'joao@example.com'),
    ('CRM456', '87654321', 200, '21', '987654321', 'Dra. Maria', '1985-10-20', 'maria@example.com'),
    ('CRM789', '45678901', 300, '31', '123456789', 'Dr. José', '1990-03-25', 'jose@example.com'),
    ('CRM987', '87654321', 200, '21', '987654322', 'Dr. Carlos', '1982-08-10', 'carlos@example.com'),
    ('CRM654', '45678901', 300, '31', '123456780', 'Dra. Ana', '1988-04-30', 'ana@example.com'),
    ('CRM321', '12345678', 104, '11', '999998889', 'Dr. Paula', '1983-12-05', 'paula@example.com'), 
    ('CRM555', '87654321', 200, '21', '987654323', 'Dr. Sofia', '1975-07-20', 'sofia@example.com'),
    ('CRM888', '45678901', 300, '31', '123456781', 'Dra. Julia', '1970-09-15', 'julia@example.com'),
    ('CRM222', '12345678', 104, '11', '999998890', 'Dr. Lucas', '1987-02-25', 'lucas@example.com'), 
    ('CRM999', '87654321', 200, '21', '987654324', 'Dr. Mateus', '1979-11-12', 'mateus@example.com');

-- Inserir dados na tabela Especialidade
INSERT INTO Especialidade (ID_Especialidade, Nome) VALUES
    (1, 'Pediatria'),
    (2, 'Clínica Geral'),
    (3, 'Gastrenterologia'),
    (4, 'Dermatologia'),
    (5, 'Cardiologia'),
    (6, 'Ortopedia'),
    (7, 'Oncologia');

-- Associar médicos às especialidades
INSERT INTO MedicoEspecialidade (CRM, ID_Especialidade) VALUES
    ('CRM123', 1),  -- Dr. João - Pediatria
    ('CRM456', 2),  -- Dra. Maria - Clínica Geral
    ('CRM789', 3),  -- Dr. José - Gastrenterologia
    ('CRM987', 4),  -- Dr. Carlos - Dermatologia
    ('CRM654', 5),  -- Dra. Ana - Cardiologia
    ('CRM321', 6),  -- Dr. Paula - Ortopedia
    ('CRM555', 7),  -- Dr. Sofia - Oncologia
    ('CRM888', 1),  -- Dra. Julia - Pediatria
    ('CRM222', 2),  -- Dr. Lucas - Clínica Geral
    ('CRM999', 3);  -- Dr. Mateus - Gastrenterologia

-- Inserir dados na tabela Convenio
INSERT INTO Convenio (Nome, CNPJ, Tempo_Carencia) VALUES
    ('Unimed', '12.345.678/0001-95', '30 dias'),
    ('SulAmérica', '98.765.432/0001-10', '60 dias'),
    ('Bradesco', '11.111.222/0001-33', '90 dias'),
    ('Amil', '44.555.666/0001-77', '120 dias');

-- Inserir dados na tabela Paciente
INSERT INTO Paciente (ID_Paciente, Convenio_ID_Convenio, Endereco_Numero, Endereco_CEP, Telefone_DDD, Telefone_Numero, Documento_CPF) VALUES
    ('PAC001', 1, 100, '12345678', '11', '999998888', '12345678901'),
    ('PAC002', 2, 200, '87654321', '21', '987654321', '98765432109'),
    ('PAC003', 3, 300, '45678901', '31', '123456789', '45678901234'),
    ('PAC004', 1, 100, '12345678', '11', '999998889', '11122233344'), 
    ('PAC005', 2, 200, '87654321', '21', '987654322', '55566677788'),
    ('PAC006', 3, 300, '45678901', '31', '123456780', '99988877766'),
    ('PAC007', 1, 100, '12345678', '11', '999998890', '33344455566'), 
    ('PAC008', 2, 200, '87654321', '21', '987654323', '77788899900'),
    ('PAC009', 3, 300, '45678901', '31', '123456781', '22233344455'),
    ('PAC010', 1, 100, '12345678', '11', '999998891', '66677788899'), 
    ('PAC011', 2, 200, '87654321', '21', '987654324', '88899900011'),
    ('PAC012', 3, 300, '45678901', '31', '123456782', '33344455566'),
    ('PAC013', 1, 100, '12345678', '11', '999998892', '11122233345'), 
    ('PAC014', 2, 200, '87654321', '21', '987654325', '55566677789'),
    ('PAC015', 3, 300, '45678901', '31', '123456783', '99988877766'); 

-- Inserir dados na tabela Tipo_Quarto
INSERT INTO Tipo_Quarto (Tipo_Quarto, Descricao, Valor_Diario) VALUES
    ('Apartamento', 'Quarto individual com banheiro privativo', 300.00),
    ('Quarto Duplo', 'Quarto para dois pacientes', 200.00),
    ('Enfermaria', 'Quarto compartilhado por vários pacientes', 150.00);

-- Inserir dados na tabela Quarto
INSERT INTO Quarto (Tipo_Quarto, Numeracao) VALUES
    ('Apartamento', 101),
    ('Apartamento', 102),
    ('Quarto Duplo', 201),
    ('Quarto Duplo', 202),
    ('Enfermaria', 301),
    ('Enfermaria', 302);
    
-- Inserir dados na tabela Enfermeiro
INSERT INTO Enfermeiro (CRE, Nome, CPF, Telefone_DDD, Telefone_Numero, Email, Endereco_CEP, Endereco_Numero) VALUES
    ('CRE123', 'Enf. Ana', '111.111.111-11', '11', '111111111', 'ana_enf@example.com', '12345678', 100),
    ('CRE456', 'Enf. Carlos', '222.222.222-22', '21', '222222222', 'carlos_enf@example.com', '87654321', 200),
    ('CRE789', 'Enf. Maria', '333.333.333-33', '31', '333333333', 'maria_enf@example.com', '45678901', 300),
    ('CRE987', 'Enf. João', '444.444.444-44', '41', '444444444', 'joao_enf@example.com', '12345678', 100),
    ('CRE654', 'Enf. Laura', '555.555.555-55', '51', '555555555', 'laura_enf@example.com', '87654321', 200),
    ('CRE321', 'Enf. Pedro', '666.666.666-66', '61', '666666666', 'pedro_enf@example.com', '45678901', 300),
    ('CRE555', 'Enf. Sofia', '777.777.777-77', '71', '777777777', 'sofia_enf@example.com', '12345678', 100),
    ('CRE888', 'Enf. Lucas', '888.888.888-88', '81', '888888888', 'lucas_enf@example.com', '87654321', 200),
    ('CRE222', 'Enf. Paula', '999.999.999-99', '91', '999999999', 'paula_enf@example.com', '45678901', 300),
    ('CRE999', 'Enf. Mateus', '000.000.000-00', '12', '101010101', 'mateus_enf@example.com', '12345678', 100);

-- Inserir dados na tabela Internacao
INSERT INTO Internacao (CRM, CRE, ID_Paciente, ID_Quarto, Data_Entrada, Data_Previsao_Alta, Procedimento) VALUES
    ('CRM123', 'CRE123', 'PAC001', 101, '2020-03-01', '2020-03-10', 'Procedimento 1'),  
    ('CRM456', 'CRE456', 'PAC002', 102, '2020-05-15', '2020-06-05', 'Procedimento 2'), 
    ('CRM789', 'CRE789', 'PAC003', 201, '2021-02-20', '2021-02-28', 'Procedimento 3'), 
    ('CRM987', 'CRE987', 'PAC004', 202, '2019-08-10', '2019-08-15', 'Procedimento 4'), 
    ('CRM654', 'CRE654', 'PAC005', 301, '2020-10-01', '2020-10-10', 'Procedimento 5'), 
    ('CRM321', 'CRE321', 'PAC006', 302, '2018-12-05', '2018-12-20', 'Procedimento 6'), 
    ('CRM555', 'CRE555', 'PAC007', 101, '2017-05-10', '2017-06-01', 'Procedimento 7'), 
    ('CRM123', 'CRE123', 'PAC001', 101, '2021-03-01', '2021-03-10', 'Procedimento 8'),  
    ('CRM456', 'CRE456', 'PAC002', 102, '2021-05-15', '2021-06-05', 'Procedimento 9'), 
    ('CRM789', 'CRE789', 'PAC008', 201, '2021-02-20', '2021-02-28', 'Procedimento 10'),  
    ('CRM987', 'CRE987', 'PAC009', 202, '2021-08-10', '2021-08-15', 'Procedimento 11'), 
    ('CRM654', 'CRE654', 'PAC010', 301, '2021-10-01', '2021-10-10', 'Procedimento 12');  

-- Inserir dados na tabela EnfermeiroInternacao
INSERT INTO EnfermeiroInternacao (CRE, ID_Internacao) VALUES
    ('CRE123', 1),
    ('CRE456', 1), 
    ('CRE789', 2),
    ('CRE987', 2), 
    ('CRE654', 3),
    ('CRE321', 3), 
    ('CRE555', 4),
    ('CRE888', 4), 
    ('CRE222', 5),
    ('CRE999', 5), 
    ('CRE123', 6),
    ('CRE456', 6), 
    ('CRE789', 7),
    ('CRE987', 7), 
    ('CRE888', 8),
    ('CRE222', 8), 
    ('CRE999', 9),
    ('CRE123', 9), 
    ('CRE456', 10),
    ('CRE789', 10), 
    ('CRE987', 11),
    ('CRE654', 11), 
    ('CRE321', 12),
    ('CRE555', 12); 

-- Inserir dados na tabela Consulta
INSERT INTO Consulta (ID_Paciente, CRM, ID_Especialidade, ID_Convenio, Data_Consulta, Numero_Carteirinha, Valor) VALUES
    ('PAC001', 'CRM123', 1, 1, '2021-05-15', 'CAR001', 200.00),
    ('PAC002', 'CRM456', 2, 2, '2020-08-20', 'CAR002', 150.00),
    ('PAC003', 'CRM789', 3, 3, '2019-10-25', 'CAR003', 180.00),
    ('PAC004', 'CRM987', 4, 4, '2021-01-10', 'CAR004', 220.00),
    ('PAC005', 'CRM654', 5, 5, '2020-03-12', 'CAR005', 250.00),
    ('PAC006', 'CRM321', 6, 6, '2018-07-05', 'CAR006', 300.00),
    ('PAC007', 'CRM555', 7, 7, '2017-12-30', 'CAR007', 350.00),
    ('PAC008', 'CRM888', 1, 1, '2021-06-18', 'CAR008', 400.00),
    ('PAC009', 'CRM222', 2, 2, '2020-09-22', 'CAR009', 450.00),
    ('PAC010', 'CRM999', 3, 3, '2019-11-11', 'CAR010', 500.00),
    ('PAC011', 'CRM123', 1, 1, '2021-02-28', 'CAR011', 550.00),
    ('PAC012', 'CRM456', 2, 2, '2020-04-16', 'CAR012', 600.00),
    ('PAC013', 'CRM789', 3, 3, '2018-08-10', 'CAR013', 650.00),
    ('PAC014', 'CRM987', 4, 4, '2017-10-02', 'CAR014', 700.00),
    ('PAC015', 'CRM654', 5, 5, '2019-03-25', 'CAR015', 750.00),
    ('PAC001', 'CRM321', 6, 6, '2021-07-14', 'CAR016', 800.00),
    ('PAC002', 'CRM555', 7, 7, '2020-10-08', 'CAR017', 850.00),
    ('PAC003', 'CRM888', 1, 1, '2019-12-01', 'CAR018', 900.00),
    ('PAC004', 'CRM222', 2, 2, '2018-05-19', 'CAR019', 950.00),
    ('PAC005', 'CRM999', 3, 3, '2017-09-03', 'CAR020', 1000.00);

-- Inserir dados na tabela Receita com pelo menos duas receitas por consulta
INSERT INTO Receita (ID_Consulta, Medicamento, Quantidade, Instrucoes_Uso) VALUES
    (1, 'Paracetamol', 20, 'Tomar 1 comprimido a cada 6 horas'),
    (1, 'Omeprazol', 30, 'Tomar 1 comprimido em jejum'), 
    (2, 'Omeprazol', 30, 'Tomar 1 comprimido em jejum'),
    (2, 'Azitromicina', 5, 'Tomar 1 comprimido por dia'), 
    (3, 'Azitromicina', 5, 'Tomar 1 comprimido por dia'),
    (3, 'Betametasona', 15, 'Aplicar no local afetado 2 vezes ao dia'), 
    (4, 'Betametasona', 15, 'Aplicar no local afetado 2 vezes ao dia'),
    (4, 'Atenolol', 30, 'Tomar 1 comprimido pela manhã'), 
    (5, 'Atenolol', 30, 'Tomar 1 comprimido pela manhã'),
    (5, 'Dipirona', 10, 'Tomar 1 comprimido a cada 6 horas em caso de dor'), 
    (6, 'Dipirona', 10, 'Tomar 1 comprimido a cada 6 horas em caso de dor'),
    (6, 'Ciclosporina', 60, 'Tomar 1 comprimido 2 vezes ao dia'), 
    (7, 'Ciclosporina', 60, 'Tomar 1 comprimido 2 vezes ao dia'),
    (7, 'Dexametasona', 30, 'Tomar 1 comprimido por dia'), 
    (8, 'Dexametasona', 30, 'Tomar 1 comprimido por dia'),
    (8, 'Ibuprofeno', 20, 'Tomar 1 comprimido a cada 8 horas em caso de dor'), 
    (9, 'Ibuprofeno', 20, 'Tomar 1 comprimido a cada 8 horas em caso de dor'),
    (9, 'Loratadina', 30, 'Tomar 1 comprimido por dia'), 
    (10, 'Loratadina', 30, 'Tomar 1 comprimido por dia');
