//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;
     uint256 mininmumUSD=50 * 1e18;
     mapping(address=>uint256) public addressToAmountFunded;

//where people who send fund addresses will be stored
     address[] public funders;
    function fund() public payable{
    //msg.value is considered frst parameter in any library fn so we don't have to pass value in fn argument
    require(msg.value.getConversionRate()>=mininmumUSD, "didn't send enough"); 
       funders.push(msg.sender);
    addressToAmountFunded[msg.sender]+=msg.value;
    }

    function withdraw() public{
        for(uint256 fIndex=0; fIndex<funders.length; fIndex++){
            address funderAddress=funders[fIndex];
            addressToAmountFunded[funderAddress]=0;
        }
    }
}


