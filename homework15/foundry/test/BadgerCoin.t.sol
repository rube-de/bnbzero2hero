// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BadgerCoin.sol";

contract BadgerCoinTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    BadgerCoin public  badgercoin;
    uint256 private _totalSupply = 1000000;
    function setUp() public {
        badgercoin = new BadgerCoin();
        _totalSupply = 1000000 * 10 ** badgercoin.decimals();
       //emit log_named_address("deployer", address(this));
    }

    function testInitialSupply() public {
      assertEq( badgercoin.totalSupply(), _totalSupply);
    }

    function testBalanceOf() public {
      assertEq( badgercoin.balanceOf(address(this)), _totalSupply);
    }

    function testTransfer(uint256 transferAmount) public {
      transferAmount = bound(transferAmount, 1, _totalSupply);
      assertEq( badgercoin.balanceOf(address( badgercoin)), 0);
       badgercoin.transfer(address( badgercoin), transferAmount);
      assertEq( badgercoin.balanceOf(address( badgercoin)), transferAmount);
    }

    function testFailInsufficientBalance(uint96 tranfserAmount) public {
      vm.assume(tranfserAmount > 0);
      vm.prank(address(1));
       badgercoin.transfer(address( badgercoin), tranfserAmount);
    }

    function testEventOnTransfer() public {
      // enable event emit check
      vm.expectEmit(true, true, false, true);
      // define expect
      emit Transfer(address(this),address(1), 1);
      // call function with event
       badgercoin.transfer(address(1), 1);
    }
}
