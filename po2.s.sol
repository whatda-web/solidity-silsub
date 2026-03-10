// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Counter} from "../src/Counter.sol";

interface Ichall{
    function submit(bytes32 _submit, string calldata username) external;
}

contract CounterScript is Script {
    Counter public counter;

    function setUp() public {}

    function run() public {
        address target = 0xb233e726F8DC8B3Ff27Ff7fB212966B251b6b156;

        vm.startBroadcast();

        bytes32 a = vm.load(target, bytes32(0));
        bytes32 b = vm.load(target, bytes32(uint256(1)));


        uint offset = uint256(keccak256((abi.encode(uint(2), 1))));
        uint structure = uint256(keccak256(abi.encode(uint(2), offset)));
        
        

        bytes32 real_x_y = vm.load(target, bytes32(structure)); // x, y
        bytes32 real_z = vm.load(target, bytes32(structure+1)); // z
        
        console.logBytes32(a);
        console.logBytes32(b);
        console.logBytes32(real_z);
        
        
        
        string memory username = "whatda";
        bytes32 id = keccak256(abi.encode(username, 0x826eC9AA4A9A7E8fa6D3Ce5907590524169bb89f));
        bytes32 expected = keccak256(abi.encode(real_z, id));

        Ichall(target).submit(expected, "whatda");
    

        vm.stopBroadcast();
    }
}
