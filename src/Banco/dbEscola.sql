 # Criação do banco
 create database dbEscola;
 
 use dbEscola;

# Criação da tabela Aluno 
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



