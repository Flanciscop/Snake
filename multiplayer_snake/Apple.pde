public class Apple
{
  //attributes
  PVector location;
  PVector size;
  color c;
  
  //constructor
  public Apple(float x, float y, float w, float h, color c)
  {
    location = new PVector(x,y);
    size = new PVector(w,h);
    this.c=c;
  }
  
  public void spawnApple()
  {
    fill(c);
    rect(location.x,location.y,size.x,size.y);;
  }
  
}
