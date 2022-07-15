// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require("hardhat");

const PROXY = "0x0e04079224cb3a42A33929DeC4618c2B275aFF2C"; //TransparentUpgradeableProxy

async function main() {
    const TOKENV2 = await ethers.getContractFactory("LirnV2");
    console.log("Upgrading LirnV2...");
    const token = await upgrades.upgradeProxy(PROXY, TOKENV2);
    console.log("Token upgraded to:", token.address);
}

main();
