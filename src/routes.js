// Criação e controle de rotas
const express = require('express');
const router = express.Router();

const bancoController = require('./controllers/bancoController');


router.get('/alunos', bancoController.buscarAlunos); // Retorna todos os alunos
router.get('/aluno/:nome', bancoController.buscarAlunoPorNome); // Retorna um Aluno com parâmetro "nome"
router.get('/alunodados/:cpf', bancoController.dadosAlunos); // Monstra os dados dos alunos
router.get('/dadosresp/:cpf', bancoController.dadosResponsavel);

router.post('/login', bancoController.login); // Realiza a validação de cpf e senha para o login
router.post('/UPDATEaluno', bancoController.updateAluno);
router.post('/insertaluno', bancoController.insertAluno);
router.post('/insertResp', bancoController.insertResp);




// Código abaixo já dividido no Controller e Services

// router.post('/loginAluno', async (req, res) => {
//   const cpf = req.body.cpf;
//   const senha = req.body.senha;
//   const senhaHash = crypto.createHash('sha256').update(senha).digest('hex');

//   try {
//     dbEscola.query("SELECT cpf, senha FROM TbAluno WHERE cpf = ?",
//       [cpf], (error, result) => {
//         if (error) {
//           console.log(error);
//           res.send(result);
//           return;
//         }
//         if (result.length > 0) {
//           if(result[0].senha === senhaHash){
//             res.send({ msg: "Usuário logado com sucesso" });
//             console.log("cpf informado:        " + cpf);
//             console.log("cpf salvo no banco:   " + cpf);
//             console.log("senha informada:      " + senha);
//             console.log("senha salva no banco: " + senhaHash);
//           }else{
//             res.send({ msg: "Senha incorreta" });
//           } 
//         } else {
//           res.send({ msg: "Usuário não encontrado" });
//           console.log("senha informada:      " + senha);
//         }
//       });
//   } catch (error) {
//     return res.status(500).send({ msg: "Erro interno do servidor" });
//   }
// });



module.exports = router;