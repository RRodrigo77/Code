const mysql = require('mysql');

// Parametros informados para acessar o banco MYSQL
const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

// Conexão do servidor com o banco de dados dbEscola
connection.connect((error)=>{
    if(error) throw error;
    console.log('Conectado ao Banco de dados:',process.env.DB_NAME)
});

//exportando a conexão
module.exports = connection;