// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Counter} from "../src/Counter.sol";

interface Ichall{
    function submit(bytes32 _submit, string calldata username) external;
    function register() external;
}

contract Attack{
    address target = 0x563DFa5dFe25E6e5EBbc734E1aABDDdf332b1b5a;
    constructor()  {
        
    }

    function attack() public payable {
        Ichall(target).register();
    }
}

contract CounterScript is Script {
    Counter public counter;

    function setUp() public {}

    function run() public {
        address target = 0x5F151DfEA40761022d3Da8deF8CA7724413c4e4C;

        vm.startBroadcast();

        Attack zz = new Attack();
        
        zz.attack();
        vm.stopBroadcast();
    }
}
