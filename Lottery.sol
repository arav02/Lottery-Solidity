//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    address payable[] public players;
    
    constructor() {
        manager = msg.sender;
    }
    
    function buyTicket() public payable {
        require(msg.value == 1 ether);
        players.push(payable(msg.sender));
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function random() private view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.basefee, block.timestamp, players.length)));
    }
    function selectWinner() public restricted returns (address) {
    uint index = random() % players.length;
    address payable winner = payable(players[index]);
    winner.transfer(address(this).balance);
    players = new address payable[](0);
    return winner;
   }
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}
