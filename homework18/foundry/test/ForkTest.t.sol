// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@pancakeswap/Interfaces/IPancakeRouter02.sol";
import "@pancakeswap/Interfaces/IPancakeFactory.sol";
import "@pancakeswap/Interfaces/IERC20.sol";
import "@pancakeswap/Interfaces/IPancakePair.sol";
import "../src/PancakeSwapUtil.sol";


contract ForkTest is Test {
  uint256 bnbFork;
  string BNB_RPC_URL = vm.envString("BNB_MAINNET_URL");
  address alice;
  address bob;
  IPancakeRouter02 pancakeSwapRouter;
  IERC20 BUSD;
  IERC20 WBNB;
  PancakeSwapUtil util;

  function setUp() public {
    bnbFork = vm.createFork(BNB_RPC_URL, 27802233);
    alice = address(1);
    bob = address(0xF977814e90dA44bFA03b6295A0616a897441aceC); // WBNB token holder
    pancakeSwapRouter = IPancakeRouter02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    BUSD = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
    WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
  }

  function testChain() public {
    // each test needs select fork else chainid gets reset to local or --fork-url network
    vm.selectFork(bnbFork);
    // foundry you can log with console.log() or emit log_uint();
    //emit log_uint(block.number); 
    //console.log(block.chainid);
    assertEq(block.chainid, 56);
  }

  function testPancakeSwap() public {
    vm.selectFork(bnbFork);
    //console.log(pancakeSwapRouter.factory());
    assertEq(pancakeSwapRouter.factory(), address(0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73));
  }

  function testPairStats() public {
    vm.selectFork(bnbFork);
    IPancakeFactory factory = IPancakeFactory(pancakeSwapRouter.factory());
    IPancakePair pair = IPancakePair(factory.getPair(address(BUSD), address(WBNB)));
    assertEq(address(pair), address(0x58F876857a02D6762E0101bb5C46A8c1ED44Dc16));
    //(uint112 r0, uint112 r1, uint32 time) = pair.getReserves();
    //console.log("r0 = %s, r1 = %s, time = %s ", r0, r1, time);
  }

  function testSwap() public {
    vm.selectFork(bnbFork);
    vm.prank(bob);
    WBNB.approve(address(pancakeSwapRouter), 1e18);
    address[] memory path = new address[](2);
    path[0] = address(WBNB);
    path[1] = address(BUSD);
    vm.prank(bob);
    pancakeSwapRouter.swapExactTokensForTokens(
      1e18,
      2e10,
      path,
      address(bob),
      block.timestamp+11
    );
  }

  function testUtilContract() public {
    vm.selectFork(bnbFork);
    util = new PancakeSwapUtil();
    IPancakeRouter02 router = util.getRouter();
    console.log(address(router));
  }

  function testLargeSwap() public {
    vm.selectFork(bnbFork);
    util = new PancakeSwapUtil();
    util.approveERC20ToRouter(address(WBNB));
    uint256 amount = 1000e18;
    vm.prank(bob);
    WBNB.approve(address(util), amount);
    vm.prank(bob);
    util.SwapBnbBusd(amount, address(bob));
  }

  function testLargeSplitSwap() public {
    vm.selectFork(bnbFork);
    util = new PancakeSwapUtil();
    util.approveERC20ToRouter(address(WBNB));
    uint256 amount = 1000e18;
    vm.prank(bob);
    WBNB.approve(address(util), amount);
    vm.prank(bob);
    util.SwapBnbBusdSplit(amount, address(bob), 2);
  }

}