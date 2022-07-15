// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require("hardhat");

async function main() {
    const Token = await ethers.getContractFactory("LirnV1");
    console.log("Deploying LirnV1...");
    const token = await upgrades.deployProxy(Token, {
        initializer: "initialize",
    });
    await token.deployed();
    console.log("Token deployed to:", token.address);
}

main();
