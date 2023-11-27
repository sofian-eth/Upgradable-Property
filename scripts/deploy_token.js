const hre = require("hardhat");
const { ethers, upgrades } = require("hardhat");

async function main() {
    const initialSupply = ethers.utils.parseEther('1000000');
    const Token = await ethers.getContractFactory("Token");
    const token = await Token.deploy(initialSupply);
    await token.deployed();

    console.log("Token address is: ", token.address);

    console.log("Transferring 20000 tokens to 0xCA0AeCC2B1bB5Dbffb43726d7487b4042bE1823F");

    const value99 = ethers.utils.parseEther("20000");

    await token.transfer("0xCA0AeCC2B1bB5Dbffb43726d7487b4042bE1823F", value99);

    console.log("Success!");

    const amount = await token.balanceOf('0xccC77bCff7f2a1f426815d01202D20Dc2b65C835');
    const amount2 = await token.balanceOf('0xCA0AeCC2B1bB5Dbffb43726d7487b4042bE1823F');

    console.log(`Balance of deployer = ${ethers.utils.formatEther(amount)}`);
    console.log(`Balance of receiver = ${ethers.utils.formatEther(amount2)}`);

}

main();

//0x0A1476833F30f0ACae82e63Fb86CC3a669A5B799