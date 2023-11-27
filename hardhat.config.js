require("@nomicfoundation/hardhat-toolbox");
require("@chainlink/hardhat-chainlink");
require('@nomiclabs/hardhat-ethers');
require('@openzeppelin/hardhat-upgrades');
require("hardhat-gas-reporter");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.5",
  gasReporter: {
    currency: 'USD',
    coinmarketcap: "63af818f-3b11-41fa-863e-9cdcb8f802c5",
    enabled: true
  },
  networks: {
    hardhat: {
    },
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/lHEdNR1dNspvH7EDFrpl9GhkMlwScfSM",
      accounts: ["05a3820e22b57c2e245a92bd0d1eed4d00d57d7c26efe95fbe313c169f8eb186"]
    },
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/WxL_VjZM52isZK8RWOm1XzIsPhucXqtz",
      accounts: ["a3074e75468c6755acb0e3c4e351ffbdd215256bf129cb2ca6f5b59adcbb440d"]
    },
    polygon: {
      url: "https://polygon-mainnet.g.alchemy.com/v2/xWBHlXuWY_ewkbKVf5c36R6H8t9dQPaL",
      accounts: ["a3074e75468c6755acb0e3c4e351ffbdd215256bf129cb2ca6f5b59adcbb440d"]
    }
  }
};
