// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13; 
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract OrcaCoin is ERC20{

    address owner;
    address stakingContract;

    constructor(address _stakingContract) ERC20("OrcaCoin", "OC")   {
        stakingContract = _stakingContract;
        owner = msg.sender;
    }

    function mint(address account, uint256 value) public {
        require(msg.sender == owner);
        _mint(account, value);
    }

    function updatestakingContract(address _stakingContract) public {
        require(msg.sender == owner);
        stakingContract = _stakingContract;
    }
}

 