require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    bscTestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      accounts: ["502c08e589a00027d48b05e2218e2e3efaa632d9c535eba8efe915b4f1d34f7b", "e0cdefaf6b32b1d2453a411e13b07c5320538225831749cb33b57b259096bbe1"],
    },
    // Aggiungi altre configurazioni di rete se necessario
  },
  // Resto della tua configurazione Hardhat

  solidity: "0.8.18",
};
