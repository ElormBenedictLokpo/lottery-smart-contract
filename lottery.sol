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
        require(msg.value >= 0.00061 ether, "Minimum is 0.00061 ether to enter lottery");
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

    function random() public view returns(uint256){
        uint256 random_num = uint256(keccak256(abi.encodePacked(block.timestamp, participants.length)));
        uint256 result = random_num % participants.length;
        return result;
    }

    function declareWinner() public isManager{
        uint256 random_index = random();
        winner_address = payable(participants[random_index]);
        winner_address.transfer(address(this).balance);

        participants = new address[](0);
    }

   

    function getBalanceOfParticipant(address _address) public view isManager returns(uint256){
        return _address.balance;
    }
}