pragma solidity ^0.4.17;
contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
        
    }
    
    // public because any one can call this function body ..
    // we someone calls this function he have to send some amount of ether.so it will be payable.
    function enter() public payable{
        // global function ..  is used for validation.
        require(msg.value >= .02 ether);
        
        // get access to the person who has send a transaction to this function. 
        // we can make use of the msg global variable.
        players.push(msg.sender);
    }
    // Generate random number .. we don't any one to call this function
    function random() private view  returns (uint) {
        // making use of global vaule.. this line returns a hash w.. we have to cast it..
     return  uint(keccak256(block.difficulty , block.timestamp , players));
        
    }
   
    function pickWinner() public restricted {
        // var to store the index of the winner .. 
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        // new dynamic empty array of address 
        players = new address[](0);
    } 
     modifier restricted(){
        require(msg.sender == manager);
        _;
    }
    function getPlayers() public view returns (address[]) {
        return players;
        
    }
}
