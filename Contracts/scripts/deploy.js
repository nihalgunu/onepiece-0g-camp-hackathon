const { ethers } = require("hardhat");

async function main() {
  const ContractABI = await ethers.getContractFactory("DecentralizedLLMModel");
  const LLMContract = await ContractABI.deploy("SAMPLE WEIGHTS: 102938120938012");
  console.log("Contract deployed at:", LLMContract.address);

  const weights1 = await LLMContract.getWeights();
  console.log("weights: ", weights1);

  await LLMContract.updateWeights("New Weights: 213123123123")
  const weights2 = await LLMContract.getWeights()
  console.log("new weights: ", weights2);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
