const bancoServices = require('../services/bancoServices');

//Implementação do retorno json

module.exports = {
    buscarAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let Aluno = await BancoServices.buscarAlunos();

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
    // ajustar dados alunos para receber parametro para quando
    // DadosPessoais for acessada retornar os dados
    dadosAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let matricula = req.params.matricula;
        let Aluno = await bancoServices.dadosAlunos(matricula);

        for(let i in Aluno){
            json.result.push({
                label: "Nome do aluno",
                value: Aluno[i].NomeAluno
            },
            {
                label: "CPF",
                value: Aluno[i].cpf
            },
            {
                label: "RG",
                value: Aluno[i].rg
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
    },
    loginAluno: async(req, res)=>{     

        const cpf = req.body.cpf;
        const senha  =req.body.senha;        
        let Aluno = await bancoServices.loginAluno(cpf,senha);

        if(Aluno){
            res.send(senha);
            console.log(cpf,senha);
        }
        res.send(senha);
    } 
}