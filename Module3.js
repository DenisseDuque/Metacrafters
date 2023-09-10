// Create an array to hold NFTs
const NFTs = [];

// Function to mint an NFT and add it to the NFTs array
function mintNFT(name, eyeColor, shirtType, bling) {
    const NFT = {
        "name": name,
        "eyeColor": eyeColor,
        "shirtType": shirtType,
        "bling": bling,
    };

    NFTs.push(NFT);
    console.log("Minted: " + name);
}

// Function to list all minted NFTs
function listNFTs() {
    console.log("\n***NFT Details***");
    for (let i = 0; i < NFTs.length; i++) {
        console.log("\nID: \t\t" + (i + 1)); // Display the NFT ID
        console.log("Name: \t\t" + NFTs[i].name); // Display the NFT name
        console.log("Eye Color: \t" + NFTs[i].eyeColor); // Display the NFT eye color
        console.log("Shirt Type: " + NFTs[i].shirtType); // Display the NFT shirt type
        console.log("Bling: \t\t" + NFTs[i].bling); // Display the NFT bling/accessories
    }
}

// Function to print the total number of minted NFTs
function getTotalSupply() {
    console.log("\nNFT Total Supply: " + NFTs.length); // Display the total supply of minted NFTs
}

// Call the Functions
// Add values to be passed as parameters
console.log("***Minting NFTs***")
mintNFT("Denisse", "Brown", "Blouse", "Beads");
mintNFT("Alex", "Blue", "T-shirt", "Gold Chains");
mintNFT("Emma", "Green", "Dress", "Diamonds");
mintNFT("Oliver", "Hazel", "Suit", "Silver Rings");

// List all minted NFTs and display their details
listNFTs();

// Print the total number of minted NFTs
getTotalSupply();
