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
    },

    buscarAlunoPorNome: (nome) => {
        return new Promise((aceito, rejeitado) => {
            dbEscola.query('SELECT * FROM TbAluno WHERE nomeAluno LIKE ?  ORDER BY NomeAluno', [`%${nome}%`], (error, result) => {
                if (error) { rejeitado(error); return; }
                if(result.length > [0]){
                    aceito(result);
                }else{
                    aceito(false);
                }
            });
        });
    },

    dadosAlunos: (nome) => {
        return new Promise((aceito, rejeitado) => {
            dbEscola.query(' criar consulta para tela de dados', [`%${nome}%`], (error, result) => {
                if (error) { rejeitado(error); return; }
                if(result.length > [0]){
                    aceito(result);
                }else{
                    aceito(false);
                }
            });
        });
    }
}