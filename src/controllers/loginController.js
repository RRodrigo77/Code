// const dbEscola = require('../dbEscola');

// module.exports = {
//     loginAluno: async(req, res) => {
        
//         const cpf = req.body.cpf;
//         const senha = req.body.senha;

//         dbEscola.query("SELECT * FROM TbUsuario WHERE cpf = '10394343476'", [cpf, senha], (error, result) => {
//             if(error){
//                 res.send(error);
//                 console.log(cpf,senha);
//             }
//             if(result.lenght > 0){
//                 res.send({msg: "Usuário logado com sucesso"});
//             }else{
//                 res.send({msg: "Usuário não encontrado"});
//             }

//         });

        
//     }
// }
