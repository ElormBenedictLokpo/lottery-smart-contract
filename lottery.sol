//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract Lottery{
    address[] public participants;
    address public lottery_manager;
    address payable public winner_address;


    constructor(){
        lottery_manager = msg.sender;
    }

    event ParticipantJioned(address _participant);

    modifier minimumValueRequirement(){
        require(msg.value >= 0.000000000000000001 ether, "Minimum is 0.01 ether to enter lottery");
        _;
    }

    modifier isManager(){
        require(msg.sender == lottery_manager);
        _;
    }

    function viewParticipants() public view isManager returns(address[] memory){
        return participants;
    }

    function payToJoin() public payable minimumValueRequirement{
        participants.push(msg.sender);

        emit ParticipantJioned(msg.sender);
    }

    function getLotteryBalance() public view isManager returns (uint256){
        return address(this).balance;
    }

    function declareWinner() public isManager{
        winner_address = payable(participants[1]);
        winner_address.transfer(address(this).balance);

        participants = new address[](0);
    }

    function getBalanceOfParticipant(address _address) public view isManager returns(uint256){
        return _address.balance;
    }
}