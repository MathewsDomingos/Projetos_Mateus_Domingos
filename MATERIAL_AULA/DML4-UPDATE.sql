-- DML - DATA MANIPULATION LANGUAGE (LINGUAGEM DE MANIPULA��O DE DADOS)
-- 4 OPERA��ES B�SICAS: INCLUS�O, EXCLUS�O, ALTERA��O E CONSULTA
-- UPDATE - EXEMPLOS
USE CONSTRUTORA_V3;

UPDATE PROJETO SET VALOR=10000;

-- COM CLAUSULA WHERE 

-- ATUALIZA O VALOR DOS PROJETOS PARA R$50.000,00, SOMENTE OS PROJETOS INICIADOS 
-- A PARTIR DO DIA 01/02/2021
UPDATE PROJETO SET VALOR=50000 WHERE DATA_INICIO>='2021-02-01';


-- COM CLAUSULA WHERE
-- ATUALIZA O VALOR PARA R$25.000,00, O FUNCIONARIO GERENTE PARA 4, 
-- E A DATA DE TERMINO PARA O DIA DE HOJE, CONSIDERANDO
-- SOMENTE OS PROJETOS INICIADOS  A PARTIR DO DIA 01/03/2021
UPDATE PROJETO SET VALOR=25000, COD_FUNC_GER=4, DATA_TERMINO=GETDATE()
WHERE DATA_INICIO>='2021-03-01';

-- COM CLAUSULA WHERE
-- INCREMENTA O VALOR DOS PROJETOS EM 25%, ALTERA O FUNCIONARIO GERENTE PARA 14, 
-- E A DATA DE TERMINO PARA NULL, CONSIDERANDO
-- SOMENTE OS PROJETOS COM DATA DE T�RMINO N�O-NULA "E" C�DIGO DE GERENTE 9.
--UPDATE PROJETO SET VALOR=VALOR+(VALOR*25)/100
--UPDATE PROJETO SET VALOR=VALOR+(VALOR*0.25)

UPDATE PROJETO SET VALOR=VALOR*1.25, COD_FUNC_GER=14, DATA_TERMINO=NULL
WHERE DATA_TERMINO IS NOT NULL AND COD_FUNC_GER=9;

-- COM CLAUSULA WHERE
-- REDUZA O VALOR DOS PROJETOS EM 15%, O FUNCIONARIO GERENTE PARA 16, 
-- A DATA DE T�RMINO ASSINATURA PARA 18 MESES AP�S A DATA DE INICIO, CONSIDERANDO
-- SOMENTE OS PROJETOS COM DATA DE T�RMINO NULA E DATA DE IN�CIO NO ANO DE 2017
--UPDATE PROJETO SET VALOR=VALOR-(VALOR*15)/100
--UPDATE PROJETO SET VALOR=VALOR-(VALOR*0.15)
UPDATE PROJETO SET VALOR=VALOR*0.85, COD_FUNC_GER=16, DATA_TERMINO=DATEADD(MONTH,18,DATA_INICIO)
--WHERE DATA_TERMINO IS NULL AND DATA_INICIO>='2019-01-01' AND DATA_INICIO<='2019-12-31'
--WHERE DATA_TERMINO IS NULL AND DATA_INICIO BETWEEN '2019-01-01' AND '2019-12-31'
WHERE DATA_TERMINO IS NULL AND YEAR(DATA_INICIO)=2017

-- 20123,00

SELECT * FROM FUNCIONARIO
SELECT * FROM PROJETO WHERE DATA_INICIO>='2021-03-01';
SELECT * FROM PROJETO WHERE DATA_TERMINO IS NULL
SELECT * FROM PROJETO WHERE DATA_TERMINO IS NOT NULL AND COD_FUNC_GER=9
SELECT * FROM PROJETO WHERE CODIGO IN(18,23,35,40)
SELECT * FROM PROJETO WHERE DATA_TERMINO IS NULL AND YEAR(DATA_INICIO)=2017
SELECT * FROM PROJETO WHERE COD_FUNC_GER=16

-- 20123,00
-- 18, 23, 35, 40