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
