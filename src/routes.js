// Criação e controle de rotas
const dbEscola = require('./dbEscola');
const express = require('express');
const router = express.Router();

const bancoController = require('./controllers/bancoController');

router.get('/alunos', bancoController.buscarAlunos); // Retorna todos os alunos
router.get('/aluno/:nome', bancoController.buscarAlunoPorNome); // Retorna um Aluno com parâmetro "nome"
router.get('/alunodados', bancoController.dadosAlunos);
//tentativa de login
router.post('/loginAluno', async (req, res) => {
  const { cpf, senha } = req.body;

  try {
    const result = await dbEscola.query("SELECT * FROM TbAluno WHERE cpf = ?", [cpf]);
    if (result.length > 0 && result[0].senha === senha) {
      res.send({ msg: "Usuário logado com sucesso" });
      console.log(cpf, senha);
    } else {
      return res.status(401).send({ msg: "Credenciais inválidas" });
    }
  } catch (error) {
    return res.status(500).send({ msg: "Erro interno do servidor" });
  }
});



module.exports = router;