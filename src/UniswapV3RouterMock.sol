// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./EthToUsdcConverter.sol";

contract UniswapV3RouterMock is IUniswapV3SwapRouter {
    address public override WETH9;

    constructor(address _weth) {
        WETH9 = _weth;
    }

    function exactInputSingle(exactInputSingleParams calldata params)
        external
        payable
        override
        returns (uint256 amountOut)
    {
        // テスト用の簡単なロジックを実装
        // 例: 単純に入力されたETHの量をそのまま出力として返す
        return params.amountIn;
    }
}
