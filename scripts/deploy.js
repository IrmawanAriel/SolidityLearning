const { ethers } = require("hardhat");

async function main() {
    const FundMe = await ethers.getContractFactory("FundMe");
    const fundMe = await FundMe.deploy();

    await fundMe.waitForDeployment();
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
