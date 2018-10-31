pragma solidity ^0.4.20;

contract ArichToken {
    mapping (address => uint256) public balanceOf;
    address public owner;
    
    /* Mapping for ALL balances */
    function ArichToken(uint256 initialSupply) public {
        owner = msg.sender;
        balanceOf[msg.sender] = initialSupply; // Give owner all initial tokens
    }
    
    /* Transfer tokens from one account to another */
    function transfer(address _to, uint256 _value) public returns(bool success) {
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }
    
    /* Add more tokens  */
    function addTokens(uint256 _value) public returns(bool success) {
        require(msg.sender == owner);
        require(_value < 100); // Not more than 100 Tokens 
        balanceOf[owner] += _value;
        return true;
    }
    
    /* Remove more tokens  */
    function removeTokens(uint256 _value) public returns(bool success) {
        require(msg.sender == owner);
        require(_value < 100); // Not more than 100 Tokens 
        balanceOf[owner] -= _value;
        return true;
    }
    
    /* Kill Smart Contract*/
    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}
