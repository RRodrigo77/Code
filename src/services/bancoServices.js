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
      dbEscola.query(`select * from Vw_dados_alunos where cpf = ?`, // Criada VVw_dados_alunos para consultar dados alunos
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

  // continuar criando insert
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
  }
}