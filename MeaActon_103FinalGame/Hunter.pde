class Hunter {

  //player vars
  int hunterX;
  int hunterY;
  int speed;
  int hunterSize;
  int hunterColor;

  int xSpeed;
  int ySpeed;

  int hTop;
  int hBottom;
  int hRight;
  int hLeft;

  int health;

  boolean isColliding;
  boolean isDead;

  //constructing fuction
  Hunter(int startingX, int startingY, int startingSize, color startingC) {
    hunterX = startingX;
    hunterY = startingY;
    hunterSize = startingSize;
    hunterColor = startingC;

    speed = 2;

    hTop = hunterY;
    hBottom = hunterY + hunterSize;
    hRight = hunterX + hunterSize;
    hLeft = hunterX;

    isColliding = false;
    isDead = false;

    health = 5;
  }

  //draw my player
  void render() {
    //fill(hunterColor);
    image(hunterImg, hunterX, hunterY, 50, 50);
  }

  //making hunter move towards player
  void follow(Player aDeer) {
    if (aDeer.playerX > hunterX) {
      hunterX = hunterX + speed;
    }
    if (aDeer.playerX < hunterX) {
      hunterX = hunterX - speed;
    }
    if (aDeer.playerY < hunterY) {
      hunterY = hunterY - speed;
    }
    if (aDeer.playerY > hunterY) {
      hunterY = hunterY + speed;
    }
  }

  //detects if the hunter collides with the deer
  void deerCollision(Player aDeer) {
    if (hLeft < aDeer.pRight && hBottom > aDeer.pTop) {
      if (hRight > aDeer.pLeft && hBottom > aDeer.pTop) {
        if (hRight > aDeer.pLeft && hTop < aDeer.pBottom) {
          if (hLeft < aDeer.pRight && hTop < aDeer.pBottom) {
            if (aDeer.health > 0){
              aDeer.health = aDeer.health - 1; 
            } else if (aDeer.health <= 0){
              aDeer.hasDied = true;
            }
          }
        }
      } 
    } 
  }

  void updateBoundaries() {
    hTop = hunterY;
    hBottom = hunterY + hunterSize;
    hRight = hunterX + hunterSize;
    hLeft = hunterX;
  }

  void isHit(Bullet aBullet) {
    if (hLeft < aBullet.rightBound && hBottom > aBullet.topBound) {
      if (hRight > aBullet.leftBound && hBottom > aBullet.topBound) {
        if (hRight > aBullet.leftBound && hTop < aBullet.bottomBound) {
          if (hLeft < aBullet.rightBound && hTop < aBullet.bottomBound) {
            //setting has hit = to true 
            aBullet.hasHit = true;
            //makes it to where if the enemy is hit, then remove one health
            if (health > 0) {
              health = health - 1;
              //if the enemy's health is equal to 0 then the player is dead
            } else if (health <= 0){
              isDead = true;
            }
          } else {
            isDead = false;
          }
        } else {
          isDead = false;
        }
      } else {
        isDead = false;
      }
    } else {
      isDead = false;
    }
  }
}
