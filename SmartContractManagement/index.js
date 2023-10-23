import { useState, useEffect } from "react";
import { ethers } from "ethers";
import atm_abi from "../artifacts/contracts/Assessment.sol/Assessment.json";

export default function HomePage() {
  // Define state variables to manage the Ethereum wallet, account, ATM contract, and balance.
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [atm, setATM] = useState(undefined);
  const [balance, setBalance] = useState(undefined);

  // Ethereum contract address and ABI for the ATM contract.
  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const atmABI = atm_abi.abi;

  // Function to get the user's MetaMask wallet.
  const getWallet = async () => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const account = await ethWallet.request({ method: "eth_accounts" });
      handleAccount(account);
    }
  }

  // Function to handle the user's Ethereum account.
  const handleAccount = (account) => {
    if (account) {
      console.log("Account connected: ", account);
      setAccount(account);
    } else {
      console.log("No account found");
    }
  }

  // Function to connect the user's MetaMask account.
  const connectAccount = async () => {
    if (!ethWallet) {
      alert('MetaMask wallet is required to connect');
      return;
    }

    const accounts = await ethWallet.request({ method: 'eth_requestAccounts' });
    handleAccount(accounts);

    getATMContract();
  };

  // Function to get a reference to the ATM contract.
  const getATMContract = () => {
    const provider = new ethers.providers.Web3Provider(ethWallet);
    const signer = provider.getSigner();
    const atmContract = new ethers.Contract(contractAddress, atmABI, signer);
    setATM(atmContract);
  }

  // Function to get the user's balance from the ATM contract.
  const getBalance = async () => {
    if (atm) {
      setBalance((await atm.getBalance()).toNumber());
    }
  }

  // Function to deposit funds into the ATM.
  const deposit = async () => {
    if (atm) {
      let tx = await atm.deposit(1);
      await tx.wait();
      getBalance();
    }
  }

  // Function to withdraw funds from the ATM.
  const withdraw = async () => {
    if (atm) {
      let tx = await atm.withdraw(1);
      await tx.wait();
      getBalance();
    }
  }

  // Function to render the user interface based on the user's status.
  const initUser = () => {
    // Check if the user has MetaMask.
    if (!ethWallet) {
      return <p>Please install MetaMask to use this ATM.</p>;
    }

    // Check if the user is connected. If not, provide a button to connect.
    if (!account) {
      return (
        <button
          onClick={connectAccount}
          style={{
            backgroundColor: 'gold',
            color: 'black',
            padding: '10px 20px',
            fontSize: '16px',
            borderRadius: '20px'
          }}
        >
          Please connect your MetaMask wallet
        </button>
      );
    }

    // If balance is undefined, attempt to get it.
    if (balance === undefined) {
      getBalance();
    }

    // Render user account information and deposit/withdraw buttons.
    return (
      <div>
        <div style={{ backgroundColor: 'lightblue', padding: '20px' }}>
          <p style={{ fontSize: '17px' }}>Your Account: {account}</p>
          <p style={{ fontSize: '17px' }}>Your Balance: {balance}</p>
        </div>
        <button
          onClick={deposit}
          style={{
            backgroundColor: 'green',
            color: 'black',
            padding: '10px 20px',
            fontSize: '16px',
            marginRight: '10px',
            borderRadius: '20px'
          }}
        >
          Deposit 1 ETH
        </button>
        <button
          onClick={withdraw}
          style={{
            backgroundColor: 'red',
            color: 'black',
            padding: '10px 20px',
            fontSize: '16px',
            borderRadius: '20px'
          }}
        >
          Withdraw 1 ETH
        </button>
      </div>
    );
  }

  // Use the `useEffect` hook to call `getWallet` when the component mounts.
  useEffect(() => {
    getWallet();
  }, []);

  // Render the main component, including headers and user interface.
  return (
    <main className="container">
      <header style={{ backgroundColor: 'black', padding: '20px' }}>
        <div style={{ backgroundColor: 'blue', padding: '10px', borderRadius: '5px' }}>
          <h1 style={{ color: 'darkblue' }}>Welcome to the Metacrafters ATM!</h1>
        </div>
      </header>
      {initUser()}
      {/* CSS-in-JS for container */}
      <style jsx>{`
        .container {
          text-align: center;
        }
      `}
      </style>
      {/* Global CSS for body background */}
      <style jsx global>{`
        body {
          background: url(${'https://images.hdqwalls.com/download/3d-cube-background-4k-yo-2560x1440.jpg'}) no-repeat center center fixed;
          background-size: cover;
          margin: 0;
          padding: 0;
        }
      `}
      </style>
    </main>
  );
}
