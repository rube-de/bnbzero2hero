* Players array dosen't need payable mod
* prize_winners array dosen't need payable mod
* Event should start with captial letter
* Event isn't clear
 

addNewPlayer func
* updates num_players even if not enough eth paiy
* misses to add msg.value to prizeAmount
* emit Events for every 50+ call ?

func pickWinner
* can be called from anyone
* can be called multiple times
* timestamp random number pick is gameable

func payout
* only lets you payout at specifc balance => you can send eth to contract via selfdestruct and eth would be locked forever
* amountToPay is bassed on winner array length /100 not on how much is in the pool => eth will be stuck in contract

func distributePrize
* i <= length will get out of bounds
