CREATE DATABASE IF NOT EXISTS Hospital; 

USE Hospital;

DROP TABLE IF EXISTS Medico;
CREATE TABLE Medico (
    CRM INT PRIMARY KEY,
    Nome VARCHAR(100),
    Tipo VARCHAR(50)
);

DROP TABLE IF EXISTS Especialidade;
CREATE TABLE Especialidade (
    ID_Especialidade INT PRIMARY KEY,
    Nome VARCHAR(50)
);

DROP TABLE IF EXISTS Medico_Especialidade;
CREATE TABLE Medico_Especialidade (
    CRM INT,
    ID_Especialidade INT,
    PRIMARY KEY (CRM, ID_Especialidade),
    FOREIGN KEY (CRM) REFERENCES Medico(CRM),
    FOREIGN KEY (ID_Especialidade) REFERENCES Especialidade(ID_Especialidade)
);

DROP TABLE IF EXISTS Paciente;
CREATE TABLE Paciente (
    ID_Paciente INT PRIMARY KEY,
    Nome VARCHAR(100),
    Data_Nascimento DATE,
    Endereco VARCHAR(200),
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    CPF VARCHAR(11),
    RG VARCHAR(9)
);

DROP TABLE IF EXISTS Convenio;
CREATE TABLE Convenio (
    ID_Convenio INT PRIMARY KEY,
    Nome VARCHAR(100),
    CNPJ VARCHAR(14),
    Tempo_Carencia INT
);

DROP TABLE IF EXISTS Consulta;
CREATE TABLE Consulta (
    ID_Consulta INT PRIMARY KEY,
    Data_Hora DATETIME,
    CRM INT,
    ID_Paciente INT,
    Valor DECIMAL(10,2),
    ID_Convenio INT,
    Numero_Carteira VARCHAR(20),
    ID_Especialidade INT,
    FOREIGN KEY (CRM) REFERENCES Medico(CRM),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente),
    FOREIGN KEY (ID_Convenio) REFERENCES Convenio(ID_Convenio),
    FOREIGN KEY (ID_Especialidade) REFERENCES Especialidade(ID_Especialidade)
);

DROP TABLE IF EXISTS Receita;
CREATE TABLE Receita (
    ID_Receita INT PRIMARY KEY,
    ID_Consulta INT,
    Medicamentos TEXT,
    Quantidade INT,
    Instrucoes TEXT,
    FOREIGN KEY (ID_Consulta) REFERENCES Consulta(ID_Consulta)
);

DROP TABLE IF EXISTS Tipo_Quarto;
CREATE TABLE Tipo_Quarto (
    ID_Tipo_Quarto VARCHAR(50) PRIMARY KEY,
    Descricao TEXT,
    Valor_Diario DECIMAL(10,2)
);

DROP TABLE IF EXISTS Quarto;
CREATE TABLE Quarto (
    ID_Quarto INT PRIMARY KEY,
    Numeracao INT,
    ID_Tipo_Quarto VARCHAR(50),
    FOREIGN KEY (ID_Tipo_Quarto) REFERENCES Tipo_Quarto(ID_Tipo_Quarto)
);

DROP TABLE IF EXISTS Enfermeiro;
CREATE TABLE Enfermeiro (
    ID_Enfermeiro INT PRIMARY KEY,
    Nome VARCHAR(100),
    CPF VARCHAR(11),
    CRE VARCHAR(20)
);

DROP TABLE IF EXISTS Internacao;
CREATE TABLE Internacao (
    ID_Internacao INT PRIMARY KEY,
    Data_Entrada DATE,
    Data_Prevista_Alta DATE,
    Data_Efetiva_Alta DATE,
    Procedimentos TEXT,
    ID_Quarto INT,
    ID_Paciente INT,
    CRM INT,
    ID_Enfermeiro INT,
    FOREIGN KEY (ID_Quarto) REFERENCES Quarto(ID_Quarto),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente),
    FOREIGN KEY (CRM) REFERENCES Medico(CRM),
    FOREIGN KEY (ID_Enfermeiro) REFERENCES Enfermeiro(ID_Enfermeiro)
);

DROP TABLE IF EXISTS Enfermeiro_Internacao;
CREATE TABLE Enfermeiro_Internacao (
    ID_Enfermeiro INT,
    ID_Internacao INT,
    PRIMARY KEY (ID_Enfermeiro, ID_Internacao),
    FOREIGN KEY (ID_Enfermeiro) REFERENCES Enfermeiro(ID_Enfermeiro),
    FOREIGN KEY (ID_Internacao) REFERENCES Internacao(ID_Internacao)
);



-- Inserindo valores na tabela Medico
INSERT INTO Medico (CRM, Nome, Tipo) VALUES (123456, 'Dr. João', 'Generalista');
INSERT INTO Medico (CRM, Nome, Tipo) VALUES (789012, 'Dr. Ana', 'Especialista');

-- Inserindo valores na tabela Especialidade
INSERT INTO Especialidade (ID_Especialidade, Nome) VALUES (1, 'Cardiologia');
INSERT INTO Especialidade (ID_Especialidade, Nome) VALUES (2, 'Neurologia');

-- Inserindo valores na tabela Medico_Especialidade
INSERT INTO Medico_Especialidade (CRM, ID_Especialidade) VALUES (789012, 1);
INSERT INTO Medico_Especialidade (CRM, ID_Especialidade) VALUES (789012, 2);

-- Inserindo valores na tabela Paciente
INSERT INTO Paciente (ID_Paciente, Nome, Data_Nascimento, Endereco, Telefone, Email, CPF, RG) VALUES (1, 'Maria', '1980-01-01', 'Rua das Flores, 123', '(11) 12345-6789', 'maria@email.com', '12345678901', '12345678');

-- Inserindo valores na tabela Convenio
INSERT INTO Convenio (ID_Convenio, Nome, CNPJ, Tempo_Carencia) VALUES (1, 'Convenio A', '12345678000123', 30);

-- Inserindo valores na tabela Consulta
INSERT INTO Consulta (ID_Consulta, Data_Hora, CRM, ID_Paciente, Valor, ID_Convenio, Numero_Carteira, ID_Especialidade) VALUES (1, '2024-05-31 10:00:00', 123456, 1, 200.00, 1, '1234567890', 1);

-- Inserindo valores na tabela Receita
INSERT INTO Receita (ID_Receita, ID_Consulta, Medicamentos, Quantidade, Instrucoes) VALUES (1, 1, 'Medicamento A', 30, 'Tomar 1 comprimido por dia após as refeições');

-- Inserindo valores na tabela Tipo_Quarto
INSERT INTO Tipo_Quarto (ID_Tipo_Quarto, Descricao, Valor_Diario) VALUES ('TipoA', 'Quarto individual com banheiro privativo', 150.00);

-- Inserindo valores na tabela Quarto
INSERT INTO Quarto (ID_Quarto, Numeracao, ID_Tipo_Quarto) VALUES (1, 101, 'TipoA');

-- Inserindo valores na tabela Enfermeiro
INSERT INTO Enfermeiro (ID_Enfermeiro, Nome, CPF, CRE) VALUES (1, 'Enfermeiro Carlos', '98765432101', '123456');

-- Inserindo valores na tabela Internacao
INSERT INTO Internacao (ID_Internacao, Data_Entrada, Data_Prevista_Alta, Data_Efetiva_Alta, Procedimentos, ID_Quarto, ID_Paciente, CRM, ID_Enfermeiro) VALUES (1, '2024-05-31', '2024-06-07', NULL, 'Procedimento A', 1, 1, 123456, 1);

-- Inserindo valores na tabela Enfermeiro_Internacao
INSERT INTO Enfermeiro_Internacao (ID_Enfermeiro, ID_Internacao) VALUES (1, 1);