const bancoServices = require('../services/bancoServices');
const crypto = require('crypto');

//Controlador

module.exports = {
    buscarAlunos: async(res) => {
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

    buscarAlunoPorNome: async(req, res) =>{ 
        let json = {error:'', result:[]};

        let nome = req.params.nome;        
        let Aluno = await bancoServices.buscarAlunoPorNome(nome);

        if(Aluno){
            json.result = Aluno;
        }
        res.json(json);
    },
    
    dadosAlunos: async(req, res) => {
        let json = {error:'', result:[]};

        let cpf = req.params.cpf;
        let Aluno = await bancoServices.dadosAlunos(cpf); // Recebe CPF por parâmetro

        for(let i in Aluno){
            json.result.push(
            {
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
                label: "Data de nascimento",
                value: Aluno[i].data_nascimento
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
    
    dadosResponsavel: async(req, res) => {
        let json = {error:'', result:[]};

        let cpf = req.params.cpf;
        let resp = await bancoServices.dadosResponsavel(cpf);

        for(let i in resp){
            json.result.push(
            {
                label: "Nome do Responsável",
                value: resp[i].NomeR
            },
            {
                label: "CPF",
                value: resp[i].cpf
            },
            {
                label: "RG",
                value: resp[i].rg
            },
            {
                label: "Data de nascimento",
                value: resp[i].data_nascimento
            },
            {
                label: "Sexo",
                value: resp[i].sexo
            },
            {
                label: "Telefone 1",
                value: resp[i].telefone
            },
            {
                label: "Telefone 2",
                value: resp[i].telefone_2 ? resp[i].telefone_2 : '-'
            },
            {
                label: "Email",
                value: resp[i].email ? resp[i].email : '-'
            });
        }
        res.json(json);
    },

    insertAluno: async (req, res) => {
      try {
        const { nome, cpf, rg, data_nascimento, email, telefone, sexo, senha } = req.body;
    
        await bancoServices.insertAluno(nome, cpf, rg, data_nascimento, email, telefone, sexo, senha);
    
        res.send({ msg: "Aluno cadastrado com sucesso" });
      } catch (error) {
        console.error(error);
        res.status(500).send({ msg: "Erro interno do servidor" });
      }
    },
    

    updateAluno: async(req,res) => {
        const { nome, cpf, rg, data_nascimento, email, telefone } = req.body;

        const upAluno = await bancoServices.updateAluno(nome, cpf, rg, data_nascimento, email, telefone, cpf);

        if(upAluno){
            res.send({msg: "dados atualizados com sucesso"})
        }else{
            res.send({msg: "Erro"})
        }
        
    },

    login: async (req, res) => {
      try {
        const { cpf, senha, userType } = req.body;
        
        const senhaHash = crypto.createHash("sha256").update(senha).digest("hex");
    
        const result = await bancoServices.login(cpf, userType);
    
        if (result.length > 0) {
          if (result[0].senha === senhaHash) {
            res.send({ msg: "Usuário logado com sucesso" });
          } else {
            res.send({ msg: "Senha incorreta" });
          }
        } else {
          res.send({ msg: "Credenciais inválidas" });
        }
      } catch (error) {
        console.error(error);
        res.status(500).send({ msg: "Ocorreu um erro ao fazer login" });
      }
    }    
}