 create database dbEscola;
 
 use dbEscola;
 
drop table TbAluno

SELECT * FROM TBaluno

CREATE TABLE TbAluno (
    IdAluno INT AUTO_INCREMENT,
    nomeAluno VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    IdResponsavel INT,
    IdPai INT,
    IdMae INT,
    email VARCHAR(100),
    CPF VARCHAR(11) NOT NULL,
    RG VARCHAR(10) NOT NULL,
    IdEndereco INT NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    matricula INT NULL,
    sexo CHAR(1) NOT NULL,
    PRIMARY KEY (IdAluno)
);

ALTER TABLE TbAluno MODIFY COLUMN matricula INT NULL;

ALTER TABLE TbAluno 
ADD CONSTRAINT FK_Aluno_Endereco 
FOREIGN KEY (IdEndereco) 
REFERENCES TbEndereco (IdEndereco);


CREATE TABLE TbResponsavel(
	IdResponsavel INT AUTO_INCREMENT,
    NomeR VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,  
    email VARCHAR(100),
    CPF VARCHAR(11) NOT NULL,
    RG VARCHAR(10) NOT NULL,
    IdEndereco INT NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    telefone_2 VARCHAR(15) NOT NULL,
    PRIMARY KEY (IdResponsavel)
)




ALTER TABLE TbResponsavel 
ADD CONSTRAINT FK_Responsavel_Endereco 
FOREIGN KEY (IdEndereco) 
REFERENCES TbEndereco (IdEndereco);


CREATE TABLE TbEndereco (
    IdEndereco INT PRIMARY KEY AUTO_INCREMENT,
    cep VARCHAR(8) NOT NULL,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(200)
);

CREATE TABLE TbProfessor (
    IdProfessor INT PRIMARY KEY AUTO_INCREMENT,
    NomeProfessor VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    RG VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(15),
    IdEndereco INT NOT NULL,
    StAtivo BIT NOT NULL
);

ALTER TABLE TbProfessor 
ADD CONSTRAINT FK_Professor_Endereco 
FOREIGN KEY (IdEndereco) 
REFERENCES TbEndereco (IdEndereco);


CREATE TABLE TbDisciplina (
    IdDisciplina INT PRIMARY KEY AUTO_INCREMENT,
    NomeDisciplina VARCHAR(100) NOT NULL,
    Sigla VARCHAR(10) NOT NULL,
    StAtivo BIT NOT NULL
);

CREATE TABLE TbCurso (
    IdCurso INT PRIMARY KEY AUTO_INCREMENT,
    NomeCurso VARCHAR(100) NOT NULL,
    StOficial BIT NOT NULL
);


CREATE TABLE TbSerie (
    IdSerie INT AUTO_INCREMENT,
    NomeSerie VARCHAR(100) NOT NULL,
    IdCurso INT NOT NULL,
    PRIMARY KEY (IdSerie),
    FOREIGN KEY (IdCurso) REFERENCES TbCurso(IdCurso)
);

select * from Tbserie

ALTER TABLE TbSerie
ADD COLUMN IdPeriodo INT;

ALTER TABLE TbSerie
ADD CONSTRAINT fk_Serie_Periodo FOREIGN KEY (IdPeriodo) REFERENCES TbPeriodo(IdPeriodo);

CREATE TABLE TbPeriodo (
    IdPeriodo INT AUTO_INCREMENT,
    PeriodoNumero INT NOT NULL,
    NomePeriodo VARCHAR(100) NOT NULL,
    DataInicial date not null,
    DataFinal date not null,
    PeriodoAtual BIT NOT NULL DEFAULT 0,
    PRIMARY KEY (IdPeriodo)
);

INSERT INTO TbPeriodo (PeriodoNumero, NomePeriodo, DataInicial, DataFinal)
VALUES ('2022', 'Período 2022', '2022-01-01', '2022-12-31');

delete from TbAluno where IdAluno > '23';

select * from Tbaluno;

select * from tbperiodo;

UPDATE TbPeriodo SET PeriodoAtual = 0 WHERE IdPeriodo = 2;
UPDATE TbPeriodo SET PeriodoNumero = 2024 WHERE IdPeriodo = 1;


INSERT INTO TbAluno (nomeAluno, data_nascimento, CPF, RG, telefone, Sexo)
VALUES ('jose', '1995-03-11', '10394343476', '002513202','(84) 999434387', 'M');

DROP TRIGGER IF EXISTS tr_insere_matricula_aluno;

DELIMITER //
CREATE TRIGGER tr_insere_matricula_aluno
BEFORE INSERT ON TbAluno
FOR EACH ROW
BEGIN
    DECLARE prox_num INT;
    SET prox_num = COALESCE((SELECT MAX(RIGHT(Matricula, 4)) FROM TbAluno), 0) + 1;
    SELECT PeriodoNumero INTO @periodoNumero FROM TbPeriodo WHERE PeriodoAtual = 1;
    SET NEW.Matricula = CONCAT(@periodoNumero, LPAD(prox_num, 4, '0'));
END//
DELIMITER ;