// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EscrowAndTopUp {
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => bool) public isParticipant;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyParticipant() {
        require(isParticipant[msg.sender], "Only participants can call this function");
        _;
    }

    function addParticipant(address participant) external onlyOwner {
        isParticipant[participant] = true;
    }

    function topUp() external payable onlyParticipant {
        require(msg.value > 0, "Amount should be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external onlyParticipant {
        require(amount > 0, "Amount should be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function depositToEscrow(address recipient, uint256 amount) external onlyParticipant {
        require(amount > 0, "Amount should be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[address(this)] += amount;
        emit DepositToEscrow(msg.sender, recipient, amount);
    }

    function releaseFromEscrow(address recipient, uint256 amount) external onlyOwner {
        require(amount > 0, "Amount should be greater than 0");
        require(balances[address(this)] >= amount, "Insufficient balance in escrow");
        balances[address(this)] -= amount;
        balances[recipient] += amount;
        emit ReleaseFromEscrow(recipient, amount);
    }

    event DepositToEscrow(address indexed sender, address indexed recipient, uint256 amount);
    event ReleaseFromEscrow(address indexed recipient, uint256 amount);
}
