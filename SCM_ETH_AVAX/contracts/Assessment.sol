// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Assessment contract represents a simple account with deposit and withdrawal functionality.
contract Assessment {
    //Variable for the owner of the account
    address payable public owner;
    
    //Variable for the current balance of the account.
    uint256 public balance;

    //Event during account deposit transactions 
    event Deposit(uint256 amount);
    
   //Event during account withdraw transactions
    event Withdraw(uint256 amount);

    //The constructor that initializes the contract 
    //with an initial balance and sets the owner.
    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    //Function that gets the current balance of the account.
    function getBalance() public view returns (uint256) {
        return balance;
    }

    //Modifier to ensure there's a sufficient balance for an operation.
    modifier sufficientBalance(uint256 _amount) {
        require(balance >= _amount, "Not enough balance.");
        _;
    }

    // Deposit function allows the owner to add funds to the account.
    function deposit(uint256 _amount) public payable {
        // Calculates the new balance after the deposit.
        uint256 newBalance = balance + _amount;

        // Checks if the sender is the owner, otherwise revert.
        if (msg.sender != owner) {
            revert("ERROR: Only for the account owner");
        }

        // Updates the balance and emits the deposit event.
        balance = newBalance;
        emit Deposit(_amount);
    }

    // Withdraw function allows withdrawal of funds from the account.
    function withdraw(uint256 _withdrawAmount) public sufficientBalance(_withdrawAmount) {
        // Calculates the new balance after the withdrawal.
        uint256 newBalance = balance - _withdrawAmount;

        // Checks if the sender is the owner, otherwise revert.
        if (msg.sender != owner) {
            revert("ERROR: Only for the account owner");
        }

        // Updates the balance and emits the Withdraw event.
        balance = newBalance;
        emit Withdraw(_withdrawAmount);
    }
}


