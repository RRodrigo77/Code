const BancoServices = require('../services/bancoServices');

//Implementação de todas as consultas

module.exports = {
    buscarAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let Aluno = await BancoServices.buscarAlunos();

        for(let i in Aluno){
            json.result.push({
                id: Aluno[i].id_aluno,
                nome: Aluno[i].nome_aluno,
                sexo: Aluno[i].sexo_aluno                
            });
        }
        res.json(json);
    },
}
