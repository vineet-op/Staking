// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13; 
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./OrcaCoin.sol";

contract Staking  {

    mapping (address => uint) balances;
    mapping(address => uint) unClamiedRewards;
    mapping (address => uint) lastUpdated;

    constructor(){

    }


    function stake() public payable {
        require(msg.value > 0);
        
        if(lastUpdated[msg.sender] == 0){
            lastUpdated[msg.sender] = block.timestamp;
        }
        else{
            unClamiedRewards[msg.sender] += (block.timestamp - lastUpdated[msg.sender] * balances[msg.sender]);    
            lastUpdated[msg.sender] = block.timestamp;
        }

        balances[msg.sender] += msg.value;
    }

    function unstake(uint _amount) public  {
           require(_amount < balances[msg.sender]);

            unClamiedRewards[msg.sender] += (block.timestamp - lastUpdated[msg.sender] * balances[msg.sender]);    
            lastUpdated[msg.sender] = block.timestamp;

           payable(msg.sender).transfer(_amount);
           balances[msg.sender] -= _amount;
    }

    function getRewards(address _address) public view returns(uint) {
        uint currReward  = unClamiedRewards[_address];
        uint lastUpdateTime = lastUpdated[_address];
        uint newReward = (block.timestamp - lastUpdateTime) * balances[_address];
        return currReward + newReward;
    }

    function claimRewards() public payable {

        unClamiedRewards[msg.sender] += (block.timestamp - lastUpdated[msg.sender] * balances[msg.sender]);    
        lastUpdated[msg.sender] = block.timestamp;
        
        uint currReward  = unClamiedRewards[msg.sender];
        uint lastUpdateTime = lastUpdated[msg.sender];
        uint newReward = (block.timestamp - lastUpdateTime) * balances[msg.sender];
        payable(msg.sender).transfer(currReward + newReward);
        unClamiedRewards[msg.sender] = 0;
        lastUpdated[msg.sender] = block.timestamp;
    }   
    
    function balancesOf (address _address) public view returns(uint) {
       return balances[_address];
    }
}

 