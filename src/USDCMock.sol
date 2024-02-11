// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// OpenZeppelinのERC20実装を使用
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDCMock is ERC20 {
    constructor() ERC20("Mock USDC", "mUSDC") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }
}