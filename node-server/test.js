const zeroGDA = require('zerog-da-sdk');
const ethers = require('ethers');
require('dotenv').config()
const { NHProvider, NHFile, getFlowContract, TESTNET_FLOW_ADDRESS } = zeroGDA;

const upload = () => {
  async function run() {
  const file = await NHFile.fromFilePath('./test.txt');
  const [tree, err] = await file.merkleTree();
  if (err === null) {
    console.log("File Root Hash: ", tree.rootHash());
  }  // how does it have a hash if we havent submitted to flow contract yet? 

  // create ethers signer from private key and rpc endpoint
  const evmRpc = 'https://rpc-testnet.0g.ai/';
  const provider = new ethers.JsonRpcProvider(evmRpc);
  const privateKey = process.env.key; // with balance to pay for gas
  const signer = new ethers.Wallet(privateKey, provider);

  // get flow contract instance
  const flowContract = getFlowContract(TESTNET_FLOW_ADDRESS, signer);

  const tagBytes = '0x';
  const [submission, error] = await file.createSubmission(tagBytes);
  if (error != null) {
      console.log('create submission error: ', error);
      return;
  }
  let tx = await flowContract.submit(submission);
  await tx.wait();
  console.log(tx.hash);

  nhRpc = 'https://rpc-storage-testnet.0g.ai/';
  const nhProvider = new NHProvider(nhRpc);

  await nhProvider.uploadFile(file);
  }
  run();
}

async function download() {
  rootHash = '0x55a5c07da68124b81c9cec5522e6580d65c6555160e59f2d4e82e7471147ef3d';
  txSequence = '0x5485e64d638060cf0a8372217f2bf33f00c419815c7eb4599e4b69a31ead4281';
  // startIndex = 
  // endIndex =
  nhRpc = 'https://rpc-storage-testnet.0g.ai/';
  const nhProvider = new NHProvider(nhRpc);
  try {
    const txSeqNumber = ethers.BigNumber.from(txSequence).toNumber();
    let x = await nhProvider.getFileInfoByTxSeq(txSequence);
    console.log(x);
  } catch (error) {
    console.error('Error:', error);
  }


  // nhProvider.downloadSegment
  
}

download();