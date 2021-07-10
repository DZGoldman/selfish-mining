//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract TheVirtueOfSelfishness {

  mapping(uint => address) blockNumberToCoinbase;

  fallback() external payable {}


  function recordCoinbase() external {
    blockNumberToCoinbase[block.number] = block.coinbase;
  }

  function claimSelfishPrize() external {
    require(address(this).balance > 0, "NOTHING_TO_CLAIM_HERE" );
    uint blocksMined = 1;
    uint blockNumber = block.number -1;
    while ( blockNumberToCoinbase[blockNumber] == block.coinbase ){
      blocksMined ++;
      blockNumber--;
    }
    require(blocksMined > 40, "NOT_SELFISH_ENOUGH");
    block.coinbase.transfer( (address(this).balance / 2 ));

  }


}
