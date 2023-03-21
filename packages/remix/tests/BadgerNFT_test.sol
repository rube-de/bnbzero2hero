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
import "../contracts/homework6/BadgerERC721Receiver.sol";


// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite is BadgerERC721Receiver{

    BadgerNFT badgerNFTToTest;
    address testOwner;
    address recipient;
    uint256 tokenId;

    /// 'beforeAll' runs before all other tests
    function beforeAll() public {
        badgerNFTToTest = new BadgerNFT();
        recipient = TestsAccounts.getAccount(2);
        testOwner = badgerNFTToTest.owner(); // == address(this) as this test is the msg.sender for deploying the contract
    }

    function checkMint() public {
        /// minting to testowner which is address(this) as transfer will be only be possible from this contract 
        /// (remix doesn't support looping through the original msg.sender
        tokenId = badgerNFTToTest.safeMint(testOwner);
        Assert.equal(badgerNFTToTest.balanceOf(testOwner), 1, "test owner(current contract) should have balance of 1");
        Assert.equal(badgerNFTToTest.ownerOf(tokenId), testOwner, "token owner should be test owner(current contract)");
    }

    function checkTransfer() public {
        Assert.equal(badgerNFTToTest.balanceOf(testOwner), 1, "test owner should have balance of 1");
        badgerNFTToTest.safeTransferFrom(testOwner, recipient, tokenId);
        Assert.equal(badgerNFTToTest.balanceOf(testOwner), 0, "test owner should have balance of 0");
        Assert.equal(badgerNFTToTest.balanceOf(recipient), 1, "account-2 should have balance of 1");
        Assert.equal(badgerNFTToTest.ownerOf(tokenId), recipient, "token owner should be account-2");
    }


}
    