// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    BasicNFT public basicNFT;
    DeployBasicNFT public deployBasicNFT;

    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8";

    function setUp() public {
        deployBasicNFT = new DeployBasicNFT();
        basicNFT = deployBasicNFT.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogic";
        string memory actualName = basicNFT.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(basicNFT.tokenURI(0))) ==
                keccak256(abi.encodePacked(PUG))
        );
    }
}
