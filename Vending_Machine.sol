// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// State Variables: owner, balances
// Functions: purchase, restock, get balance
// Contrusctor: set owner, set initial balance of vending machine

contract VendingMachine {
    address public owner;
    mapping(address => uint) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function purchase(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You must pay at leat 2 ethers per donut");
        require(donutBalances[address(this)] >= amount, "NOt enough donuts in stock to fulfill requests");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only the Owner can restock the machine");
        donutBalances[address(this)] += amount;
    }
    
    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }
}
