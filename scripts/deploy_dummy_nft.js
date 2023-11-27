const { ethers } = require("hardhat");

async function main() {
    const name = "Dummy NFT";
    const symbol = "DNFT";
    const URI = "www.nft.com/";

    console.log("Deploying contract...");

    const Dummy = await ethers.getContractFactory("DummyNFT");
    const dummy = await Dummy.deploy(name, symbol, URI);

    await dummy.deployed();

    console.log("Contract deployed to: ", dummy.address);

    const tx = await dummy.walletOfOwner("0xccC77bCff7f2a1f426815d01202D20Dc2b65C835");
    
    console.log(`Wallet of owner holds: ${tx}`);
    console.log("Wallet of owner holds: ", tx);
}

main();