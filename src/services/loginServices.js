const crypto = require('crypto');
const dbEscola = require('../dbEscola');

module.exports = {  
  loginUsuario: (cpf, senha) => {
    return new Promise((aceito, rejeitado) => {
      
      const senhaHash = crypto.createHash('sha1').update(senha).digest('hex');
      dbEscola.query('SELECT cpf, senha FROM TbUsuario WHERE cpf = ? AND senha = ?', [cpf, senhaHash], (error, results) => {
        if (error) { rejeitado(error); return; }
        if (results.length > [0]) {
          aceito(results);
        } else {
          aceito(false);
        }
      });
    });
  }
};
