public class Player
{
  //attributes
  int score;
  int turn;
    
  //constructor
  public Player(int turn)
  {
    this.turn=turn;
  }
  
  //methods
  
  //show score
  public void score(int snakeLength, Player player, int turn)
  {
    fill(255);
    textSize(25);
    if(this.turn == turn) {
      player.score = snakeLength-1;
    }
    text("Player "+ player.turn + " score: " + player.score, 30, 50*player.turn);
  }
  public void showTurn(int playerTurn)
  {
    fill(255);
    textSize(25);
    text("Player " + playerTurn + "'s turn", 500,50);
  }
  
}
