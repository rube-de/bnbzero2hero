// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract RubeToken is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    constructor() ERC20("Rube Token", "Rube") ERC20Permit("Rube Token") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function faucet() external {
        _mint(msg.sender, 10**decimals());
    }
}