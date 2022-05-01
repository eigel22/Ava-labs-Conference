2 solidity files are submitted:

- Energy Contract: Written from scratch by Ashley Cooray and Ethan Igel.
- Functionality: Facilitates the transaction of energy NFTs. Mints NFTs on
production of clean energy in the grid. Allows for buying and listing of the
NFTs on our marketplace. Determines valuation in Renewable Energy Credits by
querying the oracle on current governmental policies and prices.

- MyNFT: sourced online and modified to deploy on the Fuji test net chain. JSON
files created for minting energy specific NFTs with corresponding images


Next Steps:
- Determine which oracle is being used to validate the hardware meters and bring
the information into the blockchain about energy production
- Write a script to automate the process of minting NFTs when energy is produced
- Develop a fronted marketplace for buying and selling REC NFTs
- Write an algorithm for the dynamic pricing of NFTs through market demand and
and governmental policies


Improvements:
- Query function to the oracle which determines the current valuation in
Renewable Energy Credits in the marketplace
- Query function to the oracle to retrieve data from companies such as Grid+
which have the hardware technology in place to bring energy production data into
the blockchain
- Lowering gas costs by minimizing writes to the blockchain. Currently storing
all information needed for valuation on the blockchain as a mapping to the NFT
id, but this information is costly to continue writing.
  - How can information be modeled in a way that the number of writes is minimized
  yet the valuation of the NFT is dynamic in the demand of the marketplace and
  the governmental policies.
- Introducing other forms of renewable energy such as hydrogen or geothermal
which are not transmitted on the microgrid