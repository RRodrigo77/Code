// Chamada da conexão
const dbEscola = require('../dbEscola');
// teste
module.exports = {

    buscarAlunos: () => {
        return new Promise((aceito, rejeitado) => {

            dbEscola.query('SELECT * FROM Aluno', (error, result) => {
                if (error) { rejeitado(error); return; }
                aceito(result);
            });
        });
    }
}