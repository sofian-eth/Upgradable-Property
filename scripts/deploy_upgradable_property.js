// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require('hardhat');

async function main () {
  const ProjectContract = await ethers.getContractFactory('ProjectContract');
  console.log('Deploying ProjectContract...');
  const name = 'Black Test Token';
  const symbol = 'BTT';
  const decimals = '4';
  const supply = '55000';
  const projectContract = await upgrades.deployProxy(ProjectContract, [name, symbol, decimals, supply], { initializer: 'initialize' });
  await projectContract.deployed();
  console.log('ProjectContract deployed to:', projectContract.address);
}

main();