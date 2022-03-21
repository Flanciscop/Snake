public class Snake
{
  //attributes
  PVector[] location;
  PVector size;
  color c;
  PVector move;
  int xdirection,ydirection;
  
  
  //constructor
  public Snake(float x, float y, float w, float h, color c, float xmove, float ymove, int xdirection, int ydirection)
  {
    location = new PVector[20];
    location[0] = new PVector(x,y);
    /*for(int i = 1; i < location.length; i++)  {
      location[i]= new PVector(0+i*20,0+i*20);
    }*/
    size = new PVector(w,h);
    this.c = c;
    move = new PVector(xmove,ymove);
    this.xdirection = xdirection;
    this.ydirection = ydirection;
  }
  
  
  //spawn snake  
  public void spawnBody(int snakeLength)
  {
    fill(c);
    for(int i = 0; i < snakeLength ; i++){
      rect(location[i].x,location[i].y,size.x,size.y);
    }
  }
  
  //snake follow itself
  public void follow(int snakeLength)
  {
    for(int i = snakeLength-1; i >= 1 ; i--)  {
      //set location of new part of snake equal to position of previous in array
      location[i].x=location[i-1].x;
      location[i].y=location[i-1].y;  
    }
  }
  
  //snake collide with itself
  public void selfHit(int snakeLength, int endGame)
  {
    for(int i = 1; i < snakeLength; i++){
      if(location[0].x + (xdirection*move.x) == location[i].x 
      && location[0].y + (ydirection*move.y)  == location[i].y)  {
        endGame = 1;
        winGame(endGame);
      }
    }
  }
  
  //when snake hits the walls
  public void wallHit(int blockSize, int endGame)
  {
    if(location[0].x == width
    || location[0].x == 0 - blockSize
    || location[0].y == height
    || location[0].y == 0 - blockSize)  {
      endGame = 1;
      winGame(endGame);
    }
  }
  
  //move the snake
  public void moveSnake()
  {
    //if its moving to the right it cant move to the left
    if(xdirection == 1){
      delay(150);
      location[0].x += move.x;
      if (keyCode == UP) {
        ydirection= -1;
        xdirection = 0;
        location[0].x -= move.x;//so it doesnt move diagonally
      } else if (keyCode == DOWN) {
        ydirection = 1;
        xdirection = 0;
        location[0].x -= move.x;
      } 
    }
    // if it moves to the left then it cant move to the right
    if(xdirection == -1){
      delay(150);
      location[0].x -= move.x;      
      if (keyCode == UP) {
        ydirection = -1;
        xdirection = 0;
        location[0].x += move.x;
      } else if (keyCode == DOWN) {
        ydirection = 1;
        xdirection = 0;
        location[0].x += move.x;
      }
    }
    // if it moves up then it cant move down
    if(ydirection == -1){
      delay(150);
      location[0].y -= move.y;
      if (keyCode == LEFT) {
        xdirection = -1;
        ydirection = 0;
      } else if (keyCode == RIGHT) {
        xdirection = 1;
        ydirection = 0;
      }
    }
    // if its moving down then it cant move up
    if(ydirection == 1){
      delay(150);
      location[0].y += move.y;
      if (keyCode == LEFT) {
        xdirection = -1;
        ydirection = 0;
      } else if (keyCode == RIGHT) {
        xdirection = 1;
        ydirection = 0;
      }
    }
  } 
}
