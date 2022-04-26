class Tree {

  //tree variables
  int treeX;
  int treeY;
  int treeSize;
  color treeColor;

  //tree hit box variable
  int tTop;
  int tBottom;
  int tRight;
  int tLeft;
  
  //declare image vars
  PImage treeImg;

  Tree(int startingX, int startingY, int startingSize, int startingColor) {
    treeX = startingX;
    treeY = startingY;
    treeSize = startingSize;
    treeColor = startingColor;
    
    //tree collision detection
    tTop = treeY;
    tBottom = treeY + treeSize;
    tRight = treeX + treeSize;
    tLeft = treeX;
    
    treeImg = loadImage("tree.jpg");
  }
  
  void render(){
   image(treeImg, treeX, treeY, 150,150);
  }
  
  
  //this portion still needs to be fixed but I am working on it!!!
  void playerCollision(Player aDeer){
    if (aDeer.pTop < tBottom && aDeer.pBottom > tTop){
      if (aDeer.pRight > tLeft && aDeer.pLeft < tRight){
      aDeer.moveUp = false;
      aDeer.moveDown = false;
      aDeer.moveRight = false;
      aDeer.moveLeft = false;
      //aDeer.playerX = tRight;
      aDeer.playerY = tBottom;
      }
    }
  }
  
  void enemyCollision(Hunter aEnemy){
    if (aEnemy.hTop < tBottom){
     aEnemy.speed = 0; 
    }
  }
  
}
