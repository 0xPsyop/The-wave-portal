// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract WavePortal{

	uint256 totalWaves;

	uint256 private seed;

	event newWave(address indexed from, uint256 timestamp, string message);

	mapping(address=> uint256) public lastWavedAt;

	struct Wave {
       address waver;
       string msg;
       uint timestamp;
	}

    Wave[] waves;

	constructor() payable {
          console.log("hello web3 world");

          seed = (block.timestamp + block.difficulty) % 100;
	}
    
	function wave(string memory _message) public {

	require(lastWavedAt[msg.sender] + 5 minutes < block.timestamp,
            "Wait 5m");

	lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("has waved", msg.sender);

        waves.push(Wave(msg.sender, _message , block.timestamp));

        seed = (block.timestamp + block.difficulty + seed) % 100;

        console.log("Random # generated: %d", seed);

        

        if(seed <= 50) {
        	console.log("%s won!", msg.sender);

        	 uint256 prizeAmount = 0.001 ether;
           require(prizeAmount <= address(this).balance,
        "Trying to withdraw more money than the contract has.");

        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
        }

       emit newWave(msg.sender, block.timestamp, _message); 
	}
    
    function getAllWaves() public view returns(Wave[] memory) {
      return waves;
    }

	function getTotalWaves() public view returns(uint) {
      return totalWaves;
	}
}