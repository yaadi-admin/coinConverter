//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// import an interface which defines functions without their implementation, which leaves inheriting contracts to define the actual implementation.

// AggregatorV3Interface defines that all V3 data Aggregators have the function latestRoundData.

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract PriceConsumerV3 {

AggregatorV3Interface internal priceFeed;

address public owner;

// Network: Sepolia Ethereum Testnet

// Aggregator: GBP/USD

// Address: 0x91FAB41F5f3bE955963a986366edAcff1aaeaa83

// see Chainlink's price feed addresses for other pairs

// The constructor initializes an interface object that uses AggregatorV3Interface and connects to a proxy aggregator contract that is already

// deployed at the address provided. The interface allows your contract to run functions on the deployed aggregator contract.

constructor() {

priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

owner = msg.sender;

}


modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can execute this function.");
        _;
    }

// Returns the latest price conversion between GBP and USD.

// Note: price feed uses 8 decimals when returning fiat values (ex: USD),

// and 18 decimals when returning token values (ex: ETH)

// The function calls your priceFeed object and runs the latestRoundData() function.

// When you deploy the contract, it initializes the priceFeed object to point to the aggregator at the provided address.

// The address is the proxy contract address for the Sepolia GBP/USD data feed.

// Your contract connects to that address and executes the function.

// The aggregator connects with numerous oracle nodes and aggregates the pricing data from the nodes.

// The response from the aggregator includes several variables, but getLatestPrice() returns only the price variable.

function getLatestPrice() public view returns (string memory) {


(/* uint80 roundID*/,

int price,

/*uint startedAt*/,

/*uint timeStamp*/,

/*uint80 answeredInRound*/) = priceFeed.latestRoundData();


uint256 convertValue = uint256(price) / 100000000;

return Strings.toString(convertValue);

}

// function getLatestPrice() public view returns (string memory) {
//     (, int price, , , ) = priceFeed.latestRoundData();
//     uint8 decimals = priceFeed.decimals();
//     uint256 adjustedPrice = uint256(price) * (10 ** (18 - decimals)) / 1e8;
//     return string(abi.encodePacked(adjustedPrice));
// }




}