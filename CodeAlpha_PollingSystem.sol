// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollingSystem {

    struct Poll {
        string title;
        string[] options;
        uint256 endTime;
        mapping(uint256 => uint256) voteCounts;
        mapping(address => bool) hasVoted;
    }

    mapping(uint256 => Poll) public polls;
    uint256 public pollCount;

    event PollCreated(uint256 pollId, string title, uint256 endTime);
    event Voted(uint256 pollId, address voter, uint256 optionIndex);

    function createPoll(
        string memory title,
        string[] memory options,
        uint256 durationInSeconds
    ) public {
        require(options.length >= 2, "Minimum 2 options required");
        
        uint256 pollId = pollCount++;
        Poll storage newPoll = polls[pollId];
        newPoll.title = title;
        newPoll.options = options;
        newPoll.endTime = block.timestamp + durationInSeconds;

        emit PollCreated(pollId, title, newPoll.endTime);
    }

    function vote(uint256 pollId, uint256 optionIndex) public {
        Poll storage poll = polls[pollId];

        require(block.timestamp < poll.endTime, "Poll has ended");
        require(!poll.hasVoted[msg.sender], "Already voted!");
        require(optionIndex < poll.options.length, "Invalid option");

        poll.hasVoted[msg.sender] = true;
        poll.voteCounts[optionIndex]++;

        emit Voted(pollId, msg.sender, optionIndex);
    }

    function getWinner(uint256 pollId) public view returns (string memory) {
        Poll storage poll = polls[pollId];
        require(block.timestamp >= poll.endTime, "Poll still active");

        uint256 winningVotes = 0;
        uint256 winningIndex = 0;

        for (uint256 i = 0; i < poll.options.length; i++) {
            if (poll.voteCounts[i] > winningVotes) {
                winningVotes = poll.voteCounts[i];
                winningIndex = i;
            }
        }

        return poll.options[winningIndex];
    }

    function getVoteCount(uint256 pollId, uint256 optionIndex) 
        public view returns (uint256) {
        return polls[pollId].voteCounts[optionIndex];
    }
}