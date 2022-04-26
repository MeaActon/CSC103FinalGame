class Player {

  //player vars
  int playerX;
  int playerY;
  int speed;
  int playerSize;
  int playerColor;

  int xSpeed;
  int ySpeed;

  int pTop;
  int pBottom;
  int pRight;
  int pLeft;
  
  int health;

  boolean moveLeft;
  boolean moveRight;
  boolean moveUp;
  boolean moveDown;
  
  boolean hasDied;
  
  //declare image vars
  PImage deerImg;

  //constructing fuction
  Player(int startingX, int startingY, int startingSize, color startingC) {
    playerX = startingX;
    playerY = startingY;
    playerSize = startingSize;
    playerColor = startingC;

    xSpeed = 5;
    ySpeed = 5;

    //these are booleans to help a player move
    moveLeft = false;
    moveRight = false;
    moveUp = false;
    moveDown = false;

    pTop = playerY;
    pBottom = playerY + playerSize;
    pRight = playerX + playerSize;
    pLeft = playerX;
    
    deerImg = loadImage("deer.jpg");
    
    health = 50;
    hasDied = false;
  }

  //draw my player
  void render() {
    //fill(playerColor);
    image(deerImg, playerX, playerY, 50,50);
  }

  //move my player
  void move() {
    if (moveLeft == true) {
      playerX = playerX - xSpeed;
    } 
    if (moveRight == true) {
      playerX = playerX + xSpeed;
    }
    if (moveUp == true) {
      playerY = playerY - ySpeed;
    } 
    if (moveDown == true) {
      playerY = playerY + ySpeed;
    }
  }

//detects if my player hits the wall
  void wallDetect() {
    // detects wall detection for the right wall
    if (pRight > width) {
      moveRight = false;
      playerX = width - playerSize;
    }
    // wall detection for left wall
    if (pLeft < 0) {
      moveLeft = false;
      playerX = 0;
    }

    // wall detection for the bottom wall
    if (pBottom > height) {
      moveDown = false;
      playerY = height - playerSize;
    }
    // wall detection for top wall
    if (pTop < 0) {
      moveUp = false;
      playerY = 0;
    }
  }
  
  //updates boundaries of player as it moves across the screen
  void updateBoundaries(){
    pTop = playerY;
    pBottom = playerY + playerSize;
    pRight = playerX + playerSize;
    pLeft = playerX;
  }
}
