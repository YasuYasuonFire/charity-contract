#!/bin/bash

# deploy contract to Sepolia

# load environment value
source .env
# 環境変数 `SEPOLIA_RPC_URL` をチェック
if [ -z "$SEPOLIA_RPC_URL" ]; then
  echo "SEPOLIA_RPC_URL is not set. Please set the SEPOLIA_RPC_URL environment variable."
  exit 1
fi

# EthToUsdcConverterScriptの実行
echo "Deploying EthToUsdcConverterScript..."
forge script script/EthToUsdcConverter.s.sol:EthToUsdcConverterScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv

echo "Deployment completed."
