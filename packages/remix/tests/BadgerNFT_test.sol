// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "hardhat/console.sol";
import "../contracts/homework6/BadgerNFT.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

    BadgerNFT badgerNFTToTest;
    address owner;
    address recipient;
    uint256 tokenId;

    /// 'beforeAll' runs before all other tests
    function beforeAll() public {
        // <instantiate contract>
        Assert.equal(uint(1), uint(1), "1 should be equal to 1");
        badgerNFTToTest = new BadgerNFT();
        recipient = TestsAccounts.getAccount(2);
        owner = msg.sender;
    }

    function checkSuccess() public {
        // Use 'Assert' methods: https://remix-ide.readthedocs.io/en/latest/assert_library.html
        Assert.ok(2 == 2, 'should be true');
        Assert.greaterThan(uint(2), uint(1), "2 should be greater than to 1");
        Assert.lesserThan(uint(2), uint(3), "2 should be lesser than to 3");
    }

    function checkSuccess2() public pure returns (bool) {
        // Use the return value (true or false) to test the contract
        return true;
    }
    

    /// Custom Transaction Context: https://remix-ide.readthedocs.io/en/latest/unittesting.html#customization
    /// #sender: account-1
    /// #value: 100
    function checkSenderAndValue() public payable {
        // account index varies 0-9, value is in wei
        Assert.equal(msg.sender, TestsAccounts.getAccount(1), "Invalid sender");
        Assert.equal(msg.value, 100, "Invalid value");
    }

    /// #sender: account-1
    /// #value: 100
    function checkMint() public {
        tokenId = badgerNFTToTest.safeMint(msg.sender);
        Assert.equal(badgerNFTToTest.balanceOf(msg.sender), 1, "account-1 should have balance of 1");
        Assert.equal(badgerNFTToTest.ownerOf(tokenId), msg.sender, "token owner should be account-1");
    }

    
    function checkTransfer() public {
        console.log(msg.sender);
        console.log(owner);
        badgerNFTToTest.approve(address(this), tokenId);
        Assert.equal(badgerNFTToTest.balanceOf(msg.sender), 1, "account-1 should have balance of 1");
        badgerNFTToTest.safeTransferFrom(msg.sender, recipient, tokenId);
        Assert.equal(badgerNFTToTest.balanceOf(msg.sender), 0, "account-1 should have balance of 0");
        Assert.equal(badgerNFTToTest.balanceOf(recipient), 1, "account-2 should have balance of 1");
        Assert.equal(badgerNFTToTest.ownerOf(tokenId), recipient, "token owner should be account-1");
    }
}
    