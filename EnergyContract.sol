pragma solidity ^0.8.0;

import "./MyNFT.sol";

contract mintEnergyNFT {

/**
Recognized renewable energy types
 */
  enum Energy { SOLAR, WIND, HYDROELECTRIC }

/**
energyData of the NFT including the amount of power corresponding to the production, 
medium of energy production, location of energy production, microgrid where the
energy was produced */
  struct energyData {
    uint kilowatt;
    Energy medium;
    string location;
    uint microGridNumber;
    bool listed;
    uint price;
  }

/**
nftToValue is a mapping of the nftID to the energy data associated which can be 
evaluated for renewable energy credits.
 */
  mapping (uint => energyData) public nftToValue;

/**
Information sent by an Oracle of the validated information from devices recording
energy throguhput into the grid. Assume that this data collection is using hardware
such as IntelSGX so that no malicious actors can tamper with the hardware.
 */
  struct deviceData {
    uint kilowatt;
    string company;
    uint timestamp;
    string energy;
    uint microGridNumber;
  }

/**
Array of json files which correspond to NFT metadata
 */
  string[] coins;

/**
Triggered event that occurs for each renewable credit type and location. 
 */
  function _createNFT(uint kilowatt, string memory company, uint timestamp, 
  string memory energy, uint microGridNum, deviceData d) internal onlyOwner {
    require(company == d.company);
    require(kilowatt == d.kilowatt);
    require(energy == d.energy);
    require(timestamp == d.timestamp);
    require(microGridNum == d.microgridNumber);
    energyData e = energyData(kilowatt, energy, company, microGridNum, false);
    nftToValue[_mintNFT(msg.sender, url)] = e;
  }

/**
Allows the owner to list the NFT on our marketplace 
*/
  function listNFT(uint id, uint price) external onlyOwner {
    energyData data = nftToValue[id];
    data.listed = true;
    data.price = price;
  }

/**
Facilitates the transaction between the purchaser and owner
 */
  function buyNFT(uint id, uint price) external listedNFT {
    _transferFunds(ownerOf(id));
    ownerOf(id) = buyer;
  }

/**
redeemNFT is called by an owner of an NFT for renewable energy credits and converts
the NFT to renewable energy credits which are handled internally to give a tax
credit to the company. 
 */
  function redeemNFT(uint id) external returns (uint){
    uint c = nftToValue[id].kilowatt;
    uint value = valuation(nftToValue[id]);
    _renewableEnergyCredits(nftToValue[id].owner, c);
    ownerOf(id) = Null;
    nftToValue[id] = 0;
    return value;
  }

/**
Mints an NFT when redeemed signifying the conversion to renewable energy credits
 */
  function _renewableEnergyCredits (address recipient, uint c) private {
    coin = coins[c];
    _mintNFT(recipient, coin);
  }

/**
Determines the value of an NFT
 */
  function valuation (energyData m) public returns (uint) {
    //Query oracle for current conversion rate for this place, type, microgrid, 
    //and quantity of energy
    return Query.params(m).value;
  }

/**
Transfers money when purchasing an NFT
 */
 function _transferFunds(address seller) private {
   seller.transfer(msg.sender.balance);
 }

/**
Requires only the owner of the NFT can perform the function
 */
  modifier onlyOwner (uint id) {
    require(ownerOf(id) == msg.sender);
    _;
  }

/**
Requires that the buyer has enough funds and the NFT is listed
 */
  modifier listedNFT (uint id, uint price) {
    require(nftToSeller[id].listed == true);
    _;
  }
}