pragma solidity ^0.4.16;

contract life {
    address owner;
    function life() { owner = msg.sender; }
    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}


contract HelloWorld is life {
    string message;
    function HelloWorld(string _message) public {
        message = _message; }
    function msg() constant returns (string) {
        return message; }
}

