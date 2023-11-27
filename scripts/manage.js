const { ethers } = require("ethers");
const LINK_ABI = require("./ABI.json");

const provider = new ethers.providers.JsonRpcProvider('https://eth-goerli.g.alchemy.com/v2/lHEdNR1dNspvH7EDFrpl9GhkMlwScfSM');

const account1 = '0xccC77bCff7f2a1f426815d01202D20Dc2b65C835';
const account2 = '0xfffeed2615703Ec984005CfBa6AEDDF330F35164';

const privatekey1 = '05a3820e22b57c2e245a92bd0d1eed4d00d57d7c26efe95fbe313c169f8eb186';

const jigenaddress = '0x90a54C1bD82d293ac79fB9da3fc1Cb9203E1721D';

const wallet = new ethers.Wallet(privatekey1,provider);

const contract = new ethers.Contract(jigenaddress, LINK_ABI, provider);

const main = async () => {
    const amount = await contract.balanceOf(account1);
    console.log(`Balance of sender (account 1) ${ethers.utils.formatEther(amount)}`);
    
    const connectedWallet = contract.connect(wallet);

    const tx = await connectedWallet.approve(account2, amount);

    await tx.wait();
    console.log(tx);
}

main();