# O hospital: Diagrama Entidade Reelacionamento 

Este projeto é um sistema de gerenciamento de hospital implementado usando MySQL. Ele permite o gerenciamento eficiente de pacientes, médicos, enfermeiros, consultas, internações e muito mais.

    
## O Hospital Fundamental (Parte 1):

Comecei com um diagrama simples que inclui Médico, Especialidade, Telefone, Endereço, Convênio, Documento, Paciente, Consulta e Receita. Cada entidade foi modelada por mim para refletir os relacionamentos e atributos necessários para um sistema de gerenciamento de hospital eficiente.

![HospitalFuncionalidade drawio (4)](https://github.com/GretzelKattia/Hospital_BancoDeDados/assets/146984390/879d5427-8db3-4253-863a-f23cf56d6631)

>   📋 [FundamentosHospital.drawio](https://github.com/GretzelKattia/Hospital_BancoDeDados/blob/main/Diagramas%20MER/MER_HospitalFundamental.png)

### Tabelas que incluí

Neste diagrama MER, eu incluí as seguintes tabelas:

1. **Endereco**: Guarda informações de endereço, como CEP, número, rua, bairro e cidade.
2. **Documento**: Guarda informações de documentos, como CPF e RG.
3. **Medico**: Guarda informações do médico, como CRM, endereço, telefone, nome, data de nascimento e e-mail.
4. **Especialidade**: Guarda informações sobre as especialidades médicas.
5. **MedicoEspecialidade**: Associa médicos às suas especialidades.
6. **Convenio**: Guarda informações sobre os convênios de saúde.
7. **Paciente**: Guarda informações do paciente, como ID do paciente, ID do convênio, endereço, telefone e CPF.
8. **Consulta**: Guarda informações sobre as consultas, como ID da consulta, ID do paciente, CRM do médico, ID da especialidade, ID do convênio, data da consulta, número da carteirinha e valor.
9. **Receita**: Guarda informações sobre as receitas médicas, como ID da receita, ID da consulta, medicamento, quantidade e instruções de uso.


## Os Segredos do Hospital (Parte 2):

A segunda parte do diagrama é um pouco mais complexa e inclui entidades adicionais como Enfermeiros, Quartos e Internação. Isso me permite ter uma visão mais completa do ambiente do hospital, incluindo o pessoal de enfermagem e a gestão de quartos e internações.

![Os segredos HospitalFuncionalidade drawio](https://github.com/GretzelKattia/Hospital_BancoDeDados/assets/146984390/ce8a8613-3d7a-4ce5-a2de-2f6545993cdf)

>   📋 [SegredosHospital.drawio](https://github.com/GretzelKattia/Hospital_BancoDeDados/blob/main/Diagramas%20MER/MER_SegredosHospital.png)

Agora, neste diagrama, eu adicionei algumas tabelas novas:

10. **Tipo_Quarto**: Guarda informações sobre os tipos de quartos disponíveis.
11. **Quarto**: Guarda informações sobre os quartos do hospital.
12. **Enfermeiro**: Guarda informações do enfermeiro, como CRE, nome, CPF, telefone, e-mail e endereço.
13. **Internacao**: Guarda informações sobre as internações, como ID da internação, CRM do médico, CRE do enfermeiro, ID do paciente, ID do quarto, data de entrada, data prevista de alta, data efetiva de alta e procedimento.
14. **EnfermeiroInternacao**: Associa enfermeiros às internações.

Além disso, na segunda etapa deste projeto, eu arregacei as mangas e criei o script do banco de dados do hospital. Este script é a espinha dorsal do nosso sistema, estabelecendo todas as tabelas e relações que mantêm o hospital funcionando como um relógio. Com ele, temos o controle total, desde o gerenciamento de consultas e internações até a organização de médicos, enfermeiros e quartos. Estou empolgado para ver como este script vai transformar a maneira como o hospital opera! Como por exemplo a tabela Receita:

```sql
-- Script da tabela Receita
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
```


## O Prisioneiro dos Dados - Alimentando o banco de dados (Parte 3):


Com o banco de dados do sistema hospitalar totalmente montado, é hora de adicionar alguns dados. Esses dados nos ajudarão a realizar testes e verificar se o sistema está funcionando como deveria. Nesta etapa, também estou preparando alguns scripts iniciais para o banco, que serão usados para povoar o sistema com um conjunto inicial de dados. Vou mostrar agora os dados que implementei na tabela Receita (dito anteriormente):

```sql 
-- Dados inseridos na tabela Receita com pelo menos duas receitas por consulta
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
```

## A ordem de alterar - Alterando o banco de dados (Parte 4)

<div align="center">
  <pre><i>🚧 Espera um minutinho, essa parte ainda esta sendo feita🚧</i></pre>
</div>

## Contribuições

Se você quiser contribuir para este projeto, será muito bem-vindo! Se encontrar um bug ou quiser adicionar uma nova funcionalidade, pode criar um issue ou um pull request.

## Licença

Este projeto está licenciado sob a licença MIT.
