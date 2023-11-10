// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    //Initializes the token with a name and symbol and sets the owner to the deployer.
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    //Mints new tokens and can only be called by the owner.
    function mintTokens(address to, uint256 amount) public onlyOwner {
        //Checks for valid recipient address and positive amount.
        require(to != address(0), "ERROR: Invalid recipient address");
        require(amount > 0, "ERROR: Minted amount must be greater than zero");
        _mint(to, amount); // Mint new tokens.
    }
    
    //Burns tokens and reduces the account's balance.
    function burnTokens(uint256 amount) public {
        // Check for sufficient balance and positive amount.
        require(balanceOf(msg.sender) >= amount, "ERROR: Account has insufficient balance");
        require(amount > 0, "ERROR: Burn amount must be greater than zero");
        _burn(msg.sender, amount); // Burn tokens.
    }

    //Overrides the transfer function which transfers tokens to other addresses.
    function transfer(address recipient, uint256 amount) override public returns (bool) {
        // Checks for valid recipient address, positive amount, and sufficient balance.
        require(recipient != address(0), "ERROR: Invalid recipient address");
        require(amount > 0, "ERROR: Transfer amount must be greater than zero");
        require(balanceOf(_msgSender()) >= amount, "ERROR: Insufficient balance");
        _transfer(_msgSender(), recipient, amount); // Transfer tokens.
        return true;
    }

    //Allows redemption of in-game items
    function redeemTokens(uint256 choice) public returns (bool) {
        uint256 tokens;
        string memory itemName;

        //Determines the token cost as well as the item name based on the choice.
        if (choice == 1) {
            tokens = 100; // Cost for Game Card
            itemName = "Game Card";
        } else if (choice == 2) {
            tokens = 200; // Cost for Coffee Mug
            itemName = "Coffee Mug";
        } else if (choice == 3) {
            tokens = 300; // Cost for Action Figure
            itemName = "Action Figure";
        } else {
            revert("ERROR: Invalid input, please try again");
        }

        //Checks for sufficient balance, emits an event, and burns tokens depending on the choice.
        require(balanceOf(msg.sender) >= tokens, "ERROR: Account has insufficient balance");
        emit redeemItems(msg.sender, choice, itemName);
        _burn(msg.sender, tokens);
        return true;
    }
    
    //Event to log the redemption of in-game items.
    event redeemItems(address indexed player, uint256 amount, string itemName);

    //Displays the in-game store items as well as their cost.
    function displayItems() public pure returns (string memory) {
        return "Items in the in-game store:\n 1: Game Card for 100 Tokens\n 2: Coffee Mug for 200 Tokens\n3: Action Figure for 300 Tokens";
    } 
    
    //Overrides the balanceOf function to include a validity checks.
    function balanceOf(address account) public view override returns (uint256) {
        require(account != address(0), "ERROR: Invalid address");
        return super.balanceOf(account);
    }

    //Transfers ownership to a new owner which can only be called if ownership is currently emptyt.
    function pronounceOwnership(address newOwner) external {
        require(owner() == address(0), "ERROR: Ownership already pronounced");
        _transferOwnership(newOwner);
    }
}
