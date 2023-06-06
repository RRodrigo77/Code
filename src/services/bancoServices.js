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
        WHERE TbAluno.cpf = ?`,        
        // [`%${nome}%`], (error, result) => {
        [cpf], (error, result) => {
          if (error) {
            rejeitado(error);
            return;
          }
          if (result.length > 0) {
            aceito(result);
          } else {
            aceito(false);
          }
        });
    })
  }
  // loginAluno: (cpf, senha) => {
  //   return new Promise((aceito, rejeitado) => {
  //     dbEscola.query("SELECT * FROM TbAluno WHERE cpf = ?", [`%${cpf}%`], (error, result) => {
  //       if (error) { rejeitado(error); return; }
  //       if (result.length > [0]) {
  //         aceito(result);
  //       } else {
  //         aceito(false);
  //       }
  //     });
  //   });
  // }
}