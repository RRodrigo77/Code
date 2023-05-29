const BancoServices = require('../services/bancoServices');

//Implementação do retorno json

module.exports = {
    buscarAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let Aluno = await BancoServices.buscarAlunos();

        for(let i in Aluno){
            json.result.push({
                Periodo: Aluno[i].NomePeriodo,
                nomeSerie: Aluno[i].nomeSerie,
                nomeCurso: Aluno[i].nomeCurso,
                nomeTurma:Aluno[i].nomeTurma,
                SiglaTurma: Aluno[i].siglaTurma,
                matricula: Aluno[i].matricula,
                NomeAluno: Aluno[i].NomeAluno,
                StAlunoTurma: Aluno[i].StAlunoTurma
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

        let matricula = req.params.matricula;        
        let Aluno = await BancoServices.dadosAlunos(matricula);

        if(Aluno){
            json.result = Aluno;
        }
        res.json(json);
    }
}