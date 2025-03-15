

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint256 public minusd = 5e18;
    mapping (address => uint256) public addressToAmountFunded;
    function fund() public payable {
        require(getConversionRate(msg.value) > minusd, "not enough eth");
        addressToAmountFunded[msg.sender] += msg.value;
    }
    // function withdraw() public {}

    function getPrice() public view returns(uint256) {
        // add 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=priceFeed.latestRoundData();
        //returns price of usd in terms of eth
        return uint256(price * 1e10);
    }
    function getConversionRate(uint ethamount) public view returns (uint256){
        uint256 price = getPrice();
        uint256 priceinusd = (price * ethamount)/1e18;
        return priceinusd; 

    }
}