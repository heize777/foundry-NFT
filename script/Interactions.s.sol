// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { BasicNFT } from "../src/BasicNFT.sol";
import { Script } from "forge-std/Script.sol";
import { DevOpsTools } from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNFT is Script {
    string public constant PUG = "ipfs://QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8";

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTOnContract(mostRecentDeployed);
    }

    function mintNFTOnContract(address nftAddress) public {
        vm.startBroadcast();
        BasicNFT(nftAddress).mintNFT(PUG);
        vm.stopBroadcast();
    }
}