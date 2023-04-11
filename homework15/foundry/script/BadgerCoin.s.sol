// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol"; // Import script lib
import "../src/BadgerCoin.sol";

// run with 
// source .env
// forge script script/BadgerCoin.s.sol:BadgerCoinDeployment --rpc-url $GOERLI_RPC_URL --broadcast --verify -vvvv
contract BadgerCoinDeployment is Script {
  function run() public {
    //Load key/unlock wallet. Use with caution if in production
    uint256 deployerPrivateKey = vm.envUint("DEPLOY_KEY");
    vm.startBroadcast(deployerPrivateKey);
    //Deploy contracts
    //BadgerCoin badgercoin = new BadgerCoin();

    vm.stopBroadcast();
  } 
}