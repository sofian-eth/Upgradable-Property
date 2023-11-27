const { ethers } = require("ethers");
const LINK_ABI = require("./ProjectABI.json");
const secp = require("ethereum-cryptography/secp256k1");
const { toHex } = require("ethereum-cryptography/utils");
const { keccak256 } = require("ethereum-cryptography/keccak");

const provider = new ethers.providers.JsonRpcProvider("https://polygon-mainnet.g.alchemy.com/v2/xWBHlXuWY_ewkbKVf5c36R6H8t9dQPaL");

const account1 = '0xccC77bCff7f2a1f426815d01202D20Dc2b65C835';
const account2 = '0x85eA5EF1E9e8E5666bb34868c77d7F8Baa3F0E2c';
const account3 = '0xCA0AeCC2B1bB5Dbffb43726d7487b4042bE1823F';

const privatekey1 = '05a3820e22b57c2e245a92bd0d1eed4d00d57d7c26efe95fbe313c169f8eb186';

const ProjectAddress = '0x6B3Cde0f26aBA42755Ca865f6f4235Ca73C14CF0';

const wallet = new ethers.Wallet(privatekey1,provider);

const contract = new ethers.Contract(ProjectAddress, LINK_ABI, provider);

const main = async () => {

    const gasPriceFetch = await provider.getGasPrice();
    console.log(gasPriceFetch.toString());

    const balance = await contract.balanceOf(account1);

    console.log(`${ethers.utils.formatUnits(balance,4)}`);
    
    // const connectedWallet = contract.connect(wallet);

    // const tx = await connectedWallet.addAdmin(account3, {gasPrice: gasPriceFetch});

    // await tx.wait();
    // console.log(tx);
    console.log("success!");
}

main();