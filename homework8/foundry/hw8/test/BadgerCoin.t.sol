// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BadgerCoin.sol";

contract BadgerCoinTest is Test {
    //Vm testVM = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));
    BadgerCoin public badgercoin;
    function setUp() public {
       badgercoin = new BadgerCoin();
       //emit log_named_address("deployer", address(this));
    }

    function testInitialSupply() public {
      assertEq(badgercoin.totalSupply(), 1000000 * 10 ** badgercoin.decimals());
    }

    function testDecimals() public {
      assertEq(badgercoin.decimals(), 18);
    }

    function testBalanceOf() public {
      assertEq(badgercoin.balanceOf(address(this)), 1000000 * 10 ** badgercoin.decimals());
    }

    function testTransfer(uint64 transferAmount) public {
      assertEq(badgercoin.balanceOf(address(badgercoin)), 0);
      badgercoin.transfer(address(badgercoin), transferAmount);
      assertEq(badgercoin.balanceOf(address(badgercoin)), transferAmount);
    }

    function testFailInsufficientBalance(uint96 tranfserAmount) public {
      vm.assume(tranfserAmount > 0);
      vm.prank(address(1));
      badgercoin.transfer(address(badgercoin), tranfserAmount);
    }
}
