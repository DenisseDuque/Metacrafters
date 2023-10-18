// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import any necessary libraries or modules here if needed.
// import "hardhat/console.sol";

contract Assessment {
    address payable public owner; // Public variable to store the owner's address.
    uint256 public balance; // Public variable to store the contract's balance.

    event Deposit(uint256 amount); // Event to log deposits.
    event Withdraw(uint256 amount); // Event to log withdrawals.

    // Constructor to initialize the contract with an initial balance.
    constructor(uint initBalance) payable {
        owner = payable(msg.sender); // Set the contract owner to the sender of the deployment transaction.
        balance = initBalance; // Set the initial balance to the provided parameter.
    }

    // Function to get the current balance of the contract.
    function getBalance() public view returns(uint256) {
        return balance;
    }

    // Function to deposit funds into the contract.
    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        // Ensure that the sender is the owner.
        require(msg.sender == owner, "You are not the owner of this account");

        // Increase the contract's balance by the deposit amount.
        balance += _amount;

        // Assert that the balance has been updated correctly.
        assert(balance == _previousBalance + _amount);

        // Emit the Deposit event to log the deposit.
        emit Deposit(_amount);
    }

    // Custom error definition for insufficient balance.
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    // Function to withdraw funds from the contract.
    function withdraw(uint256 _withdrawAmount) public {
        // Ensure that the sender is the owner.
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;

        // Check if the balance is sufficient for the requested withdrawal.
        if (balance < _withdrawAmount) {
            // Revert with the InsufficientBalance error if there's not enough balance.
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // Deduct the withdrawal amount from the contract's balance.
        balance -= _withdrawAmount;

        // Assert that the balance has been updated correctly.
        assert(balance == (_previousBalance - _withdrawAmount));

        // Emit the Withdraw event to log the withdrawal.
        emit Withdraw(_withdrawAmount);
    }
}

