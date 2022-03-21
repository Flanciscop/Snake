int current = millis();

// set up grid
int blockSize;
int h, w;

// spawn apples
Apple apple;
int x,y;

//spawn snake
Snake snake;
int snakeLength;

//players
Player player1 = new Player(1);
Player player2 = new Player(2);
int playerTurn = 1;

//end game
int endGame = 0;

void setup()
{
  //set window name
  surface.setTitle("Snake");
  
  //frameRate(8);
  //set up grid
  blockSize = 40;
  size(800, 800);
  h = 20;
  w = 20;
  
  //initial spawn snake  
  snake = new Snake(5*blockSize,10*blockSize,blockSize,blockSize,color(0,255,0),
  blockSize,blockSize, 1,0);
  
  //spawn apple
  //set random point
  randPoint();//checks snake position as well
  apple = new Apple(x*blockSize,y*blockSize,blockSize,blockSize,color(255,0,0));
  
  //determine how big the snake is
  snakeLength = 1;  
}


void draw()
{
  clear();
  //frameRate(5);
  //set up grid
  for(int i = 0; i < w; i++)  {
    for(int j = 0; j < h; j++)    {
      fill(0);
      rect(i*blockSize, j*blockSize, blockSize, blockSize);
    }    
  }
  player1.showTurn(playerTurn);
  
  //spawn apple  
  apple.spawnApple();
  
  //move snake
  snake.moveSnake();
  
  //spawn new body part
  snake.spawnBody(snakeLength);
  
  //follow snake
  snake.follow(snakeLength);
  
  //snake eats apple
  eat();
  
  // collision with borders
  snake.wallHit(blockSize, endGame);
  
  //collision with self
  snake.selfHit(snakeLength, endGame);
  
  //keep score()
  player1.score(snakeLength, player1, playerTurn);
  player2.score(snakeLength, player2, playerTurn);
}

public void eat()
{
  //snake eat apple
  if(snake.location[0].x == apple.location.x
    && snake.location[0].y == apple.location.y)  {
      // is the game over?
      if(snakeLength < snake.location.length) {
        // snake grows
        snakeLength +=1; 
        //initializes new location pvector
        snake.location[snakeLength-1] = 
        new PVector(snake.location[snakeLength-2].x,snake.location[snakeLength-2].y);
        //new apple position
        randPoint();
        //spawn new apple
        apple = new Apple(x*blockSize,y*blockSize,blockSize,blockSize,color(255,0,0));
      }
      else {
        endGame = 2;
        winGame(endGame);
      }      
  }
}

//random points to spawn apple
public void randPoint()
{
  x = int(random(blockSize,width-blockSize))/blockSize;
  y = int(random(blockSize,height-blockSize))/blockSize;
  //so apple and snake dont spawn in the same place
  for(int i =0; i < snakeLength; i++)  {
      while(x == snake.location[i].x && y == snake.location[i].y) {
        x = int(random(blockSize,width-blockSize))/blockSize;
        y = int(random(blockSize,height-blockSize))/blockSize;
      }
  }
}

//end the game/turn
public void winGame(int end)
{
    fill(255);
    textSize(50);
    // end for player 1
    if(playerTurn == 1){ 
      if(end == 1){ // that is, if they died before completing the snake
        if (current + 10000<millis()) {
          text("Better luck next time!", 110, 300);
          text("Your turn Player 2",125,400);
        }
        reset();
      } // if they completed the snake
      else if(end == 2) {
        text("You win!", 250, 300);
        text("Your turn Player 2",125,400);
      }
      reset();
  } 
  // end for player 2
  else if(playerTurn == 2) {
    if(end == 1 || end == 2)
    fill(255);
      //compares the two players scores
      if(player1.score == player2.score){
        text("Its a tie!", 250, 300);
        stop();
      }
      else if(player1.score > player2.score) {
        text("Player 1 wins!", 200, 300);
        stop();
      }
      else {
        text("Player 2 wins!", 200, 300);
        stop();
      }
  }
}

//reset the game for player 2
void reset()
{
  snakeLength = 1;
  endGame = 0;
  frameCount = -1;
  playerTurn = 2;
}
