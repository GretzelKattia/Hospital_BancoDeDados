# O hospital: Diagrama Entidade Reelacionamento 

Este projeto é um sistema de gerenciamento de hospital implementado usando MySQL. Ele permite o gerenciamento eficiente de pacientes, médicos, enfermeiros, consultas, internações e muito mais.

## O Hospital Fundamental:

![HospitalFuncionalidade drawio (4)](https://github.com/GretzelKattia/Hospital_BancoDeDados/assets/146984390/879d5427-8db3-4253-863a-f23cf56d6631)

## Os Segredos do Hospital (Parte 2)
![Os segredos HospitalFuncionalidade drawio](https://github.com/GretzelKattia/Hospital_BancoDeDados/assets/146984390/ce8a8613-3d7a-4ce5-a2de-2f6545993cdf)



## Tabelas

O banco de dados consiste nas seguintes tabelas:

1. **Endereco**: Armazena informações de endereço, incluindo CEP, número, rua, bairro e cidade.
2. **Documento**: Armazena informações de documentos, incluindo CPF e RG.
3. **Medico**: Armazena informações do médico, incluindo CRM, endereço, telefone, nome, data de nascimento e e-mail.
4. **Especialidade**: Armazena informações sobre as especialidades médicas.
5. **MedicoEspecialidade**: Associa médicos às suas especialidades.
6. **Convenio**: Armazena informações sobre os convênios de saúde.
7. **Paciente**: Armazena informações do paciente, incluindo ID do paciente, ID do convênio, endereço, telefone e CPF.
8. **Tipo_Quarto**: Armazena informações sobre os tipos de quartos disponíveis.
9. **Quarto**: Armazena informações sobre os quartos do hospital.
10. **Enfermeiro**: Armazena informações do enfermeiro, incluindo CRE, nome, CPF, telefone, e-mail e endereço.
11. **Internacao**: Armazena informações sobre as internações, incluindo ID da internação, CRM do médico, CRE do enfermeiro, ID do paciente, ID do quarto, data de entrada, data prevista de alta, data efetiva de alta e procedimento.
12. **EnfermeiroInternacao**: Associa enfermeiros às internações.
13. **Consulta**: Armazena informações sobre as consultas, incluindo ID da consulta, ID do paciente, CRM do médico, ID da especialidade, ID do convênio, data da consulta, número da carteirinha e valor.
14. **Receita**: Armazena informações sobre as receitas médicas, incluindo ID da receita, ID da consulta, medicamento, quantidade e instruções de uso.


## Contribuições

Contribuições para este projeto são bem-vindas. Se você encontrar um bug ou gostaria de adicionar uma nova funcionalidade, sinta-se à vontade para criar um issue ou um pull request.

## Licença

Este projeto está licenciado sob a licença MIT.
