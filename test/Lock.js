const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Lock contract", function () {
  let Lock;
  let lock;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    Lock = await ethers.getContractFactory("Lock");
    [owner, addr1, addr2] = await ethers.getSigners();

    lock = await Lock.deploy("MyLock", "LOCK", 1000000);
    await lock.deployed();
  });

  it("Should deploy the contract correctly", async function () {
    expect(await lock.name()).to.equal("MyLock");
    expect(await lock.symbol()).to.equal("LOCK");
    expect(await lock.totalSupply()).to.equal(1000000);
    expect(await lock.balanceOf(owner.address)).to.equal(1000000);
  });

  it("Should transfer tokens correctly", async function () {
    await lock.transfer(addr1.address, 1000);
    expect(await lock.balanceOf(addr1.address)).to.equal(1000);

    await lock.connect(addr1).transfer(addr2.address, 500);
    expect(await lock.balanceOf(addr2.address)).to.equal(500);
  });

  it("Should burn tokens correctly", async function () {
    const initialSupply = await lock.totalSupply();
    const initialBalance = await lock.balanceOf(owner.address);

    const amountToBurn = 1000;
    await lock.burn(amountToBurn);

    const newSupply = await lock.totalSupply();
    const newBalance = await lock.balanceOf(owner.address);

    expect(newSupply).to.equal(initialSupply.sub(amountToBurn));
    expect(newBalance).to.equal(initialBalance.sub(amountToBurn));
  });

  it("Should allow token allowance correctly", async function () {
    const amountToApprove = 500;
    await lock.approve(addr1.address, amountToApprove);

    const allowance = await lock.allowance(owner.address, addr1.address);
    expect(allowance).to.equal(amountToApprove);
  });

  it("Should transferFrom tokens correctly", async function () {
    const amountToApprove = 500;
    await lock.approve(addr1.address, amountToApprove);
  
    const amountToTransfer = 300;
    await lock.connect(addr1).transferFrom(owner.address, addr2.address, amountToTransfer);
  
    const balanceOwner = await lock.balanceOf(owner.address);
    const balanceAddr2 = await lock.balanceOf(addr2.address);
    const allowance = await lock.allowance(owner.address, addr1.address);
  
    expect(balanceOwner).to.equal(1000000 - amountToTransfer); // Aggiunto il calcolo corretto
    expect(balanceAddr2).to.equal(amountToTransfer);
    expect(allowance).to.equal(amountToApprove - amountToTransfer); // Aggiunto il calcolo corretto
  });
  
  it("Should renounce ownership correctly", async function () {
    await expect(lock.renounceOwnership())
      .to.emit(lock, "OwnershipTransferred")
      .withArgs(owner.address, "0x0000000000000000000000000000000000000000");
  });
  

  it("Should set burn percentage correctly", async function () {
    const percentage = 50;
    await lock.setBurnPercentage(percentage);

    const burnPercentage = await lock.getBurnPercentage();
    expect(burnPercentage).to.equal(percentage);
  });
});
