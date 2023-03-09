// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;

    address immutable deployer;

    constructor() {
        deployer = msg.sender;
    }


    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }

    function getDeployer() external view returns (address) {
        return msg.sender == deployer ? address(0x000000000000000000000000000000000000dEaD) : deployer;
    }
}