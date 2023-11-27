// scripts/upgrade_box.js
const { ethers, upgrades } = require('hardhat');

async function main () {
  const ProjectContractV2 = await ethers.getContractFactory('ProjectContractV2');
  console.log('Upgrading Project Contract...');
  await upgrades.upgradeProxy('0x23605603dF0DBfb5303885B840Fc77cAcEDEdE77', ProjectContractV2);
  console.log('Project upgraded');
}

main();

//0x3b7Cbe7E5bD0FFd1c0ccdF712E3182a16475cc06
//0x40E5F216a03e057927962fE573a1aa5C240D6C1B