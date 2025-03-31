// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";

import {Staking} from "../src/Staking.sol";

contract Orca is Test {
    Staking public staking;

    function setUp() public {
        staking = new Staking();
    }
    
     function testStakeuser() public {
        vm.startPrank(address(this));
        vm.deal(address(this), 10 ether);
        staking.stake{value: 1 ether}();
        assert(staking.balancesOf(address(this)) == 1 ether);
    }

    function testStake() public {
        staking.stake{value: 1 ether}(); 
        assert(staking.balancesOf(address(this)) == 1 ether);
    }

    function testUnstake() public {
        staking.stake{value: 1 ether}();
        staking.unstake(0.5 ether);
        assert(staking.balancesOf(address(this)) == 0.5 ether);
    }

    function test_RevertIf_MintFails() public {
        staking.stake{value : 1 ether}();
        vm.expectRevert();
        staking.unstake(2 ether);
    }


}
