Homework 16 - Interacting with DeFi contracts
Interacting with DeFi
1. Set up an account on Quick Node so that you have access to an archive node.
2. Follow the instructions from the lesson to create a local fork of mainnet
3. Check that the block height and the chain ID is what you expect.
4. Connect to your local fork and use the contract details for Pancake Swap, make a call to the factory function to get the address of the factory contract, check this by reading the same function on Bscscan.
5. Write some unit tests, as if you were testing the various contracts. Your tests should include
  1. Interact with the pair contract for LEGO and BUSD, what are the reserves and when were they updated ?
  2. Impersonate an address such as this one : 0xffefE959d8bAEA028b1697ABfc4285028d6CEB10
  3. obtain some LEGO
  4. Interact with the router contract to swap some LEGO for BUSD by using the swap function