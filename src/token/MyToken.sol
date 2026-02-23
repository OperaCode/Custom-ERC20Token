// SPDX-License-Identifer:MIT
pragma solidity ^0.8.13;

import {IERC20} from "../interface/IERC20.sol";


contract MyToken{

// Events
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);

// token MetaData
string private constant _name= "MYTOKEN";

string private constant _symbol= "MTK";

uint8 private constant _decimals =18;

// uint256 private _totalSupply = 1_000_000 * 10 **18;

uint256 private _totalSupply = 6_000_000 * 10 ** uint256(_decimals);


// mappings
mapping(address => uint256 ) private _balances;

mapping(address => mapping(address =>uint256))private _allowances;



function name () external view returns(string memory){
    return _name;
}

function symbol () external view returns(string memory){
    return _symbol;
}

function decimals ()external view returns(uint8){
    return _decimals;
}

function totalSupply() external view returns(uint256){
    return _totalSupply;
}


function balanceOf(address _owner) external view returns (uint256 ){
    return _balances[_owner];
}

function mint(address _owner, uint256 _amount) external {
    require(_owner != address(0), "Invalid address: cannot mint to address zero");
    require(_amount > 0, "Mint amount must be greater than zero");

    _totalSupply = _totalSupply + _amount;
    _balances[_owner] = _balances[_owner] + _amount;
    
}



function transfer (address _to, uint256 _value) external returns (bool success){

    // sanity checks 
    require(_balances[msg.sender] >= _value, "Balance too Low to transfer");

    require(_value > 0, "Transfer value must be greater than zero");

    // update balances
    _balances[msg.sender]= _balances[msg.sender] - _value;
    _balances[_to] = _balances[_to] + _value;

    emit Transfer(msg.sender, _to, _value);
    return true;
}

function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){
    require(_to != address(0), "Invalid receipient address :Cannot Send to Address zero");

    require(_balances[_from] >= _value, "Balance too Low to transfer");

    _balances[_from] = _balances[_from] - _value;
    _balances[_to] = _balances[_to] + _value;

    _allowances[_from][msg.sender] = _allowances[_from][msg.sender] - _value;

    emit Transfer(_from, _to, _value);
    return true;
}






}