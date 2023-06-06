// Criação e controle de rotas
const dbEscola = require('./dbEscola');
const express = require('express');
const router = express.Router();

const bancoController = require('./controllers/bancoController');

router.get('/alunos', bancoController.buscarAlunos); // Retorna todos os alunos
router.get('/aluno/:nome', bancoController.buscarAlunoPorNome); // Retorna um Aluno com parâmetro "nome"
router.get('/alunodados/:cpf', bancoController.dadosAlunos);
//tentativa de login
router.post('/loginAluno', async (req, res) => {
  const { cpf, senha } = req.body;

  try {
    dbEscola.query("SELECT * FROM TbAluno WHERE cpf = ?",
      [cpf], (error, result) => {
        if (error) {
          console.log(error);
          res.send(result);
          return;
        }
        if (result.length > 0) {
          res.send({ msg: "Usuário logado com sucesso" });
        } else {
          res.send({ msg: "Credenciais inválidas" });
        }
      });

    // const result = await dbEscola.query("SELECT * FROM TbAluno WHERE cpf = ?", [cpf]);
    // if (result.length > 0) {
    //   res.send({ msg: cpf });
    //   console.log(cpf, senha);
    // } else {
    //   res.send({ msg: cpf });
    //   // return res.status(401).send({ msg: "Credenciais inválidas" });
    // }
  } catch (error) {
    return res.status(500).send({ msg: "Erro interno do servidor" });
  }
});



module.exports = router;