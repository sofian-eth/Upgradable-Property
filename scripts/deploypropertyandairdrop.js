// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require('hardhat');
const secp = require("ethereum-cryptography/secp256k1");
const { toHex } = require("ethereum-cryptography/utils");
const { keccak256 } = require("ethereum-cryptography/keccak");

async function main () {
    let receipients = [];
    let amount = [];

    for(let i = 0; i < 700; i++) {
        const privateKey = secp.utils.randomPrivateKey();
        const toHexPrivate = toHex(privateKey);
    //console.log('Private Key:', toHex(this.privateKey));

    //const publicKey = keccak256(secp.getPublicKey(privateKey).slice(1).slice(-20));
        const publicKey = keccak256(secp.getPublicKey(privateKey).slice(1)).slice(-20);
    //this.publicKey = secp.getPublicKey(this.privateKey);
        const toHexPublic = toHex(publicKey);

        receipients.push("0x"+toHexPublic);
        amount.push(""+Math.floor(Math.random() * (1000000 - 10000 + 1)));
    }
  const ProjectContract = await ethers.getContractFactory('ProjectContract');
  //const receipients = ["0x5d8f1877fef80133977a0177c3a47deb0cfae71f", "0x9b82efb21f6fa30741743be4873171133082f211","0x1721a76f61dc4fcc7a1ae87952515a79b18e7ee0", "0x1692a951ece3deb35f9c890233d33ab85ae51d7a", "0x1bf2732d26b76cec0c47f82670973d499ed8cf31", "0xccC77bCff7f2a1f426815d01202D20Dc2b65C835","0xfaffa37f56d3b22b6bf1f675123c4cd2b91d9afa","0x0a953aa804a62a7525296dca2a337d599e31a375","0xdcc4ab3f4dd399fa2688eb0f4af6dc0069266a58","0x754318c1d9876a32412024a26b7aca2178a77546","0x2c3eb680f5dbd26d9df3657ed4903eefde9a03e4","0x687dde7f93daa330d93e28d758e7ad3c6e914dc0","0x4bfb0deface6613fdc1ef56b55b2c92eebf75984","0x8cf5b220d4a547384f94bc4c4fab9e0e1366c7b0", "0xaa11b822a6be88a1356c2e5149d7cf86000c9564", "0xa5952fbda8fa18648a1085dc6af5bfc6e086858e","0xfed79bbaf2455cfe0d0d1b8b1c919237f51b7a47"];
  //const amount = ["1700846", "1600846","1500846", "1400846", "1300846", "1200846","1100846","1000846","900846","800846","700846","600846","500846","400846", "300846", "200846","100846"]
  console.log('Deploying ProjectContract...');
  const name = 'Dummy Test ER 3';
  const symbol = 'DTER 3';
  const decimals = '4';
  const supply = '209100';
  const projectContract = await upgrades.deployProxy(ProjectContract, [name, symbol, decimals, supply], { initializer: 'initialize' });
  await projectContract.deployed();
  console.log('ProjectContract deployed to:', projectContract.address);
  console.log("Calling airdrop function...");
  const tx = await projectContract.airdrop(receipients, amount);
  await tx.wait();
  console.log("success!");
}

main();