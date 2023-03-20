/**
 *Submitted for verification at BscScan.com on 2023-03-16
*/

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

/*  You found a treasure chest!!
                            ____...------------...____
                        _.-"/o/__ ____ __ _______\o\`"-._
                    .'     / /                    \ \   '.
                    |=====/o/======================\o\===|
                    |____/_/________..____..________\_\__|
                    /   _/ \_     <_o#\__/#o_>     _/ \_ \
                    \________________\####/______________/
                    |===\!/========================\!/===|
                    |   |=|          .---.         |=|   |
                    |===|o|=========/     \========|o|===|
                    |   | |         \() ()/        | |   |
                    |===|o|======{'-.) A (.-'}=====|o|===|
                    | __/ \__     '-.\uuu/.-'    __/ \__ |
                    |==============.'.'^'.'.=============|
                    |  _\o/   __  {.' __  '.} _   _\o/  _|
                    `""""-""""""""""""""""""""""""""-""""`
*/

contract Treasure {

    uint8 private position;
    bytes32 private lock; //not secure. Don't do this in production.

    mapping(uint8 => address ) public leaderBoard;
    mapping(address => string) public userNames; 
    mapping(address => bool) private failsafeOff;

    constructor(bytes32 _lock) {
        lock = _lock;
    }

    event TreasureTaken(address);
    event TreasureWasStolen(address,bool);

    error needsKey();
    error failSafeIsOn();
    error noCrystalFound();
    error AddressNotRegistered();

    address immutable NULL = address(0);

    ///-------------------------------------------------------------------------------------///
    ///                                @notice - Register First!                            ///
    ///                                                                                     ///
    ///-------------------------------------------------------------------------------------///
    function register(string calldata name) external {
        userNames[msg.sender] = name;
    }


    ///-------------------------------------------------------------------------------------///
    ///   @notice - There seems to be a lock on the treasure chest. You need a key to open  ///
    ///   the chest. Maybe whoever left this __                                             ///
    ///   treasure also has the key?        /o \_____                                       ///
    ///                                     \__/-="="`                                      ///
    ///                                                     ///
    ///                                                                                     ///
    ///-------------------------------------------------------------------------------------///
    



    function claimTreasure(string calldata key) external {
        address sender = msg.sender;
        if (bytes(userNames[sender]).length == 0) { revert AddressNotRegistered(); }
        if (keccak256(abi.encodePacked(key)) != lock) { revert needsKey(); }
        if (!failsafeOff[sender]) { revert failSafeIsOn(); }

        ++position;
        leaderBoard[position] = sender;

        if(position == 1) {
            emit TreasureTaken(sender);
        } 
    }


    ///-------------------------------------------------------------------------------------///
    ///   @notice - You try to unlock the chest but it seems that someone rigged the chest  ///
    ///   with some kind of failsafe                                                        ///
    /*
    
                                                    ______________
                                    __,.,---'''''              '''''---..._
                                ,-'             .....:::''::.:            '`-.
                                '           ...:::.....       '
                                            ''':::'''''       .               ,
                                |'-.._           ''''':::..::':          __,,-
                                '-.._''`---.....______________.....---''__,,-
                                    ''`---.....______________.....---''
    */                                                           
    ///-------------------------------------------------------------------------------------///


    receive() external payable {
        failsafeOff[msg.sender] = true;
        payable(msg.sender).transfer(msg.value);
    }

    fallback() external {
        address sender = msg.sender;
        if (bytes(userNames[msg.sender]).length == 0) { revert AddressNotRegistered(); }
        if (leaderBoard[0] == NULL) {
            leaderBoard[0] = sender;
            emit TreasureWasStolen(sender, sender != leaderBoard[0]);
        } else {
            revert noCrystalFound();
        }
    }
}

/*

                        .=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-.
                        |                     ______                     |
                        |                  .-"      "-.                  |
                        |                 /            \                 |
                        |     _          |              |          _     |
                        |    ( \         |,  .-.  .-.  ,|         / )    |
                        |     > "=._     | )(__/  \__)( |     _.=" <     |
                        |    (_/"=._"=._ |/     /\     \| _.="_.="\_)    |
                        |           "=._"(_     ^^     _)"_.="           |
                        |               "=\__|IIIIII|__/="               |
                        |              _.="| \IIIIII/ |"=._              |
                        |    _     _.="_.="\          /"=._"=._     _    |
                        |   ( \_.="_.="     `--------`     "=._"=._/ )   |
                        |    > _.="                            "=._ <    |
                        |   (_/                                    \_)   |
                        |                                                |
                        '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='

*/