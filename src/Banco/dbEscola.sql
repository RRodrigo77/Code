 # Criação do banco
 create database dbEscola;
 
 use dbEscola;

# Criação da tabela Aluno 
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

# Ajuste na tabela Aluno para Matricula receber valor null
ALTER TABLE TbAluno MODIFY COLUMN matricula INT NULL;


# Criação da Tabela dos responsáveis
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

# Criação da Tabela endereço
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

# INserção de chave estrangeira para endereço
ALTER TABLE TbResponsavel 
ADD CONSTRAINT FK_Responsavel_Endereco 
FOREIGN KEY (IdEndereco) 
REFERENCES TbEndereco (IdEndereco);


# Adicionado chave estrangeira a TbAluno IdEndereco
ALTER TABLE TbAluno 
ADD CONSTRAINT FK_Aluno_Endereco 
FOREIGN KEY (IdEndereco) 
REFERENCES TbEndereco (IdEndereco);

# Criação da tabela do professor
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

# CHave estrangeira do endereço
ALTER TABLE TbProfessor 
ADD CONSTRAINT FK_Professor_Endereco 
FOREIGN KEY (IdEndereco) 
REFERENCES TbEndereco (IdEndereco);

# criação da tabela de disciplinas
CREATE TABLE TbDisciplina (
    IdDisciplina INT PRIMARY KEY AUTO_INCREMENT,
    NomeDisciplina VARCHAR(100) NOT NULL,
    Sigla VARCHAR(10) NOT NULL,
    StAtivo BIT NOT NULL
);

# Tabela dos cursos
CREATE TABLE TbCurso (
    IdCurso INT PRIMARY KEY AUTO_INCREMENT,
    NomeCurso VARCHAR(100) NOT NULL,
    StOficial BIT NOT NULL
);

# Tabela das séries
CREATE TABLE TbSerie (
    IdSerie INT AUTO_INCREMENT,
    NomeSerie VARCHAR(100) NOT NULL,
    IdCurso INT NOT NULL,
    PRIMARY KEY (IdSerie),
    FOREIGN KEY (IdCurso) REFERENCES TbCurso(IdCurso)
);

# Criação da tabela do período
CREATE TABLE TbPeriodo (
    IdPeriodo INT AUTO_INCREMENT,
    PeriodoNumero INT NOT NULL,
    NomePeriodo VARCHAR(100) NOT NULL,
    DataInicial date not null,
    DataFinal date not null,
    PeriodoAtual BIT NOT NULL DEFAULT 0,
    PRIMARY KEY (IdPeriodo)
);

#inserção de IdPeriodo estrangeiro
ALTER TABLE TbSerie
ADD COLUMN IdPeriodo INT;


ALTER TABLE TbSerie
ADD CONSTRAINT fk_Serie_Periodo FOREIGN KEY (IdPeriodo) REFERENCES TbPeriodo(IdPeriodo);

ALTER TABLE TbSerie DROP FOREIGN KEY fk_Serie_GRADE;
ALTER TABLE TbSerie DROP COLUMN Idgrade;


# Criação de uma trigger para quando inserir um caluno o mesmo ter uma matricula inserida usando o período atual
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

# Criação da tabela turma
CREATE TABLE TbTurma (
    IdTurma INT AUTO_INCREMENT,
    NomeTurma VARCHAR(100) NOT NULL,
    SiglaTurma VARCHAR(100) NOT NULL,
    IdCurso INT NOT NULL,
    IdSerie INT NOT NULL,
    IdPeriodo INT NOT NULL,
    PRIMARY KEY (IdTurma),
    FOREIGN KEY (IdCurso) REFERENCES TbCurso(IdCurso),
    FOREIGN KEY (IdSerie) REFERENCES TbSerie(IdSerie),
    FOREIGN KEY (IdPeriodo) REFERENCES TbPeriodo(IdPeriodo)
);


# Criação da tabela para grade curriculas
CREATE TABLE TbGrade (
  IdGrade INT AUTO_INCREMENT,
  IdCurso INT,
  IdPeriodo INT,
  IdSerie INT,
  IdDisciplina INT,
  PRIMARY KEY (IdGrade),
  FOREIGN KEY (IdCurso) REFERENCES TbCurso(IdCurso),
  FOREIGN KEY (IdPeriodo) REFERENCES TbPeriodo(IdPeriodo),
  FOREIGN KEY (IdSerie) REFERENCES TbSerie(IdSerie),
  FOREIGN KEY (IdDisciplina) REFERENCES TbDisciplina(IdDisciplina)
);

# Criação de procidure para acrecentar um número de disciplinas na TbGrade
DELIMITER $$
CREATE PROCEDURE add_disciplina_column()
BEGIN
    DECLARE contador INT;
    DECLARE coluna VARCHAR(50);
    SELECT COUNT(*) INTO contador FROM information_schema.columns WHERE table_name = 'TbGrade' AND column_name LIKE 'IdDisciplina%';
    SET coluna = CONCAT('IdDisciplina', contador + 1);
    SET @sql_query = CONCAT('ALTER TABLE TbGrade ADD ', coluna, ' INT NULL');
    PREPARE stmt FROM @sql_query;
    EXECUTE stmt;
END$$
DELIMITER ;

CALL add_disciplina_column();

# Criação da Tabela Aluno turma
CREATE TABLE TbAlunoTurma (
  IdAlunoTurma INT AUTO_INCREMENT,
  IdTurma INT,
  IdAluno INT,
  PRIMARY KEY (IdAlunoTurma),
  FOREIGN KEY (IdAluno) REFERENCES TbAluno(IdAluno)
);

# Inserida situação do aluno na turma para verificar se aluno está ativo ou não
ALTER TABLE Tbalunoturma
ADD COLUMN StAlunoTurma BIT NOT NULL DEFAULT 1;

# Criada VIEW para visualizar os alunos por turma
CREATE VIEW VW_Aluno_Situacao AS
SELECT TbPeriodo.NomePeriodo, TbSerie.NomeSerie, TbCurso.NomeCurso, TbTurma.NomeTurma, TbTurma.SiglaTurma, TbAluno.Matricula, TbAluno.NomeAluno, 
CASE Tbalunoturma.Stalunoturma 
            WHEN 1 THEN 'Ativo' 
            WHEN 0 THEN 'Inativo' 
       END AS StAlunoTurma
FROM TbAluno 
INNER JOIN Tbalunoturma ON TbAluno.IdAluno = Tbalunoturma.Idaluno 
INNER JOIN TbTurma ON TbTurma.Idturma = Tbalunoturma.Idturma 
INNER JOIN TbSerie ON TbSerie.IdSerie = TbTurma.IdSerie 
INNER JOIN TbCurso ON TbCurso.IdCurso = TbSerie.IdCurso 
INNER JOIN TbPeriodo ON TbPeriodo.IdPeriodo = TbTurma.IdPeriodo;

# Teste para manupular a visualização da VW
SELECT * FROM VW_Aluno_Situacao WHERE idaluno = 23
WHERE NomeTurma = 'Turma B';
DESCRIBE VW_Aluno_Situacao
select * from tbaluno 
where NomeAluno = "rodrigo" or Matricula = 'Matricula'

select * from tbresponsavel

# Usado o SHA1() para criptografia da senha no banco
# Inserido coluna para senha na tbaluno
ALTER TABLE TbAluno ADD senha VARCHAR(255);

# Inserindo senha para um cadastro de aluno para futuros testes
ALTER TABLE TbAluno ADD senha VARCHAR(255);
UPDATE TbAluno SET senha = SHA1('123456') WHERE idAluno = 43;

ALTER TABLE tbresponsavel ADD COLUMN senha VARCHAR(255) DEFAULT '123';

ALTER TABLE tbaluno ALTER COLUMN senha SET DEFAULT '123';

ALTER TABLE tbprofessor ADD COLUMN senha VARCHAR(255) DEFAULT '123';

# Criação da tabela de usuários
CREATE TABLE TbUsuario (
  IdUsuario INT NOT NULL AUTO_INCREMENT,
  NomeUsuario VARCHAR(100) NOT NULL,
  NomeCargo VARCHAR(100),
  senha VARCHAR(256) DEFAULT '123',
  StAtivo BIT DEFAULT 1,
  PRIMARY KEY (IdUsuario)
);

SELECT cpf, senha FROM TbUsuario
ALTER TABLE tbusuario
DROP COLUMN cpf;
update tbusuario set rg = '002513202' where idusuario = 1
ALTER TABLE tbusuario ADD COLUMN cpf VARCHAR(11) NOT NULL
ALTER TABLE tbusuario ADD COLUMN RG VARCHAR(20) NOT NULL

SELECT cpf, senha FROM TbUsuario WHERE senha = sha1("123456") and cpf = '10394343476'

update tbusuario set senha = UNHEX(SHA2('mypassword', 256)) where idusuario = 1

select * from tbusuario

# TESTES DE CONSULTAS PARA DADOS DOS ALUNOS
SELECT 
    TbAluno.NomeAluno,
    TbAluno.telefone,
    TbAluno.email,
    TbAluno.matricula,
    TbTurma.NomeTurma,
    TbSerie.NomeSerie,
    TbResponsavel.NomeR AS NomeResponsavel,
    R.NomeAluno AS NomePai,
    M.NomeAluno AS NomeMae

FROM 
    TbAluno

INNER JOIN 
    TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
INNER JOIN 
    TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
INNER JOIN 
    TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
LEFT JOIN 
    TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
LEFT JOIN 
    TbAluno R ON R.IdAluno = TbAluno.IdPai AND R.IdResponsavel = TbAluno.IdResponsavel
LEFT JOIN 
    TbAluno M ON M.IdAluno = TbAluno.IdMae AND M.IdResponsavel = TbAluno.IdResponsavel;

SELECT 
    TbAluno.NomeAluno,
    TbAluno.cpf,
    TbAluno.rg,
    TbAluno.telefone,
    TbAluno.email,
    TbAluno.matricula,
    TbTurma.NomeTurma,
    TbSerie.NomeSerie,
    TbResponsavel.NomeR AS NomeResponsavel,
    RP.NomeR AS NomePai,
    RM.NomeR AS NomeMae  
FROM TbAluno
INNER JOIN TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
INNER JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
INNER JOIN TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
LEFT JOIN  TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
LEFT JOIN  TbResponsavel AS RP ON RP.IdResponsavel = TbAluno.IdPai AND RP.IdResponsavel = TbResponsavel.IdResponsavel
LEFT JOIN  TbResponsavel AS RM ON RM.IdResponsavel = TbAluno.IdMae AND RM.IdResponsavel = TbResponsavel.IdResponsavel
WHERE TbAluno.NomeAluno LIKE 'miguel' OR TbAluno.matricula = 'matricula_do_aluno';

SELECT 
          TbAluno.NomeAluno,
          TbAluno.telefone,
          TbAluno.cpf,
          TbAluno.rg,
          TbAluno.email,
          TbAluno.matricula,
          TbTurma.NomeTurma,
          TbSerie.NomeSerie,
          TbResponsavel.NomeR AS NomeResponsavel,
          RP.NomeR AS NomePai,
          RM.NomeR AS NomeMae  
        FROM TbAluno
        INNER JOIN TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
        INNER JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
        INNER JOIN TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
        LEFT JOIN TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
        LEFT JOIN TbResponsavel AS RP ON RP.IdResponsavel = TbAluno.IdPai AND RP.IdResponsavel = TbResponsavel.IdResponsavel
        LEFT JOIN TbResponsavel AS RM ON RM.IdResponsavel = TbAluno.IdMae AND RM.IdResponsavel = TbResponsavel.IdResponsavel
        
SELECT 
          TbAluno.NomeAluno,
          TbAluno.telefone,
          TbAluno.cpf,
          TbAluno.rg,
          TbAluno.email,
          TbAluno.matricula,
          TbTurma.NomeTurma,
          TbSerie.NomeSerie,
          TbResponsavel.NomeR AS NomeResponsavel,
          RP.NomeR AS NomePai,
          RM.NomeR AS NomeMae  
        FROM TbAluno
        INNER JOIN TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
        INNER JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
        INNER JOIN TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
        LEFT JOIN TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
        LEFT JOIN TbResponsavel AS RP ON RP.IdResponsavel = TbAluno.IdPai AND RP.IdResponsavel = TbResponsavel.IdResponsavel
        LEFT JOIN TbResponsavel AS RM ON RM.IdResponsavel = TbAluno.IdMae AND RM.IdResponsavel = TbResponsavel.IdResponsavel
        WHERE TbAluno.nomealuno = 'miguel'
        
# Criação da TbDiario
CREATE TABLE tbdiario (
  IdDiario INT PRIMARY KEY AUTO_INCREMENT,
  nomeDiario VARCHAR(100),
  IdProfessor INT,
  IdDisciplina INT,
  IdTurma INT,
  FOREIGN KEY (IdProfessor) REFERENCES tbprofessor(Idprofessor),
  FOREIGN KEY (IdDisciplina) REFERENCES tbdisciplina(IdDisciplina),
  FOREIGN KEY (IdTurma) REFERENCES tbturma(IdTurma)
);
 # Criação da tabela para registro de aula
CREATE TABLE tbregistrodiario (
  Idregistro INT PRIMARY KEY AUTO_INCREMENT,
  IdDiario INT,
  IdDisciplina INT,
  IdProfessor INT,
  IdTurma INT,
  conteudo TEXT,
  data DATE,
  FOREIGN KEY (IdDiario) REFERENCES tbdiario(IdDiario),
  FOREIGN KEY (IdProfessor) REFERENCES tbprofessor(IdProfessor),
  FOREIGN KEY (IdDisciplina) REFERENCES tbdisciplina(IdDisciplina),
  FOREIGN KEY (IdTurma) REFERENCES tbturma(IdTurma)
);

alter table tbregistrodiario

# Ajuste na senha
ALTER TABLE tbaluno MODIFY senha VARCHAR(256);
ALTER TABLE tbresponsavel MODIFY senha VARCHAR(256);
ALTER TABLE tbprofessor MODIFY senha VARCHAR(256);
ALTER TABLE tbusuario MODIFY senha VARCHAR(256);

# Inserido sexo na demais tabelas
ALTER TABLE Tbprofessor ADD COLUMN sexo CHAR(1) NOT NULL;
ALTER TABLE tbresponsavel ADD COLUMN sexo CHAR(1) NOT NULL;
ALTER TABLE tbusuario ADD COLUMN sexo CHAR(1) NOT NULL;

SELECT 
          TbAluno.NomeAluno,
          TbAluno.telefone,
          TbAluno.cpf,
          TbAluno.rg,
          DATE_FORMAT(TbAluno.data_nascimento, '%d/%m/%Y') AS data_nascimento_formatada,
          TbAluno.email,
          TbAluno.matricula,
          TbTurma.NomeTurma,          
          TbSerie.NomeSerie,
          TbResponsavel.NomeR AS NomeResponsavel,
          RP.NomeR AS NomePai,
          RM.NomeR AS NomeMae  
        FROM TbAluno
        INNER JOIN TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
        INNER JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
        INNER JOIN TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
        LEFT JOIN TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
        LEFT JOIN TbResponsavel AS RP ON RP.IdResponsavel = TbAluno.IdPai AND RP.IdResponsavel = TbResponsavel.IdResponsavel
        LEFT JOIN TbResponsavel AS RM ON RM.IdResponsavel = TbAluno.IdMae AND RM.IdResponsavel = TbResponsavel.IdResponsavel
        WHERE TbAluno.cpf = '10394343476';

select * from tbaluno

# Criada VW para retornar os dados dos alunos
CREATE VIEW Vw_dados_alunos AS 
SELECT 
  TbAluno.NomeAluno,
  TbAluno.telefone,
  TbAluno.cpf,
  TbAluno.rg,
  DATE_FORMAT(TbAluno.data_nascimento, '%d/%m/%Y') AS data_nascimento,
  TbAluno.email,
  TbAluno.matricula,
  TbTurma.NomeTurma,          
  TbSerie.NomeSerie,
  TbResponsavel.NomeR AS NomeResponsavel,
  RP.NomeR AS NomePai,
  RM.NomeR AS NomeMae,
  CASE TbAluno.sexo 
		WHEN 'M' THEN 'Masculino'
		WHEN 'F' THEN 'Feminino'
		WHEN 'O' THEN 'Outro' END AS sexo
FROM TbAluno
LEFT JOIN TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
LEFT JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
LEFT JOIN TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
LEFT JOIN TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
LEFT JOIN TbResponsavel AS RP ON RP.IdResponsavel = TbAluno.IdPai AND RP.IdResponsavel = TbResponsavel.IdResponsavel
LEFT JOIN TbResponsavel AS RM ON RM.IdResponsavel = TbAluno.IdMae AND RM.IdResponsavel = TbResponsavel.IdResponsavel;

drop view Vw_dados_alunos
SELECT * FROM Vw_dados_alunos WHERE cpf = '98712398737'
select * from tbresponsavel

SELECT 
  TbAluno.NomeAluno,
  TbAluno.telefone,
  TbAluno.cpf,
  TbAluno.rg,
  DATE_FORMAT(TbAluno.data_nascimento, '%d/%m/%Y') AS data_nascimento,
  TbAluno.email,
  TbAluno.matricula,
  TbTurma.NomeTurma,          
  TbSerie.NomeSerie,
  TbResponsavel.NomeR AS NomeResponsavel,
  RP.NomeR AS NomePai,
  RM.NomeR AS NomeMae  
FROM TbAluno
INNER JOIN TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
INNER JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
INNER JOIN TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
LEFT JOIN TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
LEFT JOIN TbResponsavel AS RP ON RP.IdResponsavel = TbAluno.IdPai AND RP.IdResponsavel = TbResponsavel.IdResponsavel
LEFT JOIN TbResponsavel AS RM ON RM.IdResponsavel = TbAluno.IdMae AND RM.IdResponsavel = TbResponsavel.IdResponsavel
where TbAluno.idaluno > 1

select * from Vw_dados_alunos where TbAluno.cpf = ?
select * from Vw_dados_alunos where cpf = '11111111111'

select * from tbresponsavel

ALTER TABLE tbresponsavel MODIFY telefone_2 VARCHAR(15) NULL;

INSERT INTO tbprofessor (NomeProfessor, cpf, RG, email, telefone, StAtivo, sexo, senha) values('Josemar da Silva', '13970265029', '123334445', 'emaildoprofessor@gmail.com','(84)999444487',1,'M', SHA2('123', 256));

update tbprofessor set senha = SHA2('123', 256) where idprofessor =1;

SELECT NomeProfessor, cpf, RG, email, telefone,
        CASE
            WHEN sexo = 'M' THEN 'Masculino'
            WHEN sexo = 'F' THEN 'Feminino'
            ELSE 'Outro'
        END AS sexo,
        CASE
            WHEN StAtivo = 1 THEN 'Ativo'
            ELSE 'Inativo'
        END AS status,
        senha
    FROM TbProfessor
    WHERE cpf = "28183403069"
    
UPDATE TbAluno set senha = SHA2('123', 256) where idaluno = 43

select * from tbalunoturma

SELECT Tbturma.nometurma, tbaluno.nomealuno, tbalunoturma.stalunoturma FROM tbalunoturma
INNER JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma

SELECT TbTurma.idturma, TbSerie.NomeSerie as "Série", TbTurma.nometurma as 'Nome da turma', tbaluno.nomealuno as 'Aluno', 
    CASE tbalunoturma.stalunoturma
          WHEN 1 THEN 'Cursando'
          WHEN 0 THEN 'Inativo'
    END AS Situação
FROM tbalunoturma
INNER JOIN TbTurma ON TbTurma.IdTurma = tbalunoturma.IdTurma
INNER JOIN tbaluno ON tbaluno.IdAluno = tbalunoturma.IdAluno
right JOIN tbserie ON TbTurma.IdTurma = tbalunoturma.IdTurma

SELECT * FROM tbprofessor

INSERT INTO tbdisciplina (Nomedisciplina, sigla, stativo) VALUES 
('Matemática', 'MAT', 1),
('História', 'HIS', 1),
('Geografia', 'GEO', 1),
('Biologia', 'BIO', 1),
('Física', 'FIS', 1)

insert into tbnotas ()

SELECT TbTurma.idturma, TbSerie.NomeSerie AS "Série", TbTurma.nometurma AS 'Nome da turma', tbaluno.nomealuno AS 'Aluno', 
    CASE tbalunoturma.stalunoturma
          WHEN 1 THEN 'Cursando'
          WHEN 0 THEN 'Inativo'
    END AS Situação
FROM tbalunoturma
INNER JOIN TbTurma ON TbTurma.IdTurma = tbalunoturma.IdTurma
INNER JOIN tbaluno ON tbaluno.IdAluno = tbalunoturma.IdAluno
INNER JOIN tbserie ON TbTurma.IdSerie = tbserie.IdSerie

SELECT t.idturma, t.nometurma, t.siglaturma, c.nomecurso, s.nomeserie, p.nomeperiodo 
	FROM Tbturma as t
    left JOIN tbcurso AS c ON c.idcurso = t.idcurso
    left JOIN tbserie AS s ON s.idserie = t.idserie
    INNER JOIN tbperiodo AS p ON p.idperiodo = t.idperiodo


select * from tbnotas

select * from tbalunoturma
drop table tbnotas
# Criada tabela para receber notas dos alunos
CREATE TABLE TbNotas (
  IdNota INT PRIMARY KEY AUTO_INCREMENT,
  Idalunoturma INT,
  IdAluno INT,
  IdDisciplina INT,
  nota1 FLOAT,
  nota2 FLOAT,
  nota3 FLOAT,
  media FLOAT,
  FOREIGN KEY (Idalunoturma) REFERENCES tbalunoturma(Idalunoturma),
  FOREIGN KEY (Idaluno) REFERENCES tbaluno(idaluno),
  FOREIGN KEY (iddisciplina) REFERENCES tbdisciplina(IdDisciplina)
);

INSERT INTO TbNotas (Idaluno, Idalunoturma, IdDisciplina, nota1, nota2, nota3) values(43, 2, 1, 7.5, 8, 10)
SELECT * FROM TBNOTAS


SELECT a.nomealuno, t.nometurma, d.nomedisciplina, n.nota1, n.nota2, n.nota3
FROM TbNotas n
JOIN tbaluno a ON n.IdAluno = a.idaluno
JOIN tbalunoturma at ON n.Idalunoturma = at.Idalunoturma
JOIN tbturma t ON at.IdTurma = t.idturma
JOIN tbdisciplina d ON n.IdDisciplina = d.IdDisciplina
WHERE a.idaluno = '43'

