const BancoServices = require('../services/bancoServices');

//Implementação do retorno json

module.exports = {
    buscarAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let Aluno = await BancoServices.buscarAlunos();

        for(let i in Aluno){
            json.result.push({
                id: Aluno[i].IdAluno,
                nome: Aluno[i].nomeAluno,
                matricula: Aluno[i].matricula               
            });
        }
        res.json(json);
    },

    buscarAlunoPorNome: async(req, res)=>{
        let json = {error:'', result:[]};

        let nome = req.params.nome;        
        let Aluno = await BancoServices.buscarAlunoPorNome(nome);

        if(Aluno){
            json.result = Aluno;
        }
        res.json(json);
    },

    dadosAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let nome = req.params.nome;        
        let Aluno = await BancoServices.dadosAlunos(nome);

        if(Aluno){
            json.result = Aluno;
        }
        res.json(json);
    }
}