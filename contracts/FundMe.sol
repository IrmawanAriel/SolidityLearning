// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

// import {PriceConverter} from "./priceConverter.sol";

contract FundMe {

    // using PriceConverter for uint256; // assign library for all uint256 type data

    uint256 public constant MinimumUSD = 5;

    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund () public payable {
        require(msg.value >= MinimumUSD, "didn't send enough eth"); // reverts
        // if(msg.value.getConventionalRate() <= MinimumUSD) {
        //    revert();
        // }
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

        // this is the bestpractice to transfer
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); // call method, with destructuring
         require(callSuccess, "call failed");
        //if(!callSuccess){
          //  revert();
        //}

    }

    modifier onlyOwner () {
        require(msg.sender == owner, "you're not the owner" );
        //if(msg.sender != owner){
        //    revert();
        //}
        _;
    }

    receive() external payable { // if theres no data send in transaction. default processing will go into fund function
        fund();
    }

    fallback() external payable {// if theres a data sended in transaction. defaul processing set to go to fund function
        fund();
     }


}
