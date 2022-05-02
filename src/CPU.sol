// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

contract CPU {
    enum REGISTER {
        IP,
        ACC,
        R1,
        R2,
        R3,
        R4
    }

    enum INSTRUCTIONS {
        MOV_LITR_R1,
        MOV_LITR_R2,
        ADD_REG_REG
    }

    mapping(REGISTER => uint256) public registers; // registers
    uint256[] public mem; // list of instructions in sets of 3

    function loadProgram(uint256[] memory _mem) public {
        _clearRegisters(); // wipe all registers and set memory
        mem = _mem; // set in new memory
    }

    function _clearRegisters() internal {
        registers[REGISTER.ACC] = 0;
        registers[REGISTER.IP] = 0;
        registers[REGISTER.R1] = 0;
        registers[REGISTER.R2] = 0;
        registers[REGISTER.R3] = 0;
        registers[REGISTER.R4] = 0;
    }

    // fetch 1 slot of information from memory
    function fetch1() public returns (uint256) {
        uint256 _instructionPointer = registers[REGISTER.IP];
        uint256 _instruction = mem[_instructionPointer];
        registers[REGISTER.IP] += 1;
        return _instruction;
    }

    // fetch 2 slots of information from memory
    function fetch2() public returns (uint256) {
        uint256 _instructionPointer = registers[REGISTER.IP];
        uint256 _instruction = mem[_instructionPointer];
        registers[REGISTER.IP] += 1;
        return _instruction;
    }

    function execute(INSTRUCTIONS _instruction) public {
        if (_instruction == INSTRUCTIONS.MOV_LITR_R1) {
            uint256 _val = fetch1();
            registers[REGISTER.R1] = _val;
        } else if (_instruction == INSTRUCTIONS.MOV_LITR_R2) {
            uint256 _val = fetch1();
            registers[REGISTER.R2] = _val;
        } else if (_instruction == INSTRUCTIONS.ADD_REG_REG) {
            uint256 _r1target = fetch1();
            uint256 _r2target = fetch2();
            // fetch r1 and r2 values from target
            registers[REGISTER.ACC] =
                registers[REGISTER(_r1target)] +
                registers[REGISTER(_r2target)];
        }
    }

    function step() public {
        uint256 _instruction = fetch1();
        // execute(INSTRUCTIONS(_instruction));
    }
}
