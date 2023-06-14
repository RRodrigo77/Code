// Criação e controle de rotas
const express = require('express');
const router = express.Router();

const bancoController = require('./controllers/bancoController');

// Get dos dados
router.get('/alunodados/:cpf', bancoController.dadosAlunos);        // Monstra os dados dos alunos
router.get('/dadosresp/:cpf', bancoController.dadosResponsavel);    // Monstra os dados dos responsáveis
router.get('/dadosProf/:cpf', bancoController.dadosProf);           // Monstra os dados dos Professores
// implementar dados usuário usuário

// Inserção de cadastros no banco
router.post('/insertAluno', bancoController.insertAluno);       // Cadastro de alunos
router.post('/insertResp', bancoController.insertResp);         // Cadastro de Responsáveil
router.post('/insertProf', bancoController.insertProf);         // Cadastro de Professor
router.post('/insertUsuario', bancoController.insertUsuario);   // Cadastro de Usuário

// Updates de cadastros já existenstes
router.post('/updateAluno', bancoController.updateAluno); // Cadastro de alunos
router.post('/updateProf', bancoController.updateProf);   // Cadastro de Professor
router.post('/updateResp', bancoController.updatePesp);   // Cadastro de Responsáveil
// implementar update para dados de usuário

//  Autencitação para login
router.post('/login', bancoController.login);                   // Realiza a validação de cpf e senha para o login


// APIs de teste
router.get('/alunos', bancoController.buscarAlunos); // Retorna todos os alunos
router.get('/aluno/:nome', bancoController.buscarAlunoPorNome); // Retorna um Aluno com parâmetro "nome"

module.exports = router;
