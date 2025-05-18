// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import {PriceConverter} from "./priceConverter.sol";

contract FundMe {

    using PriceConverter for uint256; // assign library for all uint256 type data

    uint256 public MinimumUSD = 5e18;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund () public payable {
        require(msg.value.getConventionalRate() >= MinimumUSD, "didn't send enough eth"); // reverts
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value ;
    }

    function withdraw () public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0); // reset array to zero

        // payable(msg.sender).transfer(address(this).balance); // transfer method

        // bool sendSuccess = payable(msg.sender).send(address(this).balance); // send method
        // require(sendSuccess, "send failed");

        // this is the bestpractice
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); // call method, with destructuring
        require(callSuccess, "call failed");

    }

    modifier onlyOwner () {
        require(msg.sender == owner, "you're not the owner" );
        _;
    }


}
