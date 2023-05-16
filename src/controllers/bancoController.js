const BancoServices = require('../services/bancoServices');

//Implementação de todas as consultas

module.exports = {
    buscarAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let Aluno = await BancoServices.buscarAlunos();

        for(let i in Aluno){
            json.result.push({
                id: Aluno[i].IdAluno,
                nome: Aluno[i].nomeAluno,
                data_nascimento: Aluno[i].data_nascimento                
            });
        }
        res.json(json);
    },
}
