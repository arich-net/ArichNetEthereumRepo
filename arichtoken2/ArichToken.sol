pragma solidity ^0.4.20;

contract ArichToken {
    struct Account {
        uint256 last_balance;
        bool freeze;
        bool burn;
        string f_reason;
        string b_reason;
    }
    
    address owner;
    // Mapping Wallet for all accounts
    mapping (address => Account) public walletOf;
    // Mapping Balance for all accounts
    mapping (address => uint256) public balanceOf;
    // Array of created Accounts
    address[] public created_accounts;
    // This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint256 value);
    // This will generate an Event to notify clients an account is Freezed
    event Freezed(address indexed freezed);
    // This will generate an Event to notify clients an account is Unfreezed
    event Unfreezed(address indexed unfreezed);
    // This will generate an Event to notify clients an account was Burn
    event Burnt(address indexed burnt);
    
    /* Mapping for ALL balances */
    function ArichToken(uint256 initialSupply) public {
        owner = msg.sender;
        /* Initialize Wallet for Owner */
        walletOf[owner] = Account({last_balance: 0, 
                                   freeze: false,
                                   burn: false,
                                   f_reason: "",
                                   b_reason: ""});
        /* Give to the owner all tokens */
        balanceOf[owner] = initialSupply;

        /* Start with the Array of Accounts */
        created_accounts.push(owner);
    }
    
    /* Transfer tokens from one account to another */
    function transfer(address _to, uint256 _value) public returns(bool success) {
        bool retval;
        require(!walletOf[msg.sender].freeze);
        require(!walletOf[_to].freeze);
        require(!walletOf[msg.sender].burn);
        if (balanceOf[msg.sender] > _value) {
            if (balanceOf[_to] == 0)
                created_accounts.push(_to);
            balanceOf[_to] += _value;
            balanceOf[msg.sender] -= _value;
            retval = true;
        }
        else {
            /* Freeze the account since this is not a valid transaction */
            walletOf[msg.sender].freeze = true;
            walletOf[msg.sender].last_balance = balanceOf[msg.sender];
            walletOf[msg.sender].f_reason = "Transfer more than funds available";
            retval = false;
        }
        return retval;
    }
    
    /* Add more tokens */ 
    function addTokens(uint256 _value) public returns(bool success) {
        require(msg.sender == owner);
        require(_value < 100); // Not more than 100 Tokens 
        balanceOf[owner] += _value;
        return true;
    }
    
    /* Remove more tokens */
    function removeTokens(uint256 _value) public returns(bool success) {
        require(msg.sender == owner);
        require(balanceOf[owner] - _value > 0);
        require(_value < 100); // Not more than 100 Tokens 
        balanceOf[owner] -= _value;
        return true;
    }

    /* Freeze an Account */
    function freezeAccount(address _to) public returns(bool success) {
        require(msg.sender == owner);
        require(!walletOf[_to].freeze);
        require(balanceOf[_to] > 0);
        walletOf[_to].freeze = true;
        walletOf[_to].last_balance = balanceOf[_to];
        walletOf[_to].f_reason = "Freezed by the owner";
        emit Freezed(_to);
        return true;
    }
    /* Unfreeze an Account */
    function unfreezeAccount(address _to) public returns(bool success) {
        require(msg.sender == owner);
        require(walletOf[_to].freeze);
        walletOf[_to].freeze = false;
        balanceOf[_to] = walletOf[_to].last_balance;
        walletOf[_to].f_reason = "Unfreezed by the owner";
        emit Unfreezed(_to);
        return true;
    }

    /* Burn an Account */
    function burnAccount(address _to, string _reason) public returns(bool success) {
        require(msg.sender == owner);
        require(!walletOf[_to].burn);
        require(balanceOf[_to] > 0);
        walletOf[_to].burn = true;
        walletOf[_to].last_balance = balanceOf[_to];
        walletOf[_to].b_reason = _reason;
        balanceOf[owner] += balanceOf[_to];
        balanceOf[_to] = 0;
        emit Burnt(_to);
        return true;
    }

    /* Burn ALL Accounts */
    function burnALL(string _reason) public returns(bool success) {
        require(msg.sender == owner);
        for (uint i = 0; i < created_accounts.length; i++) {
            walletOf[created_accounts[i]].burn = true;
            walletOf[created_accounts[i]].last_balance = balanceOf[created_accounts[i]];
            walletOf[created_accounts[i]].b_reason = _reason;
            balanceOf[created_accounts[i]] = 0;
            emit Burnt(created_accounts[i]);
        }
        return true;
    }
    
    /* Kill Smart Contract */
    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}
