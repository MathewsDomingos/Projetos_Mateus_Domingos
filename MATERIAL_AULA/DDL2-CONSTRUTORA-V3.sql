CREATE DATABASE CONSTRUTORA_V3;
GO
USE CONSTRUTORA_V3;
GO


CREATE FUNCTION FN_VALIDACPF(@CPF VARCHAR(11))
RETURNS BIT
AS
BEGIN
  DECLARE @INDICE INT,
          @SOMA INT,
          @DIG1 INT,
          @DIG2 INT,
          @CPF_TEMP VARCHAR(11),
          @DIGITOS_IGUAIS CHAR(1),
          @RESULTADO BIT
          
  SET @RESULTADO = 0

  /*
      Verificando se os digitos s�o iguais
      A Principio CPF com todos o n�meros iguais s�o Inv�lidos
      apesar de validar o Calculo do digito verificado
      EX: O CPF 00000000000 � inv�lido, mas pelo calculo
      Validaria
  */

  SET @CPF_TEMP = SUBSTRING(@CPF,1,1)

  SET @INDICE = 1
  SET @DIGITOS_IGUAIS = 'S'

  WHILE (@INDICE <= 11)
  BEGIN
    IF SUBSTRING(@CPF,@INDICE,1) <> @CPF_TEMP
      SET @DIGITOS_IGUAIS = 'N'
    SET @INDICE = @INDICE + 1
  END;

  --Caso os digitos n�o sej�o todos iguais Come�o o calculo do digitos
  IF @DIGITOS_IGUAIS = 'N' 
  BEGIN
    --C�lculo do 1� d�gito
    SET @SOMA = 0
    SET @INDICE = 1
    WHILE (@INDICE <= 9)
    BEGIN
      SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@CPF,@INDICE,1)) * (11 - @INDICE);
      SET @INDICE = @INDICE + 1
    END

    SET @DIG1 = 11 - (@SOMA % 11)

    IF @DIG1 > 9
      SET @DIG1 = 0;

    -- C�lculo do 2� d�gito }
    SET @SOMA = 0
    SET @INDICE = 1
    WHILE (@INDICE <= 10)
    BEGIN
      SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@CPF,@INDICE,1)) * (12 - @INDICE);
      SET @INDICE = @INDICE + 1
    END

    SET @DIG2 = 11 - (@SOMA % 11)

    IF @DIG2 > 9
      SET @DIG2 = 0;

    -- Validando
    IF (@DIG1 = SUBSTRING(@CPF,LEN(@CPF)-1,1)) AND (@DIG2 = SUBSTRING(@CPF,LEN(@CPF),1))
      SET @RESULTADO = 1
    ELSE
      SET @RESULTADO = 0
  END
  RETURN @RESULTADO
END
GO

CREATE TABLE FUNCIONARIO(
	CODIGO INT NOT NULL IDENTITY(1,1),
	NOME VARCHAR(50) NOT NULL,
	DATA_NASCIMENTO DATE NOT NULL,
	CPF CHAR(11) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	SEXO CHAR(1) NOT NULL,
	SALARIO MONEY NOT NULL,
	CIDADE VARCHAR(50) NOT NULL,
	UF CHAR(2) NOT NULL,
	DATA_HORA_CADASTRO DATETIME NOT NULL DEFAULT GETDATE(),
	ATIVO BIT NOT NULL DEFAULT 1,
	CONSTRAINT PK_FUNCIONARIO PRIMARY KEY(CODIGO),
	CONSTRAINT UQ_FUNCIONARIO_CPF UNIQUE(CPF),
	CONSTRAINT UQ_FUNCIONARIO_EMAIL UNIQUE(EMAIL),
	CONSTRAINT CK_FUNCIONARIO_CPF CHECK(DBO.FN_VALIDACPF(CPF)=1),
	CONSTRAINT CK_FUNCIONARIO_SEXO CHECK(SEXO IN('F','M')),
	CONSTRAINT CK_FUNCIONARIO_DATA_NASCIMENTO 
		CHECK(DATEDIFF(YEAR,DATA_NASCIMENTO,GETDATE())>=18)
);
GO
CREATE TABLE DEPENDENTE(
	CODIGO INT NOT NULL IDENTITY(1,1),
	NOME VARCHAR(50) NOT NULL,
	DATA_NASCIMENTO DATE NOT NULL,
	EMAIL VARCHAR(50) NULL,
	PARENTESCO VARCHAR(20) NOT NULL,
	COD_FUNCIONARIO INT NOT NULL,
	CONSTRAINT PK_DEPENDENTE PRIMARY KEY(CODIGO),
	CONSTRAINT FK_DEPENDENTE_FUNCIONARIO FOREIGN KEY(COD_FUNCIONARIO) 
		REFERENCES FUNCIONARIO(CODIGO),
	CONSTRAINT CK_DEPENDENTE_DATA_NASCIMENTO
		CHECK(DATEDIFF(YEAR,DATA_NASCIMENTO,GETDATE())<18)
);
GO
CREATE TABLE PROJETO(
	CODIGO INT NOT NULL IDENTITY(1,1),
	NOME VARCHAR(50) NOT NULL,
	DATA_INICIO DATE NOT NULL,
	DATA_TERMINO DATE NULL,
	VALOR MONEY NULL,
	COD_FUNC_GER INT NOT NULL,
	CONSTRAINT PK_PROJETO PRIMARY KEY(CODIGO),
	CONSTRAINT FK_PROJETO_FUNCIONARIO FOREIGN KEY(COD_FUNC_GER)
		REFERENCES FUNCIONARIO(CODIGO),
	CONSTRAINT CK_PROJETO_DATA_TERMINO 
		CHECK(DATA_TERMINO IS NULL OR DATA_TERMINO>=DATA_INICIO)
);
GO
CREATE TABLE FUNCIONARIO_PROJETO(
	CODIGO INT NOT NULL IDENTITY(1,1),
	COD_FUNCIONARIO INT NOT NULL,
	COD_PROJETO INT NOT NULL,
	DATA_ENTRADA DATE NOT NULL,
	DATA_SAIDA DATE NULL,
	NUM_HORAS_TRAB FLOAT NOT NULL,
	CONSTRAINT PK_FUNCIONARIO_PROJETO PRIMARY KEY(CODIGO),
	CONSTRAINT FK_FUNCIONARIO_PROJETO_FUNCIONARIO FOREIGN KEY(COD_FUNCIONARIO)
		REFERENCES FUNCIONARIO(CODIGO),
	CONSTRAINT FK_FUNCIONARIO_PROJETO_PROJETO FOREIGN KEY(COD_PROJETO)
		REFERENCES PROJETO(CODIGO),
	CONSTRAINT CK_FUNCIONARIO_PROJETO_DATA_SAIDA 
		CHECK(DATA_SAIDA IS NULL OR DATA_SAIDA>=DATA_ENTRADA),
	CONSTRAINT CK_FUNCIONARIO_PROJETO_NUM_HORAS_TRAB CHECK(NUM_HORAS_TRAB>=0)
);
