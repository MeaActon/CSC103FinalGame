//imports sound files
import processing.sound.*;
SoundFile pew;
SoundFile backgroundMusic;

//declare image vars 
PImage deerImg;
PImage hunterImg;
PImage woodImg;
PImage startImg;
PImage deadDeerImg;
PImage winScreenImg;

//calling class vars
Player deer;
Tree tree; 
Tree tree2;
Tree tree3;
Tree tree4;
Tree tree5;

//bullet arraylist to draw my bullets
ArrayList<Bullet> bulletList;
ArrayList<Hunter> enemyList;

//int for start and win/lose screens
int state;

void setup () {
  size(1200, 650);

  //calling my deer
  deer = new Player(100, 100, 50, color(255, 255, 0));
  //calling my tree obstacle
  tree = new Tree(width/2 - 100, height/2, 50, color(42));
  tree2 = new Tree(0, 0, 50, color(42));
  tree3 = new Tree(width-150, 0, 50, color(42));
  tree4 = new Tree(0, height-150, 50, color(42));
  tree5 = new Tree(width-150, height-150, 50, color(42));
  
  
  //calling bullets and enemies
  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Hunter>();
  enemyList.add(new Hunter(width - 50, 0, 50, color(255, 0, 0)));
  enemyList.add(new Hunter(100, 0, 50, color(255, 0, 0)));
 // enemyList.add(new Hunter(width - 50, 600, 50, color(255, 0, 0)));
  //enemyList.add(new Hunter(100, 600, 50, color(255, 0, 0)));

  //sound file for my shooting sound
  pew = new SoundFile(this, "pew.wav");
  pew.rate(2.0); //determines the speed of the sound
  pew.amp(1); // determines the volume of the sound
  //sound file for background music
  backgroundMusic = new SoundFile(this, "background.wav");

  startImg = loadImage("startScreen.jpg");
  startImg.resize(1200, 650);
  hunterImg = loadImage("hunter.jpg");
  woodImg = loadImage("woods.jpg");
  woodImg.resize(1200, 650);
  deadDeerImg = loadImage("deadDeer.jpg");
  deadDeerImg.resize(1200,650);
  winScreenImg = loadImage("winScreen.jpg");
  winScreenImg.resize(1200,650);

  state = 0;
}

void draw () {
  //set my background to 
  background(#9b673c);
  
  if (key == 'r'){
  if (backgroundMusic.isPlaying() == false){
   backgroundMusic.play();
  }
 }

  switch (state) {
  case 0:
    background (startImg);
    textSize(75);
    fill(#000000);
    text("Press 'r' to start", width/4, height/1.01);
    break;

  case 1: 
    background(winScreenImg);
    textSize(50);
    fill(#000000);
    text("You Survived Hunting Season!!", width/4, height/8);
    textSize(25);
    fill(#000000);
    text("Press 'r' to restart", width/4, height/1.01);
    break;

  case 2:
    background(deadDeerImg);
    textSize(100);
    fill(#000000);
    text("You Died", width/8, height/4);
    textSize(25);
    fill(#000000);
    text("Press 'r' to restart", width/8, height/1.01);
    break;

  case 3:
    //render my trees
    tree.render();
    tree.playerCollision(deer);
    tree2.render();
    tree2.playerCollision(deer);
    tree3.render();
    tree3.playerCollision(deer);
    tree4.render();
    tree4.playerCollision(deer);
    tree5.render();
    tree5.playerCollision(deer);
    
    //render and move deer
    deer.render();
    deer.move();
    deer.wallDetect();
    deer.updateBoundaries();
    if(deer.hasDied == true){
      setup();
      state = 2;
    }
   println(deer.health);

    //enemy render and move
    for (Hunter aEnemy : enemyList) {
      aEnemy.render();
      aEnemy.follow(deer);
      aEnemy.deerCollision(deer);
      aEnemy.updateBoundaries();
      //if (aEnemy.isColliding) {
      //check to see if enemy and player are colliding
      //  println("colliding");
      //} else {
      //  println("not colliding");
      //}
      // println(aEnemy.health);
    }
    if (enemyList.size() == 0){
      setup();
      state = 1;
    }

    //render and move bullet
    for (Bullet aBullet : bulletList) {
      aBullet.render();
      aBullet.move();
      aBullet.resetBoundaries();
      for (Hunter aEnemy : enemyList) {
        aEnemy.isHit(aBullet);
      }
    }

    //removes my enemy from the array list
    for (int i=enemyList.size()-1; i>=0; i--) {
      if (enemyList.get(i).isDead == true) {
        enemyList.remove(i);
      }
    }

    //removes the bullet that hits the enemy from the array list
    for (int i=bulletList.size()-1; i>=0; i--) {
      if (bulletList.get(i).hasHit == true) {
        bulletList.remove(i);
      }
    }
    break;
  }
}

//moves player with arrow keys and bullets
void keyPressed () {
  if (keyCode == UP) {
    deer.moveUp = true;
  }
  if (keyCode == DOWN) {
    deer.moveDown = true;
  }
  if (keyCode == LEFT) {
    deer.moveLeft = true;
  }
  if (keyCode == RIGHT) {
    deer.moveRight = true;
  }

  //shoots a bullet when the spacebar is pressed
  if (key == ' ') {
    bulletList.add(new Bullet(deer.playerX + deer.playerSize/2, deer.playerY + deer.playerSize/2, 10));
  }
  //if the space bar is pressed then play shooting sound
  if (key == ' ') {
    if (pew.isPlaying() == false) {
      pew.play();
    }
  }

  // if r key is pressed then start/restart the game!
  if (key == 'r') {
    setup();
    state = 3;
  }
}


//makes sure the player stops moving when the key is released
void keyReleased() {
  if (keyCode == UP) {
    deer.moveUp = false;
  }
  if (keyCode == DOWN) {
    deer.moveDown = false;
  }
  if (keyCode == LEFT) {
    deer.moveLeft = false;
  }
  if (keyCode == RIGHT) {
    deer.moveRight = false;
  }
}
