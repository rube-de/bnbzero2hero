// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@pancakeswap/Interfaces/IPancakeRouter02.sol";
import "@pancakeswap/Interfaces/IPancakeFactory.sol";
import "@pancakeswap/Interfaces/IERC20.sol";
import "@pancakeswap/Interfaces/IPancakePair.sol";
contract PancakeSwapUtil {
  IERC20 constant BUSD = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
  IERC20 constant  WBNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
  IPancakeRouter02 constant pancakeSwapRouter = IPancakeRouter02(0x10ED43C718714eb63d5aA57B78B54704E256024E);

  function getRouter() external pure returns (IPancakeRouter02) {
    return pancakeSwapRouter;
  }

  function approveERC20ToRouter(address erc20In) external {
      IERC20(erc20In).approve(address(pancakeSwapRouter), 0x8000000000000000000000000000000000000000000000000000000000000000);
  }
  function SwapBnbBusd(uint256 amount, address to) external {
    IERC20(WBNB).transferFrom(msg.sender, address(this), amount);
    address[] memory path = new address[](2);
    path[0] = address(WBNB);
    path[1] = address(BUSD);
    pancakeSwapRouter.swapExactTokensForTokens(
      amount,
      2e10,
      path,
      to,
      block.timestamp+11
    );
  }

  function SwapBnbBusdSplit(uint256 amount, address to, uint256 splits) external {
    IERC20(WBNB).transferFrom(msg.sender, address(this), amount);
    address[] memory path = new address[](2);
    path[0] = address(WBNB);
    path[1] = address(BUSD);
    uint256 splitAmount = amount / splits;
    for (uint i = 0; i < splits; i++) {
      pancakeSwapRouter.swapExactTokensForTokens(
        splitAmount,
        2e10,
        path,
        to,
        block.timestamp+11
      );
    }
  }
}