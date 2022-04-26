class Bullet {

  int x;
  int y;
  int d;
  int c;
  int speed; 

  int topBound;
  int bottomBound;
  int leftBound;
  int rightBound;
  
  boolean hasHit;

  //constructing
  Bullet( int startingX, int startingY, int startingD) {

    x = startingX;
    y = startingY;
    d = startingD;

    speed = 3;

    topBound = y;
    bottomBound = y + d;
    leftBound = x;
    rightBound = x + d;
    
    hasHit = false; 
  }

  void render () {
    fill(255, 255, 255);
    circle(x, y, d);
  }

  void move() {
    x += speed;
  }

  void resetBoundaries() {
    topBound = y;
    bottomBound = y + d;
    leftBound = x;
    rightBound = x + d;
  }
}
