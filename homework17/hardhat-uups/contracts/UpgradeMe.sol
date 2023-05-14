// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

// Open Zeppelin libraries for controlling upgradability and access.
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract UpgradeMe is Initializable, UUPSUpgradeable, OwnableUpgradeable{

    enum PaymentOptions{ Pay, Borrow, Defer, Extra }

    PaymentOptions options;
    PaymentOptions constant defaultChoice = PaymentOptions.Pay;

    mapping(address=>uint256) balance;
    uint256 initialBlock;
    uint256 nextPayout;
    string constant name = "Payout Tool";
    //address immutable owner;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }
    
    function initialize() external initializer {
        //owner = _owner;
        __Ownable_init();
        __UUPSUpgradeable_init();
        initialBlock = block.number;
        nextPayout = initialBlock;
    }

    function processPayment(PaymentOptions  _option, address _to, uint256 _amount) public {
        uint256 surcharge = 10;

        if(_option == PaymentOptions.Extra){
            surcharge = 20;
        }
        if(_to == owner() ) {
             surcharge = 0;
        }
        uint256 transferAmount = _amount + surcharge; 
        require(balance[msg.sender] > transferAmount, "Low Balance"); 
        balance[msg.sender] = balance[msg.sender] - transferAmount;
        balance[_to] = balance[_to] + transferAmount; 
    }

    function _authorizeUpgrade(address newImplementation) internal onlyOwner override {}

}