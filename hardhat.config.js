require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    development: {
      url: "http://127.0.0.1:7545", // URL de Ganache
      // Si vous utilisez des comptes spécifiques, vous pouvez ajouter une clé privée ici
     
    },
  },
};

