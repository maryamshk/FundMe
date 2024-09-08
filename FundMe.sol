//allow people to fund collective good(etherium, polygon, avalanche, phantom) into this contract
//then owner of that contract can withdraw those funds

//get funds from users
// withdraw funds
// set minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

//import directly from github
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
contract FundMe{
     uint256 mininmumUSD=50;
    // to make fn payable w any currency, use payable keyword
    //like wallets can hold funds, contract addresses does too
    function fund() public payable{
    //to get how much value someone sending (msg.value) should be atleast 1 eth
    //money maths is done in terms of WEI
    // require(condition, revert err msg if condition not satisfied) 
    // reverting: undo any action before and send remaining gas back

    require(getConversionRate(msg.value)>=mininmumUSD, "didn't send enough"); //1e18=1*10**18   1eth in wei
    //to convert eth into usd, we'll use oracle and chainlink
    }

    function getPrice() public view returns(uint256){
//we need ABI and address to interact w cotract outside of this contract
// address  0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        //contract at this address is gonna have all functionslity of AggregatorV3Interface
        (,int256 value,,,)=priceFeed.latestRoundData();
//eth in terms of usd
// 3000.00000000     //8 decimal places where as msg.value is gonna be 18 decimal places
//to make them equal
     //typecasting to uint256
return uint256(value*1e10);  //1**10=10000000000  
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice=getPrice();
        uint256 ethAmountInUsd=(ethPrice*ethAmount)/1e18;
        return ethAmountInUsd;
    }

}


