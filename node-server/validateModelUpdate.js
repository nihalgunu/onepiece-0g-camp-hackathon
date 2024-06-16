const ethers = require('ethers');
const fs = require('fs');

require('dotenv').config();

const evmRpc = 'https://rpc-testnet.0g.ai/';

const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3'

const contractABI = JSON.parse(fs.readFileSync('./contract.abi', 'utf8'));

const provider = new ethers.JsonRpcProvider(evmRpc);

const privateKey = process.env.key; // Your private key 
const signer = new ethers.Wallet(privateKey, provider);

const contract = new ethers.Contract(contractAddress, contractABI, signer);

// Function to call a smart contract function
async function callContractFunction() {
  try {
    const result = await contract.getWeights();
    console.log('Function call result:', result);
  } catch (error) {
    console.error('Error calling contract function:', error);
  }
}

callContractFunction();
