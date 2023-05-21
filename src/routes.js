// Criação e controle de rotas

const express = require('express');
const router = express.Router();

const bancoController = require('./controllers/bancoController');

router.get('/aluno', bancoController.buscarAlunos); // Retorna todos os alunos
router.get('/aluno/:nome', bancoController.buscarAlunoPorNome);

module.exports = router;