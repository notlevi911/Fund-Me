

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConverter{
     function getPrice() internal view returns(uint256) {
        // add 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=priceFeed.latestRoundData();
        //returns price of usd in terms of eth
        return uint256(price * 1e10);
    }
    function getConversionRate(uint ethamount) internal view returns (uint256){
        uint256 price = getPrice();
        uint256 priceinusd = (price * ethamount)/1e18;
        return priceinusd; 

    }
}