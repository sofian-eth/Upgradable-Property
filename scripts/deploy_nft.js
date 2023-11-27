const { ethers } = require("hardhat");

async function main() {
  const name = 'Test NFT';
  const symbol = 'TNFT';
  const address = '0x0A1476833F30f0ACae82e63Fb86CC3a669A5B799';
  const webaddress = 'www.nft.com/';

  const Nft = await ethers.getContractFactory("NFT");
  const nft = await Nft.deploy(name, symbol, address, webaddress, {
    gasPrice: ethers.utils.parseUnits("50", "gwei"),
  });

  await nft.deployed();

  console.log("NFT deployed to:", nft.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
