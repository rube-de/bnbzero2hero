// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;


import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

/// dummy receiver for testing
contract BadgerERC721Receiver is IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }
}