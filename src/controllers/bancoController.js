const bancoServices = require('../services/bancoServices');
const crypto = require('crypto');

//Controlador

module.exports = {
    buscarAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let Aluno = await bancoServices.buscarAlunos();

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
        let Aluno = await bancoServices.buscarAlunoPorNome(nome);

        if(Aluno){
            json.result = Aluno;
        }
        res.json(json);
    },
    
    dadosAlunos: async(req, res)=>{
        let json = {error:'', result:[]};

        let cpf = req.params.cpf;
        let Aluno = await bancoServices.dadosAlunos(cpf); // Recebe CPF por parâmetro

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
    login: async(req, res)=>{     
        const cpf = req.body.cpf;
        const senha = req.body.senha;
        const userType = req.body.userType;

        const senhaHash = crypto.createHash('sha256').update(senha).digest('hex');    
        
        const result = await bancoServices.login(cpf,userType);

        if (result.length > 0) {
            if(result[0].senha === senhaHash){
              res.send({ msg: "Usuário logado com sucesso" });
            //   console.log("cpf informado:        " + cpf);
            //   console.log("cpf salvo no banco:   " + cpf);
            //   console.log("senha informada:      " + senha);
            //   console.log("senha salva no banco: " + senhaHash);
            }else{
              res.send({ msg: "Senha incorreta" });
            } 
          } else {
            res.send({ msg: "Credenciais inválidas" });
            // console.log("senha informada:      " + senha);
          }      
    } 
}