import React, { useState } from "react";
import { ethers } from "ethers";
import Web3Modal from "web3modal";
import FundMeABI from "./FundMeABI.json"; // Ensure you have this file
import './App.css';


const contractAddress = "0x7C5aEC99776b4670d082d1d9a6829a4BB090F0E8"; // Replace with actual address

function App() {
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);
  const [contract, setContract] = useState(null);
  const [amount, setAmount] = useState("");

  // Connect Wallet
  async function connectWallet() {
    try {
      const web3Modal = new Web3Modal();
      const connection = await web3Modal.connect();
      const provider = new ethers.BrowserProvider(connection);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, FundMeABI, signer);

      setProvider(provider);
      setSigner(signer);
      setContract(contract);
    } catch (error) {
      console.error("Wallet connection failed:", error);
    }
  }

  // Fund Contract
  async function fundContract() {
    if (!contract) return alert("Connect wallet first!");
    try {
      const tx = await contract.fund({ value: ethers.parseEther(amount) });
      await tx.wait();
      alert("Transaction Successful!");
    } catch (error) {
      console.error("Funding failed:", error);
    }
  }

  // Withdraw Funds (Owner Only)
  async function withdrawFunds() {
    if (!contract) return alert("Connect wallet first!");
    try {
      const tx = await contract.withdraw();
      await tx.wait();
      alert("Withdrawal Successful!");
    } catch (error) {
      console.error("Withdrawal failed:", error);
    }
  }

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h1>FundMe DApp</h1>
      <button onClick={connectWallet}>Connect Wallet</button>
      <br /><br />
      <input
        type="text"
        placeholder="Amount in ETH"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button onClick={fundContract}>Fund</button>
      <br /><br />
      <button onClick={withdrawFunds}>Withdraw</button>
    </div>
  );
}

export default App;
