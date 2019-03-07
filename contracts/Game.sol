pragma solidity ^0.5.0;

contract Game {
    uint8 public boardSize = 3; 

    address[3][3] board;

    address public playerOne;
    address public playerTwo;

    address activePlayer;

    constructor () public {
        playerOne = msg.sender;
    }

    function joinGame() public {
        assert(playerTwo == address(0));
        playerTwo = msg.sender;
        activePlayer = playerTwo;
    }

    function getBoard() public view returns(address[3][3] memory){
        return board;
    }

    function SetPosition(uint8 x, uint8 y) public {
        require(board[x][y] == address(0), "The position in the board is not free");

        //assert to ensure that no input is larger than the board size
        assert(x < boardSize);
        assert(y < boardSize);

        //ensures the player's turn
        require(msg.sender == activePlayer, "It is not the player's turn");

        //position is assigned to the sender
        board[x][y] = msg.sender; 

        for(uint8 i = 0; i < boardSize; i++) {
            if(board[i][y] != activePlayer){
                break;
            }
        }

        for( i = 0; i < boardSize; i++) {
            if(board[x][i] != activePlayer){
                break;
            }
        }

        if (x == y){
            for( i = 0; i < boardSize; i++) {
                if(board[i][i] != activePlayer){
                    break;
            }}

        }

        if((x+y) == boardSize+1){
            for (i = 0; i < boardSize; i++){
                if(board[i][(boardSize-1)-i] != activePlayer){
                    break;
                }

            }
        }

        if(activePlayer == playerOne){
            activePlayer = playerTwo;
        } else {
            activePlayer = playerOne;
        }
    }
}