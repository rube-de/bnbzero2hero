const { ethers, upgrades } = require('hardhat');
const { expect } = require("chai");

describe('UpgradeMe', function () {
  let upgradeMe;
  it('deploys', async function () {
    const UpgradeMe = await ethers.getContractFactory('UpgradeMe');
    upgradeMe = await upgrades.deployProxy(UpgradeMe, { kind: 'uups' });
  });
  it('upgrades to v2', async () => {
    const UpgradeMeV2 = await ethers.getContractFactory('UpgradeMeV2');
    let upgradeMeV2 = await upgrades.upgradeProxy(upgradeMe, UpgradeMeV2);
    console.log(await upgradeMeV2.nextPayout());
    console.log(await upgradeMeV2.initialBlock());
    expect(upgradeMe.address).to.be.equal(upgradeMeV2.address);

  })
});