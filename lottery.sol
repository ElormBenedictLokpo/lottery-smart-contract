//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract Lottery{
    address[] public participants;
    address public lottery_manager;

    constructor(){
        lottery_manager = msg.sender;
    }

    modifier minimumValueRequirement(){
        require(msg.value >= 0.000000000000000001 ether, "Minimum is 0.01 ether to enter lottery");
        _;
    }

    function viewParticipants() public view returns(address[] memory){
        return participants;
    }

    function addParticipant() public payable minimumValueRequirement{
        participants.push(msg.sender);
    }

    function getLotteryBalance() public view returns (uint256){
        return address(this).balance;
    }
}