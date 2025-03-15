// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import {PriceConverter} from "PriceConvertor.sol";

contract FundMe{
    using PriceConverter for uint256;
    uint256 public minusd = 5e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;
    address public owner;

    constructor(){
        owner = msg.sender;
    }
    function fund() public payable {
        require(msg.value.getConversionRate() > minusd, "not enough eth");
        addressToAmountFunded[msg.sender] += msg.value;
    }
     function withdraw() public onlyOwner {
        require(msg.sender==owner, "must be owner");
        for(uint256 index = 0; index<funders.length; index++){
            address funder = funders[index];
            addressToAmountFunded[funder]=0;
        }
        funders = new address[](0);
        ////
        (bool callsuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callsuccess, "callFailed");
        // idek kn0w whta this is it just send of recieve etherium ir blockchain currency token
        ////
     }
     modifier onlyOwner(){
        require(msg.sender==owner, "not owner");//first see whjether this is yes
         _;//then do whatwever else in the fucniton
     }

   
}