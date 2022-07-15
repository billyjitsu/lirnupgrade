// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require("hardhat");

const PROXY = "0x0e04079224cb3a42A33929DeC4618c2B275aFF2C"; //TransparentUpgradeableProxy

async function main() {
    const TOKENV3 = await ethers.getContractFactory("LirnV3");
    console.log("Upgrading LirnV3...");
    const token = await upgrades.upgradeProxy(PROXY, TOKENV3);
    console.log("Token upgraded to:", token.address);
}

main();
