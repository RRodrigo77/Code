const BancoServices = require('../services/bancoServices');

//Implementação do retorno json

module.exports = {
    buscarAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let Aluno = await BancoServices.buscarAlunos();

        // json.result.push({
        //     NomePeriodo: Aluno[i].NomePeriodo,    
        //     NomeSerie: Aluno[i].NomeSerie,
        //     NomeCurso: Aluno[i].NomeCurso,
        //     NomeTurma:Aluno[i].NomeTurma,
        //     SiglaTurma: Aluno[i].SiglaTurma,
        //     Matricula: Aluno[i].Matricula,
        //     NomeAluno: Aluno[i].NomeAluno,
        //     StAlunoTurma: Aluno[i].StAlunoTurma
        // });

        for(let i in Aluno){
            json.result.push(
            {
                label: "Nome:", value: Aluno[i].NomeAluno
            },
            {
                label: "Matricula:", value: Aluno[i].Matricula
            }, 
            {
                label: "Situação:", value: Aluno[i].StAlunoTurma
            },
            {
                label: "Período Letivo:", value: Aluno[i].NomePeriodo
            },
            {
                label: "Série:", value: Aluno[i].NomeSerie
            },
            {
                label: "Curso:", value: Aluno[i].NomeCurso
            },
            {
                label: "Turma:", value: Aluno[i].NomeTurma
            },          
            
            );
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