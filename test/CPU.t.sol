// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "../lib/forge-std/src/Test.sol";
// import "../lib/forge-std/src/console.sol";

import "src/CPU.sol";

contract TestContract is Test {
    CPU cpu;

    function setUp() public {
        cpu = new CPU();
    }

    function testLoadProgram() public {
        uint256[] memory _program = new uint256[](2);
        _program[0] = 0;
        _program[1] = 1;

        cpu.loadProgram(_program);
    }

    function testStep() public {
        cpu.step();
    }
}
