// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/EthToUsdcConverter.sol";

//deploy to chain
contract EthToUsdcConverterScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address uniswapSwapRouter = 0x3bFA4769FB09eefC5a80d6E87c3B9C650f7Ae48E; //sepolia
        address usdcAddress = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238; //sepolia

        EthToUsdcConverter converter = new EthToUsdcConverter(uniswapSwapRouter, usdcAddress);

        vm.stopBroadcast();
    }
}
