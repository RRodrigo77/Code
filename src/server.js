//Criação do servidor 

// dotenv para servidor conseguir ler os arquivos do sistema criados em "variaveis.env"
require('dotenv').config({path:'variaveis.env'});
const express = require('express');
const cors = require('cors'); // permissão de acesso via API
const bodyParser = require('body-parser'); //converter body e requisição para converssão

const routes = require('./routes'); //chamada ao servidor

const server = express();
server.use(cors());
server.use(bodyParser.urlencoded({extended: false}));
server.use(bodyParser.json());
server.use('/api',routes);

// Direcionando a porta definida em "variaveis.env"
server.listen(process.env.PORT, () => {
  console.log(`Server listening on port ${process.env.PORT}`);
}).on('error', err => {
  console.error(err);
});