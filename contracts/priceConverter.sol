// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
        function getPrice() internal  view returns (uint256) {
        // get eth in usd price
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (
            ,
            /* uint80 roundId */
            int256 price,
            ,
            ,

        ) = /*uint256 startedAt*/
            /*uint256 updatedAt*/
            /*uint80 answeredInRound*/
            priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConventionalRate(uint256 ethAmount)
        internal 
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
}