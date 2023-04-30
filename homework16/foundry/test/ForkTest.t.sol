// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "./../src/IPeripheryImmutableState.sol";

contract ForkTest is Test {
  uint256 bnbFork;
  string BNB_RPC_URL = vm.envString("BNB_MAINNET_URL");
  address alice;
  address bob;
  IPeripheryImmutableState pancakeSwapRouter;

  function setUp() public {
    bnbFork = vm.createFork(BNB_RPC_URL, 27802233);
    alice = address(1);
    bob = address(0xffefE959d8bAEA028b1697ABfc4285028d6CEB10); // LEGO token holder
    pancakeSwapRouter = IPeripheryImmutableState(0x13f4EA83D0bd40E75C8222255bc855a974568Dd4);
  }

  function testChain() public {
    // each test needs select fork else chainid gets reset to local or --fork-url network
    vm.selectFork(bnbFork);
    // foundry you can log with console.log() or emit log_uint();
    emit log_uint(block.number); 
    console.log(block.chainid);
    assertEq(block.chainid, 56);
  }

  function testPancakeSwap() public {
    vm.selectFork(bnbFork);
    console.log(pancakeSwapRouter.factory());
    assertEq(pancakeSwapRouter.factory(), address(0x0BFbCF9fa4f9C56B0F40a671Ad40E0805A091865));
  }
}