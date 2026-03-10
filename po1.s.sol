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
        address target = 0x5F151DfEA40761022d3Da8deF8CA7724413c4e4C;

        vm.startBroadcast();

        uint offset = uint256(keccak256((abi.encode(2))));

        bytes32 a = vm.load(target, bytes32(0));
        bytes32 b = vm.load(target, bytes32(uint256(1)));
        bytes32 c = vm.load(target, bytes32(uint256(3)));
        bytes32 d = vm.load(target, bytes32(uint256(4)));
        bytes32 flag0 = vm.load(target, bytes32(offset));
        bytes32 flag1 = vm.load(target, bytes32(offset+1));
        bytes32 flag2 = vm.load(target, bytes32(offset+2));

        console.logBytes32(a);
        console.logBytes32(b);
        console.logBytes32(c);
        console.logBytes32(d);
        
        console.logBytes32(flag0);
        console.logBytes32(flag1);
        console.logBytes32(flag2);

        string memory username = "whatda";
        bytes32 id = keccak256(abi.encode(username, 0x826eC9AA4A9A7E8fa6D3Ce5907590524169bb89f));
        bytes32 expected = keccak256(abi.encode(flag0, flag1, flag2, id));

        Ichall(target).submit(expected, "whatda");
        

        vm.stopBroadcast();
    }
}
