// Criação e controle de rotas

const express = require('express');
const router = express.Router();

const bancoController = require('./controllers/bancoController');

router.get('/alunos', bancoController.buscarAlunos); // Retorna todos os alunos
router.get('/aluno/:nome', bancoController.buscarAlunoPorNome); // Retorna um Aluno com parâmetro "nome"
//router.get('/alunodados/:matricula/:nome', bancoController.dadosAlunos);
router.get('/alunodados', bancoController.dadosAlunos); // Api em testes
//Criar API post para edição de cadastros
module.exports = router;