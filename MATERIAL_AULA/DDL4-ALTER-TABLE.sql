-- DDL - ALTERA��O DE ESTRUTURA (ALTER TABLE)
USE CONSTRUTORA;

-- INSERINDO NOVO ATRIBUTO EM TABELA J� EXISTENTE
-- ATRIBUTO RG CHAR(9) OPCIONAL NA TABELA FUNCIONARIO
ALTER TABLE FUNCIONARIO ADD RG CHAR(9) NULL;

-- ALTERA A NULABILIDADE E/OU DOM�NIO DE UM ATRIBUTO
-- ATRIBUTO RG CHAR(9) OBRIGAT�RIO
ALTER TABLE FUNCIONARIO ALTER COLUMN RG CHAR(9) NOT NULL;

-- REMOVE UM ATRIBUTO - ATRIBUTO RG DA TABELA FUNCION�RIO
ALTER TABLE FUNCIONARIO DROP COLUMN RG;

-- ALTERA O TIPO DE DADO DE UM ATRIBUTO - NOME DE FUNCIONARIO PARA VARCHAR(100)
ALTER TABLE FUNCIONARIO ALTER COLUMN NOME VARCHAR(100) NOT NULL;

-- EXCLUI UMA CONSTRAINT - FK_DEPENDENTE_FUNCIONARIO
ALTER TABLE DEPENDENTE DROP CONSTRAINT FK_DEPENDENTE_FUNCIONARIO;

-- APAGA TABELA DEPENDENTE
DROP TABLE DEPENDENTE;
-- N�O IRA FUNCIONAR POIS EXISTEM FKs EM OUTRAS TABELAS REFERENCIANDO FUNC
DROP TABLE FUNCIONARIO;

-- CRIA UMA CONSTRAINT EM TABELA J� EXISTENTE - CK_FUNCIONARIO_SALARIO. 
-- SALARIO DO FUNCIONARIO DEVE SER MAIOR OU IGUAL A R$ 1500,00
ALTER TABLE FUNCIONARIO ADD CONSTRAINT CK_FUNCIONARIO_SALARIO 
   CHECK(SALARIO>=1500);

-- DESATIVA UMA CONSTRAINT - FK_PROJETO_FUNCIONARIO
ALTER TABLE PROJETO NOCHECK CONSTRAINT FK_PROJETO_FUNCIONARIO;

-- REATIVA CONSTRAINT - FK_PROJETO_FUNCIONARIO
ALTER TABLE PROJETO CHECK CONSTRAINT FK_PROJETO_FUNCIONARIO;

-- APAGA BANCO DE DADOS - APAGA DATABASE CONSTRUTORA
DROP DATABASE CONSTRUTORA;



