contract CoinFlip {
  uint256 public consecutiveWins;
  uint256 public lastHash;
  bool public side;
  uint256 public blockValue;
  uint256 public coinFlip;
  uint256 public blockNumber;
  uint256 public FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  function CoinFlip() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    blockNumber = block.number -1;
    blockValue = uint256(block.blockhash(blockNumber));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    coinFlip = blockValue / FACTOR;
    side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}
