/**
 *Submitted for verification at BscScan.com on 2023-03-16
*/

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract Camp {

    /*    /     /\
         /     /  \
        /_____/----\_    (  
        "     "          ).  
    _ ___          o (:') o   
    (@))_))        o ~/~~\~ o   
                    o  o  o    */


    address private immutable owner;
    address private hiddenCoordinates;

    constructor() {
        owner = msg.sender;
    }

    function hideCoordinates(address _coordinates) external {
        require(msg.sender == owner, "must be owner");
        hiddenCoordinates = _coordinates;
    }

        function resting() external pure returns (bool){
        return true;
    }
}