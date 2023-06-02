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
            json.result.push({
                label: "Nome do aluno",
                value: Aluno[i].NomeAluno
            },
            {
                label: "Telefone",
                value: Aluno[i].telefone
            },
            {
                label: "Email",
                value: Aluno[i].email
            },
            {
                label: "Matrícula",
                value: Aluno[i].matricula
            },
            {
                label: "Turma",
                value: Aluno[i].NomeTurma
            },
            {
                label: "Série",
                value: Aluno[i].NomeSerie
            },
            {
                label: "Responsável",
                value: Aluno[i].NomeResponsavel
            },
            {
                label: "Pai",
                value: Aluno[i].NomePai ? Aluno[i].NomePai : '-'
            },
            {
                label: "Mãe",
                value: Aluno[i].NomeMae ? Aluno[i].NomeMae : '-'
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

        for(let i in Aluno){
            json.result.push({
                label: "Nome do aluno",
                value: Aluno[i].NomeAluno
            },
            {
                label: "Telefone",
                value: Aluno[i].telefone
            },
            {
                label: "Email",
                value: Aluno[i].email ? Aluno[i].email : '-'
            },
            {
                label: "Matrícula",
                value: Aluno[i].matricula
            },
            {
                label: "Turma",
                value: Aluno[i].NomeTurma
            },
            {
                label: "Série",
                value: Aluno[i].NomeSerie
            },
            {
                label: "Responsável",
                value: Aluno[i].NomeResponsavel ? Aluno[i].NomeResponsavel : '-'
            },
            {
                label: "Pai",
                value: Aluno[i].NomePai ? Aluno[i].NomePai : '-'
            },
            {
                label: "Mãe",
                value: Aluno[i].NomeMae ? Aluno[i].NomeMae : '-'
            });
        }
        res.json(json);
    }
}