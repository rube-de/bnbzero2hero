// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DogCoin.sol";

contract DogCoinTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);
    //Vm testVM = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));
    DogCoin public dogcoin;
    uint256 private _totalSupply = 2000000;
    function setUp() public {
       dogcoin = new DogCoin(address(this));
       emit log_named_address("deployer", address(this));
    }

    function testInitialSupply() public {
      assertEq(dogcoin.totalSupply(), _totalSupply);
    }

    function testBalanceOf() public {
      assertEq(dogcoin.balanceOf(address(this)), _totalSupply);
    }

    function testTransfer(uint256 transferAmount) public {
      transferAmount = bound(transferAmount, 1, _totalSupply);
      assertEq(dogcoin.balanceOf(address(dogcoin)), 0);
      dogcoin.transfer(address(dogcoin), transferAmount);
      assertEq(dogcoin.balanceOf(address(dogcoin)), transferAmount);
    }

    function testFailInsufficientBalance(uint96 tranfserAmount) public {
      vm.assume(tranfserAmount > 0);
      vm.prank(address(1));
      dogcoin.transfer(address(dogcoin), tranfserAmount);
    }

    function testSupplyIncrease() public {
      assertEq(dogcoin.totalSupply(), _totalSupply);
      dogcoin.increaseTotalSupply();
      assertEq(dogcoin.totalSupply(), _totalSupply + 1000);
    }

    function testFailIncreaseFromNotOwner() public {
      vm.prank(address(1));
      dogcoin.increaseTotalSupply();
    }

    function testEventOnTransfer() public {
      // enable event emit check
      vm.expectEmit(true, true, false, true);
      // define expect
      emit Transfer(address(this),address(1), 1);
      // call function with event
      dogcoin.transfer(address(1), 1);
    }
}
