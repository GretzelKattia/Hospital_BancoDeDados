-- Adicionar a coluna 'em_atividade'na tabela Medico
ALTER TABLE Medico
ADD COLUMN em_atividade
VARCHAR(7) default 'Ativo';

-- Atualiza o status de atividade de dois médicos para inativo
UPDATE Medico
SET em_atividade = 'Inativo'
WHERE CRM IN ('CRM123', 'CRM456');

-- Define o status de atividades dos demais médicos para ativo
UPDATE Medico
SET em_atividade = 'Ativo'
WHERE em_atividade IS NULL;


-- Seleciona a tabela Medico para observa-la
SELECT * FROM Medico;
