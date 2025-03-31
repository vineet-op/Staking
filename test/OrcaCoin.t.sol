// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";

import {OrcaCoin} from "../src/OrcaCoin.sol";

contract Orca is Test {
    OrcaCoin public Orcacoin;

    function setUp() public {
        Orcacoin = new OrcaCoin(address(this));
    }

    function testInitialSupply() public view {
        assert(Orcacoin.totalSupply() == 0);
    }

    function test_RevertIf_MintFails() public {
        vm.expectRevert();
        vm.prank(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f);
        Orcacoin.mint(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f, 10);
    }

    function testMint() public {
        Orcacoin.mint(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f, 10);
        assert(Orcacoin.balanceOf(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f) == 10) ;
    }

    function testChangingContract() public {
        Orcacoin.updatestakingContract(
            0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f
        );
        vm.startPrank(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f);
        Orcacoin.mint(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f, 10);
        assert(Orcacoin.balanceOf(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f) == 10);
    }
}
