require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.18",
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545",
      accounts: [
        // Use your Ganache private key here without the 0x prefix
        "0x834bf595cabfbcf464761522ff6b988015f26963a03ed2acb00499fe05f07d6d"
      ]
    }
  }
};
