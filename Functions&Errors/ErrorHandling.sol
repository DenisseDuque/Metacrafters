// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Account {
    // Struct to hold account information
    struct AccountInfo {
        string name;           // Name of the account holder
        address accountAddress; // address associated with the account
    }

    mapping(address => AccountInfo) public accounts; // Mapping to store account information for each address
    uint public balance; // Current balance of the contract
    uint public constant MAX_BALANCE = 1000;  // Maximum allowed balance 

    // Function to create an account with a given name
    function createAccount(string memory name) public {
        address accountAddress = msg.sender;
        
        // Check if an account already exists for the sender's address
        require(bytes(accounts[accountAddress].name).length == 0, "Account already exists");
        
        // Create a new account using the sender's address and provided name
        accounts[accountAddress] = AccountInfo(name, accountAddress);
    }

    // Function to deposit funds into the account
    function deposit(uint amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + amount;

        // Check if the new balance exceeds the maximum allowed balance
        require(newBalance <= MAX_BALANCE, "Balance exceeds the maximum limit");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    // Function to withdraw funds from the account
    function withdraw(uint amount) public {
        uint oldBalance = balance;

        // Check if the withdrawal amount does not result in a negative balance
        require(MAX_BALANCE >= amount, "Withdrawal amount exceeds maximum limit");

        if (balance < amount) {
            revert("Insufficient balance");
        }

        balance -= amount;

        assert(balance <= oldBalance);
    }
}
