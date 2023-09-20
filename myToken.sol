// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MyToken {

    // Public variables to store token details
    string public tokenName = "BYTE";
    string public tokenAbbrv = "BYT";
    uint public totalSupply = 0;   
    
    // Mapping to track token balances of addresses
    mapping(address => uint) public balances;

    // Mint new tokens and increase the total supply.
    function mint (address _address, uint _value) public {
        totalSupply += _value;
        balances[_address] += _value;
    }

    // Burn tokens and decrease the total supply.
    function burn (address _address, uint _value) public {
        // Check if there is a sufficient balance to burn tokens
        if (balances[_address] >= _value) {
            totalSupply -= _value;
            balances[_address] -= _value;
        }
    }
}
