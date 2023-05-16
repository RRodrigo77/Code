// Chamada da conexão
const dbEscola = require('../dbEscola');

module.exports = {

    buscarAlunos: () => {
        return new Promise((aceito, rejeitado) => {

            dbEscola.query('SELECT * FROM TbAluno', (error, result) => {
                if (error) { rejeitado(error); return; }
                aceito(result);
            });
        });
    }
}