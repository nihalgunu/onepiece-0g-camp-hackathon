const zeroGDA = require('zerog-da-sdk');
const ethers = require('ethers');
require('dotenv').config();
const { NHProvider, NHFile, getFlowContract, TESTNET_FLOW_ADDRESS } = zeroGDA;

// Function to create a delay
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const upload = () => {
  async function run() {
    const file = await NHFile.fromFilePath('/Users/kabirdoshi/Downloads/Install League of Legends na (1).zip');
    const [tree, err] = await file.merkleTree();
    if (err === null) {
      console.log("File Root Hash: ", tree.rootHash());
    }  // how does it have a hash if we haven't submitted to flow contract yet? 

    // create ethers signer from private key and rpc endpoint
    const evmRpc = 'https://rpc-testnet.0g.ai/';
    const provider = new ethers.JsonRpcProvider(evmRpc);
    const privateKey = process.env.key; // with balance to pay for gas
    const signer = new ethers.Wallet(privateKey, provider);

    // get flow contract instance
    const flowContract = getFlowContract('0xb8F03061969da6Ad38f0a4a9f8a86bE71dA3c8E7', signer);

    const tagBytes = '0x';
    const [submission, error] = await file.createSubmission(tagBytes);
    if (error != null) {
      console.log('create submission error: ', error);
      return;
    }
    let tx = await flowContract.submit(submission);
    await tx.wait();
    console.log(tx.hash);

    const nhRpc = 'https://rpc-storage-testnet.0g.ai/';
    const nhProvider = new NHProvider(nhRpc);

    do {
      await nhProvider.uploadFile(file);
      console.log("File upload attempt, waiting for 3 minutes for next one...");
      await delay(180000);
    } while (true);
  }
  run();
}

async function download() {
  const rootHash = '0xf0a0a65e7f08080108fbc7d20146a711f81fd4fc1c15a78aa9950bfa2c7b66cf';
  const nhRpc = 'https://rpc-storage-testnet.0g.ai/';
  const nhProvider = new NHProvider(nhRpc);
  try {
    let x = await nhProvider.getFileInfo(rootHash);
    console.log(x.tx);
  } catch (error) {
    console.error('Error:', error);
  }
}

upload();
// download();

