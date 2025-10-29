# 🧠 MemoVault – On-Chain Secure Text Saver

### 💎 Project Description
**MemoVault** is a beginner-friendly Solidity smart contract that allows users to **securely store, update, and delete text entries directly on the blockchain**.  
Each text (called a *memo*) is permanently recorded on-chain, giving users full ownership and transparency over their data.  

This project is perfect for learning **Solidity fundamentals**, **smart contract storage patterns**, and **access control** — while building something practical!

<img width="1920" height="1080" alt="Screenshot (75)" src="https://github.com/user-attachments/assets/54463e7a-193e-4243-8015-554b98a0c3b3" />

---

### 🚀 What It Does
MemoVault enables anyone with a Web3 wallet (like MetaMask) to:
- Create memos and store them **permanently on-chain**  
- View their memos anytime using their wallet address  
- Update or delete their own memos (nobody else can!)  
- Access memo details such as owner, text, and timestamp  

All actions are recorded via **events** on the blockchain, ensuring full traceability.

---

### ✨ Features
- 🧱 **Create**: Save text securely on the blockchain  
- 🔍 **Read**: Retrieve stored memos by ID  
- ✏️ **Update**: Modify your own memos anytime  
- 🗑️ **Delete**: Permanently remove your memos  
- ⏱️ **Timestamps**: Each action is time-stamped for tracking  
- 🔒 **Ownership Control**: Only the creator of a memo can modify or delete it  
- 📜 **Event Logs**: Every action (create/update/delete) emits an event visible on Block Explorer  

---

### 🌐 Deployed Smart Contract
- Deployed on **Celo Sepolia Testnet**  
🔗 [View on Blockscout](https://celo-sepolia.blockscout.com/address/0xA5d4F75E686b368F10F55Fa854764D1289001E8c)

- **Contract Address:**  
0xA5d4F75E686b368F10F55Fa854764D1289001E8c

---

### 💻 Smart Contract Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MemoVault {
    // Struct to store each memo
    struct Memo {
        string text;
        address owner;
        uint256 timestamp;
    }

    // Mapping from unique ID to Memo
    mapping(uint256 => Memo) private memos;
    uint256 private memoCount; // Tracks total number of memos

    // Events for logging actions
    event MemoCreated(uint256 memoId, address indexed owner, string text, uint256 timestamp);
    event MemoUpdated(uint256 memoId, string newText, uint256 timestamp);
    event MemoDeleted(uint256 memoId, uint256 timestamp);

    // ✅ Create a new memo
    function createMemo(string calldata _text) external {
        require(bytes(_text).length > 0, "Text cannot be empty");

        memos[memoCount] = Memo({
            text: _text,
            owner: msg.sender,
            timestamp: block.timestamp
        });

        emit MemoCreated(memoCount, msg.sender, _text, block.timestamp);
        memoCount++;
    }

    // ✅ Read a memo by ID
    function readMemo(uint256 _id) external view returns (string memory text, address owner, uint256 timestamp) {
        require(_id < memoCount, "Memo does not exist");
        Memo memory m = memos[_id];
        return (m.text, m.owner, m.timestamp);
    }

    // ✅ Update your own memo
    function updateMemo(uint256 _id, string calldata _newText) external {
        require(_id < memoCount, "Memo does not exist");
        Memo storage m = memos[_id];
        require(msg.sender == m.owner, "Not your memo");
        require(bytes(_newText).length > 0, "Text cannot be empty");

        m.text = _newText;
        m.timestamp = block.timestamp;

        emit MemoUpdated(_id, _newText, block.timestamp);
    }

    // ✅ Delete your own memo
    function deleteMemo(uint256 _id) external {
        require(_id < memoCount, "Memo does not exist");
        Memo storage m = memos[_id];
        require(msg.sender == m.owner, "Not your memo");

        delete memos[_id];
        emit MemoDeleted(_id, block.timestamp);
    }

    // ✅ Get total number of memos (useful for frontend)
    function getMemoCount() external view returns (uint256) {
        return memoCount;
    }
}

```

---

### 🧰 Tech Stack
- **Language:** Solidity  
- **Network:** Celo Sepolia Testnet  
- **Tools:** Remix IDE, MetaMask, Blockscout  

---

### 🪄 How to Try It
1. Visit [Remix IDE](https://remix.ethereum.org)  
2. Create a new file named `MemoVault.sol` and paste the contract code  
3. Compile it using **Solidity 0.8.x**  
4. Deploy using **Injected Provider - MetaMask (Celo Sepolia)**  
5. Interact with your contract:
   - `createMemo("Hello Blockchain!")`
   - `readMemo(0)`
   - `updateMemo(0, "Updated text!")`
   - `deleteMemo(0)`

---

### 📘 Learning Goals
- Understand **structs**, **mappings**, and **events**  
- Practice **access control** with `msg.sender`  
- Learn **CRUD operations** in Solidity  
- Explore **blockchain transparency and immutability**  

---

### 🧩 Future Improvements
- 🔐 Off-chain encryption for private memos  
- 🧭 IPFS integration for large text or media storage  
- 🪶 Lightweight React frontend for memo management  
- 👥 Shared/public memo access options  
- 📨 Notifications on memo updates  

---

### 🪙 License
This project is open source and available under the [MIT License](LICENSE).

---

## 💬 Feedback & Contributions

Have ideas, improvements, or suggestions?  
Feel free to open an [Issue](https://github.com/Debrup-Chatterjee/MemoVault/issues) or submit a [Pull Request](https://github.com/Debrup-Chatterjee/MemoVault/pulls).

---

### 🧑‍💻 Author
[Debrup Chatterjee](https://github.com/Debrup-Chatterjee/)


---

## 🔗 Connect with Me

- 💼 [LinkedIn](https://www.linkedin.com/in/debrup-chatterjee/)
- 📧 [Email](mailto:debrupchatterjee31@gmail.com)

---
<p align="center">⭐ If you found this project helpful, consider giving it a star on GitHub!  
Every star motivates open-source learning 🌟</p>

**<p align="center"> Built with ❤️ by Debrup Chatterjee </p>**


