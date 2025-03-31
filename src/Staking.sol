// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13; 
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./OrcaCoin.sol";

contract Staking  {

    mapping (address => uint) balances;

    constructor(){

    }


    function stake() public payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
    }

    function unstake(uint _amount) public  {
           require(_amount < balances[msg.sender]);
           payable(msg.sender).transfer(_amount);
           balances[msg.sender] -= _amount;
    }

    function getRewars() public view {
        
    }

    function claimRewards() public {
        
    }
    
    function balancesOf (address _address) public view returns(uint) {
       return balances[_address];
    }
}

 