const bancoServices = require('../services/bancoServices');
const crypto = require('crypto');

//Controlador

module.exports = {
  buscarAlunos: async (res) => {
    try {
      let json = { error: '', result: [] };
      let Aluno = await bancoServices.buscarAlunos();

      for (let i in Aluno) {
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
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao buscar todos os alunos" });
    }
  },

  buscarAlunoPorNome: async (req, res) => {
    try {
      let json = { error: '', result: [] };
      let nome = req.params.nome;
      let Aluno = await bancoServices.buscarAlunoPorNome(nome);

      if (Aluno) {
        json.result = Aluno;
      }

      res.json(json);
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao buscar o aluno por nome" });
    }
  },

  dadosAlunos: async (req, res) => {
    try {
      let json = { error: '', result: [] };
      let cpf = req.params.cpf;
      let Aluno = await bancoServices.dadosAlunos(cpf);

      for (let i in Aluno) {
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
            label: "Sexo",
            value: Aluno[i].sexo
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
            value: Aluno[i].NomeTurma ? Aluno[i].NomeTurma : '-'
          },
          {
            label: "Série",
            value: Aluno[i].NomeSerie ? Aluno[i].NomeSerie : '-'
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
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao buscar os dados do aluno" });
    }
  },

  dadosResponsavel: async (req, res) => {
    try {
      let json = { error: '', result: [] };
      let cpf = req.params.cpf;
      let resp = await bancoServices.dadosResponsavel(cpf);

      for (let i in resp) {
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
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao buscar os dados do responsável" });
    }
  },

  dadosProf: async (req, res) => {
    try {
      let json = { error: '', result: [] };
      let cpf = req.params.cpf;
      let prof = await bancoServices.dadosProf(cpf);

      for (let i in prof) {
        json.result.push(
          {
            label: "Nome do Professor",
            value: prof[i].NomeProfessor
          },
          {
            label: "CPF",
            value: prof[i].cpf
          },
          {
            label: "RG",
            value: prof[i].rg
          },
          {
            label: "Sexo",
            value: prof[i].sexo
          },
          {
            label: "Situação",
            value: prof[i].StAtivo
          },
          {
            label: "Telefone",
            value: prof[i].telefone
          },
          {
            label: "Email",
            value: prof[i].email ? prof[i].email : '-'
          });
      }

      res.json(json);
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao buscar os dados do responsável" });
    }
  },

  insertAluno: async (req, res) => {
    try {
      const { nome, cpf, rg, data_nascimento, email, telefone, sexo, senha } = req.body;

      await bancoServices.insertAluno(nome, cpf, rg, data_nascimento, email, telefone, sexo, senha);

      res.send({ msg: "Aluno cadastrado com sucesso" });
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Erro ao cadastrar aluno" });
    }
  },

  insertResp: async (req, res) => {
    try {
      const { nome, cpf, rg, data_nascimento, email, telefone, sexo, senha } = req.body;

      await bancoServices.insertResp(nome, cpf, rg, data_nascimento, email, telefone, sexo, senha);

      res.send({ msg: "Responsável cadastrado com sucesso" });
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Erro ao cadastrar Responsável" });
    }
  },

  insertProf: async (req, res) => {
    try {
      const { nome, cpf, rg, email, telefone, StAtivo, sexo, senha } = req.body;

      await bancoServices.insertProf(nome, cpf, rg, email, telefone, StAtivo,sexo, senha);
      console.log(nome)
      res.send({ msg: "Professor cadastrado com sucesso" });
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Erro ao cadastrar Professor" });
    }
  },

  insertUsuario: async (req, res) => {
    try {
      const { nome, cpf, rg, cargo, sexo, senha } = req.body;

      await bancoServices.insertUsuario(nome, cpf, rg, cargo, sexo, senha);

      res.send({ msg: "Usuário cadastrado com sucesso" });
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Erro ao cadastrar Usuário" });
    }
  },

  updateProf: async (req, res) => {
    try {
      const { nome, cpf, rg, email, telefone, StAtivo, sexo, senha } = req.body;

      const upProf = await bancoServices.updateProf(nome, cpf, rg, email, telefone, StAtivo, sexo, senha);
      if (upProf) {
        res.send({ msg: "Dados atualizados com sucesso" });
      } else {
        res.send({ msg: "Erro ao atualizar os dados do Professor, cpf informado está diferente do cpf informado anteriormente" });
      }
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao atualizar o aluno" });
    }
  },

  updateAluno: async (req, res) => {
    try {
      const { nome, cpf, rg, data_nascimento, email, telefone } = req.body;

      const upAluno = await bancoServices.updateAluno(nome, cpf, rg, data_nascimento, email, telefone, cpf);
      if (upAluno) {
        res.send({ msg: "Dados atualizados com sucesso" });
      } else {
        res.send({ msg: "Erro ao atualizar os dados do aluno, cpf informado está diferente do cpf informado anteriormente" });
      }
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao atualizar o aluno" });
    }
  },

  updatePesp: async (req, res) => {
    try {
      const { nome, cpf, rg, data_nascimento, email, telefone, telefone_2, sexo, senha } = req.body;

      const upResp = await bancoServices.updatePesp(nome, cpf, rg, data_nascimento, email, telefone, telefone_2, sexo, senha);
      if (upResp) {
        res.send({ msg: "Dados atualizados com sucesso" });
      } else {
        res.send({ msg: "Erro ao atualizar os dados do Responsável, cpf informado está diferente do cpf informado anteriormente" });
      }
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao atualizar o aluno" });
    }
  },

  login: async (req, res) => {
    try {
      const { cpf, password, userType } = req.body;

      const senhaHash = crypto.createHash("sha256").update(password).digest("hex");

      const result = await bancoServices.login(cpf, userType);

      if (result.length > 0) {
        if (result[0].senha === senhaHash) {
          res.send({ msg: "Usuário logado com sucesso" });
          return true;
          // res.send(true);
        } else {
          res.send({ msg: "Senha incorreta" });
          return false;
          // res.send(false);
        }
      } else {
        res.send({ msg: "Credenciais inválidas" });
        return false;
      }
    } catch (error) {
      console.error(error);
      res.status(500).send({ msg: "Ocorreu um erro ao fazer login" });
    }
  }
}