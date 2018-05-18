pragma solidity 0.4.23;

contract Casino {
    address public owner;
    uint256 public minimumBet;
    uint256 public totalBet;
    uint256 public numberOfBets;
    uint256 public maxAmountOfBets = 100;
    address[] public players;

    struct Player {
        uint256 amountBet;
        uint256 numberSelected;
    }

    mapping(address => Player) public playerInfo;

    constructor(uint256 _minimumBet) public {
        owner = msg.sender;
        if(_minimumBet != 0) minimumBet = _minimumBet;
    }

    function kill() public {
        if(msg.sender == owner) selfdestruct(owner);
    }

    function bet(uint256 numberSelected) public payable {
        require(!checkPlayerExists(msg.sender));
        require(numberSelected >= 1 && numberSelected <= 10);
        require(msg.value >= minimumBet);

        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].numberSelected = numberSelected;
        numberOfBets++;
        players.push(msg.sender);
        totalBet += msg.value;
    }

    function checkPlayerExists(address player) public view returns(bool) {
        for(uint256 i = 0; i < players.length; i++){
            if(players[i] == player) return true;
        }
        return false;
    }
}