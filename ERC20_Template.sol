pragma solidity ^0.5.0;
contract ERC20_Template {
    // Optional memory
    string tokenName;
    string tokenSymbol;
    uint8 tokenDecimals;
    // Required memory
    uint256 Supply;
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowances;

    constructor (string memory _name, string memory _symbol, uint8 _decimals) public {
        tokenName = _name;
        tokenSymbol = _symbol;
        tokenDecimals = _decimals;
    }

    // Optional ERC20 functions
    function name() public view returns (string memory) {
        return tokenName;
    }
    function symbol() public view returns (string memory) {
        return tokenSymbol;
    }
    function decimals() public view returns (uint8) {
        return tokenDecimals;
    }
    // Required ERC20 functions
    function totalSupply() public view returns (uint256) {
        return Supply;
    }
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_value >= 0, "negative value");
        require(balances[msg.sender] >= _value, "insufficient balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value >= 0, "negative value");
        require(balances[_from] >= _value, "insufficient balance");
        require(allowances[_from][msg.sender] >= _value, "unapproved value");
        balances[_from] -= _value;
        allowances[_from][msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
    // TODO: check "Attack Vectors"
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_value >= 0, "negative value");
        require(balances[msg.sender] >= _value, "insufficient balance");
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }
    // Required ERC20 events
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}


