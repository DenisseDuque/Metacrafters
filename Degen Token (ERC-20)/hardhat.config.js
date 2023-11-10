require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

  /** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",

  etherscan: {
    apiKey: "ZF12GAZEQNMX6WEQVC3YJ65DSV7Y2TB622",
  },

  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, //Only specify a chainId if we are not forking
      forking: forkingData
    },
    fuji: {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [
        "144549f29490e0b98ef593e84ea2ead44b0c01f562ec9d50cc1673237c8c92f8"
      ]
    },
    mainnet: {
      url: 'https://api.avax.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: [
        "144549f29490e0b98ef593e84ea2ead44b0c01f562ec9d50cc1673237c8c92f8"
      ]
    }
  }
}
