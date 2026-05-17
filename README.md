# Polling System Smart Contract

## Overview
A Polling System Smart Contract built in Solidity with complete voting functionality. Developed as part of CodeAlpha Blockchain Development Internship.

## Features
- Create polls with custom title and options
- Time-based voting deadline
- Each address can vote only once
- Prevent double voting
- Determine winner after poll ends
- Check vote count for each option

## Technologies Used
- Solidity ^0.8.0
- Remix IDE
- Ethereum Blockchain

## How It Works
1. User creates poll with title, options and duration
2. Voters cast their vote before deadline
3. Each address can only vote once
4. After deadline winner is determined automatically

## How to Run
1. Open Remix IDE (remix.ethereum.org)
2. Copy PollingSystem.sol code
3. Compile with Solidity compiler
4. Deploy on Remix VM
5. Create poll with createPoll function
6. Vote using different accounts
7. Check winner after time ends

## Example
- Title: "Favorite Language"
- Options: ["Python", "Solidity", "JavaScript"]
- Duration: 120 seconds
- Vote → Check Results → Winner announced ✅
