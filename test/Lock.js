// const { expect } = require("chai");
// const { ethers } = require("hardhat");

// describe("ProjectContract", function () {
//   let projectContract;
//   let timelockContract;

//   beforeEach(async function () {
//     const ProjectContract = await ethers.getContractFactory("ProjectContract");
//     projectContract = await ProjectContract.deploy(1000000, "My Token", "MYT", 18);
//     await projectContract.deployed();

//     //timelockContract = await ethers.getContractFactory("ProjectTimeLock");
//     //await timelockContract.deployed();
//   });

//   it("should set the right owner", async function () {
//     expect(await projectContract.daowallet()).to.equal(await ethers.provider.getSigner(0).getAddress());
//   });

//   it("should return the correct total supply", async function () {
//     expect(await projectContract.totalSupply()).to.equal(1000000000000000000000000);
//   });

//   it("should return the correct balance for the DAO wallet", async function () {
//     expect(await projectContract.balanceOf(await projectContract.daowallet())).to.equal(1000000000000000000000000);
//   });

//   it("should allow transfer of tokens", async function () {
//     const [sender, receiver] = await ethers.getSigners();
//     await projectContract.transfer(receiver.getAddress(), 1000);
//     expect(await projectContract.balanceOf(sender.getAddress())).to.equal(999000);
//     expect(await projectContract.balanceOf(receiver.getAddress())).to.equal(1000);
//   });

//   it("should allow locking and unlocking of tokens", async function () {
//     const [sender] = await ethers.getSigners();
//     await projectContract.developmentRounds("round1", 1000, Math.floor(Date.now() / 1000) + 60, Math.floor(Date.now() / 1000) + 120);
//     expect(await projectContract.balanceOf(sender.getAddress())).to.equal(999000);
//     expect(await projectContract.getvestingdetails("round1")).to.eql([1000, Math.floor(Date.now() / 1000) + 60, Math.floor(Date.now() / 1000) + 120, await timelockContract.address]);
//     await ethers.provider.send("evm_increaseTime", [61]);
//     await ethers.provider.send("evm_mine", []);
//     await projectContract.releasefunds("round1");
//     expect(await projectContract.balanceOf(sender.getAddress())).to.equal(1000000);
//     expect(await projectContract.balanceOf(await timelockContract.address)).to.equal(0);
//   });
// });

// import necessary hardhat plugins
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ProjectContract", function () {
  let projectContract;
  let owner;
  let admin1;
  let admin2;
  let investor1;
  let investor2;

  beforeEach(async function () {
    // deploy the contract
    [owner, admin1, admin2, investor1, investor2] = await ethers.getSigners();
    const ProjectContract = await ethers.getContractFactory("ProjectContract");
    projectContract = await ProjectContract.deploy();

    // initialize the contract
    await projectContract.initialize();
  });

  describe("initialization", function () {
    it("should initialize the total area to 10,000,000", async function () {
      expect(await projectContract.totalarea()).to.equal(10000000000000000000000000);
    });
  })
})