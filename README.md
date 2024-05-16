## O Hospital Fundamental:
Este repositório é voltado para armazenar os exercícios realizados por mim sobre banco de dados



![HospitalFuncionalidade drawio-_5_](https://github.com/GretzelKattia/Hospital_BancoDeDados/assets/146984390/1bdf78e1-afa4-4379-bd02-25e5b9b22f5e)



MUDAR
-- 1- Quantas vezes Natalie Portman foi indicada ao Oscar? 3
-- SELECT count(*)
-- from indicados_ao_oscar
-- WHERE nome_do_indicado = 'Natalie Portman';

-- 2- Quantos Oscars Natalie Portman ganhou? 1
-- SELECT count(*)
-- from indicados_ao_oscar
-- WHERE nome_do_indicado = 'Natalie Portman' and vencedor = '1';

-- 3- Amy Adams já ganhou algum Oscar? 0
-- select count(*)
-- from indicados_ao_oscar
-- where nome_do_indicado = 'Amy Adams' and vencedor = 'sim';

-- 4- A série de filmes Toy Story ganhou um Oscar em quais anos? 2011 e 2020
-- select nome_do_filme, ano_cerimonia, vencedor
-- from indicados_ao_oscar
-- where nome_do_filme like '%Toy Story%' and vencedor = '1';

-- 5- A partir de que ano que a categoria "Actress" deixa de existir? 
select 


