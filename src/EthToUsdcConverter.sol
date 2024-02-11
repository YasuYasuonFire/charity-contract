// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IUniswapV3SwapRouter {
    function exactInputSingle(
        exactInputSingleParams calldata params
    ) external payable returns (uint256 amountOut);

    function WETH9() external view returns (address);
}

struct exactInputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
    uint160 sqrtPriceLimitX96;
}

contract EthToUsdcConverter {
    IUniswapV3SwapRouter public uniswapRouter;
    address private usdcAddress;
    uint24 private constant fee = 3000; // Uniswap V3のフィーレベル、例: 0.3%の場合は3000

    // Uniswap RouterアドレスとUSDCトークンのアドレスをコンストラクタで設定
    constructor(address _uniswapRouter, address _usdcAddress) {
        uniswapRouter = IUniswapV3SwapRouter(_uniswapRouter);
        usdcAddress = _usdcAddress;
    }

    // ETHを受け取り、USDCに変換して指定されたアドレスに送信する関数
    function convertEthToUsdcAndSend(address recipient) external payable {
        require(msg.value > 0, "Must send ETH");

        exactInputSingleParams memory params = exactInputSingleParams({
            tokenIn: uniswapRouter.WETH9(),
            tokenOut: usdcAddress,
            fee: fee,
            recipient: recipient,
            deadline: block.timestamp + 300, // トランザクションの有効期限
            amountIn: msg.value,
            amountOutMinimum: 0, // 本番環境での使用では、スリッページを考慮した適切な値に設定してください。
            sqrtPriceLimitX96: 0
        });

        uniswapRouter.exactInputSingle{value: msg.value}(params);
    }

    // コントラクトのETH残高を取得する関数
    function getContractEthBalance() public view returns (uint) {
        return address(this).balance;
    }
}
