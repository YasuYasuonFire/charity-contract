// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// OpenZeppelinのERC20実装を使用
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETHMock is ERC20 {
    constructor() ERC20("Mock WETH", "mWETH") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }
}