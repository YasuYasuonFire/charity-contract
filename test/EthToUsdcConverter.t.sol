// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/EthToUsdcConverter.sol";
import "../src/WETHMock.sol";
import "../src/USDCMock.sol";
import "../src/UniswapV3RouterMock.sol";

contract EthToUsdcConverterTest is Test {
    EthToUsdcConverter public converter;
    UniswapV3RouterMock public uniswapRouterMock;
    address account1 = address(1);
    address account2 = address(2);
   
    function setUp() public {
        // WETHモックのデプロイ
        address wethMock = address(new WETHMock());
        // Uniswap V3ルーターモックのデプロイ
        uniswapRouterMock = new UniswapV3RouterMock(wethMock);
        // USDCモックのデプロイ
        USDCMock usdcMock = new USDCMock();

        // EthToUsdcConverterコントラクトに、モックのアドレスを渡して初期化
        converter = new EthToUsdcConverter(address(uniswapRouterMock), address(usdcMock));
        // アカウント1に100ETHを提供
        vm.deal(account1, 100 ether);
    }
    function testConvertEthToUsdcAndSendWithZeroValue() public {
        // アカウント1を呼び出し元として設定
        vm.prank(account1);

        // convertEthToUsdcAndSendをvalue 0で呼び出し、エラーが発生することを検証
        vm.expectRevert("Must send ETH");
        converter.convertEthToUsdcAndSend{value: 0}(account1);
    }

    function testConvertEthToUsdcAndSend() public {
        // アカウント1からアカウント2への1ETH送信をシミュレート
        vm.startPrank(account1);
        converter.convertEthToUsdcAndSend{value: 1 ether}(account2);
        vm.stopPrank();

        //log
        console.log("balance of account1: ", address(account1).balance);
        console.log("balance of ETH in Converter: ", address(converter).balance);
        console.log("balance of ETH in uniswapRouterMock: ", address(uniswapRouterMock).balance);

        // コントラクトのETH残高を検証
        assertEq(address(converter).balance, 0 ether, "balance of contract is not right");
        assertEq(address(uniswapRouterMock).balance, 1 ether, "balance of contract is not right");
   }
}
