// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract DogCoin {

    // contract variables
    uint256 public totalSupply = 2000000;
    address public owner;

    mapping (address=>uint256) private _balances;

    struct Payment {
        address to;
        uint256 amount;
    }
    mapping (address => Payment[]) private _payments;


    // Events
    event SupplyChanged(uint256 newTotalSupply);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // modifiers
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor(address _owner){
        owner = _owner;
        _balances[owner] = totalSupply;
    }

    /**
    * 
    * @dev only Owner can increase the supply.
    */
    function increaseTotalSupply() public onlyOwner {
        _mint();
    }

    /**
     * @notice increases Supply by 1000, increase in supply goes to the owner
     *  
     */
    function _mint() internal {
        totalSupply += 1000;
        unchecked {
            // if total supply doesn't overflow also balance can't
            _balances[owner] += 1000; 
        }
        emit SupplyChanged(totalSupply);
    }

    /**
    * @param user the user address to get the balance from
    * @return balance of the user address. 
    */
    function balanceOf(address user) public view returns (uint256) {
        return _balances[user];
    }

    /**
    * @param user the user address to get the payments for
    * @return array of payments
    */
    function getPayments(address user) public view returns (Payment[] memory) {
        return _payments[user];
    }

    /**
    * @param to address of the receipient.
    * @param amount the amount to transfer.
    * @return bool true if transfer successful
    */
    function transfer(address to, uint256 amount) public returns (bool) {
        uint256 fromBalance = _balances[msg.sender];
        require(fromBalance >= amount, "transfer amount exceeds balance");
        unchecked {
            _balances[msg.sender] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }
        _payments[msg.sender].push(Payment(to,amount));
        emit Transfer(msg.sender, to, amount);
        return true;
    }
}