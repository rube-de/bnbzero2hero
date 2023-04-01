# Setup Treasure Hunt
Fund 3 wallets with test eth

Wallet 1
1. Deploy Treasure Contract with lock (bytes32)
2. Make tranfser to yourself with calldata which is the key

Wallet 2
1. Deploy Camp Contract
2. Call hideCooridnates with the address of the Treasure Contract

Wallet 3
1. Deploy TreasureMap Contract with the Camp Contract Address