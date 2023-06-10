// Chamada da conexão
const dbEscola = require('../dbEscola');

module.exports = {

  buscarAlunos: () => {
    return new Promise((aceito, rejeitado) => {

      dbEscola.query("SELECT * FROM VW_Aluno_Situacao WHERE NomeAluno = 'miguel'", (error, result) => {
        if (error) { rejeitado(error); return; }
        aceito(result);
      });
    });
  },

  buscarAlunoPorNome: (nome) => {
    return new Promise((aceito, rejeitado) => {
      dbEscola.query('SELECT * FROM TbAluno WHERE nomeAluno LIKE ?  ORDER BY NomeAluno', [`%${nome}%`], (error, result) => {
        if (error) { rejeitado(error); return; }
        if (result.length > [0]) {
          aceito(result);
        } else {
          aceito(false);
        }
      });
    });
  },

  dadosAlunos: (cpf) => {
    return new Promise((aceito, rejeitado) => {
      dbEscola.query(`SELECT 
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
      INNER JOIN TbAlunoTurma ON TbAlunoTurma.IdAluno = TbAluno.IdAluno
      INNER JOIN TbTurma ON TbTurma.IdTurma = TbAlunoTurma.IdTurma
      INNER JOIN TbSerie ON TbTurma.IdSerie = TbSerie.IdSerie
      LEFT JOIN TbResponsavel ON TbResponsavel.IdResponsavel = TbAluno.IdResponsavel
      LEFT JOIN TbResponsavel AS RP ON RP.IdResponsavel = TbAluno.IdPai AND RP.IdResponsavel = TbResponsavel.IdResponsavel
      LEFT JOIN TbResponsavel AS RM ON RM.IdResponsavel = TbAluno.IdMae AND RM.IdResponsavel = TbResponsavel.IdResponsavel 
      WHERE TbAluno.cpf = ?`, 
        [cpf], (error, result) => {
          if (error) {
            rejeitado(error);
            return;
          }
          if (result.length > [0]) {
            aceito(result);
          } else {
            aceito(false);
          }
        });
    })
  },

  dadosResponsavel: (cpf) => {
    return new Promise((aceito, rejeitado) => {
      dbEscola.query(`SELECT 
        NomeR,
        DATE_FORMAT(data_nascimento, '%d/%m/%Y') as data_nascimento,
        email,
        CPF,
        RG,
        IdEndereco,
        telefone,
        telefone_2,
        senha,
        case sexo 
        WHEN 'M' THEN 'Masculino'
            WHEN 'F' THEN 'Feminino'
            WHEN 'O' THEN 'Outro' END AS sexo
        FROM tbresponsavel WHERE cpf = ?;`,
        [cpf], (error, result) => {
          if (error) {
            rejeitado(error);
            return;
          }
          if (result.length > [0]) {
            aceito(result);
          } else {
            aceito(false);
          }
        });
    });
  },  

  login: (cpf, userType) => {
    return new Promise((aceito, rejeitado) => {

      const userTypeMap = {
        'professor': "tbProfessor",
        'aluno': "TbAluno",
        'responsavel': "tbresponsavel",
        'usuario': "TbUsuario"
      };
      const userTypeValue = userTypeMap[userType];

      dbEscola.query(`SELECT cpf, senha FROM ${userTypeValue} WHERE cpf = ?`,
        [cpf], (error, result) => {
          if (error) {
            rejeitado(error);
            return;
          }
          if (result.length > [0]) {
            aceito(result);
          } else {
            aceito(false);
          }
        });
    });
  },
  // Pensar em mais parametros para realizar o update
  // realizar mais teste para melhorar a implementação do update
  updateAluno: (nome, cpf, rg, data_nascimento, email, telefone) => {
    return new Promise((aceito, rejeitado) => {
      dbEscola.query(`SELECT cpf FROM Tbaluno WHERE cpf = ?`,
        [cpf], (error, result) => {
          if (error) {
            rejeitado(error);
            return;
          }
          if (result.length > [0]) {
            dbEscola.query(`
            UPDATE TbAluno SET NomeAluno = ?, cpf = ?, rg = ?, data_nascimento = ?, email = ?, telefone = ?  
            WHERE idaluno = 22;
            `,
              [nome, cpf, rg, data_nascimento, email, telefone, cpf], (error, result) => {
                if (error) {
                  rejeitado(error);
                  return;
                }
                if (result) {
                  console.log(result);
                  aceito(true);
                } else {
                  console.log(result);
                  aceito(false);
                }
              });
          } else {
            aceito(false);
          }
        });
    })
  },

  insertAluno: (nome, cpf, rg, data_nascimento, email, telefone, sexo, senha)  => {
    return new Promise((aceito, rejeitado) => {
      dbEscola.query(`
      INSERT INTO tbaluno
        (nomeAluno, data_nascimento, CPF, RG, sexo, telefone, email, senha)
      VALUES(?,?,?,?,?,?,?,SHA2(?, 256));
        `,
        [nome, data_nascimento, cpf, rg, sexo, telefone, email, senha], (error, result) => {
          if (error) {
            rejeitado(error);
            return;
          }
          if (result.length > [0]) {
            aceito(result);
          } else {
            aceito(false);
          }
        });
    });
  },
  // Ajustar tratativa para inserir ou não telefone_2
  insertResp: (nome, cpf, rg, data_nascimento, email, telefone, sexo, senha)  => {
    return new Promise((aceito, rejeitado) => {
      dbEscola.query(`
      INSERT INTO TbResponsavel
        (nomeR, data_nascimento, CPF, RG, sexo, telefone, email, senha)
      VALUES(?,?,?,?,?,?,?,SHA2(?, 256));
        `,
        [nome, data_nascimento, cpf, rg, sexo, telefone, email, senha], (error, result) => {
          if (error) {
            rejeitado(error);
            return;
          }
          if (result.length > [0]) {
            aceito(result);
          } else {
            aceito(false);
          }
        });
    });
  }
}