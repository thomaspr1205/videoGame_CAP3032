import game2dai.entities.*;
import game2dai.entityshapes.ps.*;
import game2dai.maths.*;
import game2dai.*;
import game2dai.entityshapes.*;
import game2dai.fsm.*;
import game2dai.steering.*;
import game2dai.utils.*;
import game2dai.graph.*;

Menu gameMenu;
boolean menu, levels, characters, levelTesting;

World world;
StopWatch sw;
Domain wd;

Character player1, player2;
CharacterSprite blue, green, red, yellow;

// Vector2D target = new Vector2D();
BitmapPic view;
double x;
double y;
int prevKey;
Level levelTest;
int player = 1;

void setup() {
  size(1000, 700);

  // Library setup
  world = new World(width, height);
  sw = new StopWatch();
  wd = new Domain(0, 0, 1000, 700);

  // Menu setup
  PImage menuImg = loadImage("data/menuBackground.jpg");
  gameMenu = new Menu(menuImg, "Dino Dash: Escape from Extinction");
  menu = true;

  // Load Charcter Sprites
  loadSprites();

  // Default Characters
  gameMenu.character1 = red.jumpRightView;
  gameMenu.character2 = blue.jumpRightView;

  // Level setup
  createLevels();

  // Charcters setup
  createCharacters();
  player1.worldDomain(wd, SBF.REBOUND);
  player2.worldDomain(wd, SBF.REBOUND);


  sw.reset();
}

public void draw() {
  double elapsedTime = sw.getElapsedTime();

  // Menu
  if(menu){
    gameMenu.display();
  }
  else{
    if(levels){
      gameMenu.displayLevels(); 
    }
    else if(characters){
      gameMenu.displayCharacters(); 
    }
    else if(levelTesting){
      background(233, 123, 100);
      levelTest.display();
      moveCharacter(player1);
      moveCharacter(player2);  
    }
  }
  world.update(elapsedTime);
  world.draw(elapsedTime);
}

// ===== I/O controllers =======
void mouseClicked() {

  // ========== navigation controller =============
  if(gameMenu.home.rectOver){
    print("home button selected\n");
    levels = false;
    characters = false;
    menu = true;
    gameMenu.home.rectOver = false;
  }
  else if (gameMenu.play.rectOver) {
    print("play button clicked\n");
    levels = true;
    menu = false;
    gameMenu.play.rectOver = false;
  }
  else if (gameMenu.charSel.rectOver) {
    print("characters button clicked\n");
    characters = true;
    menu = false;
    gameMenu.charSel.rectOver = false;
  }
  else if (gameMenu.controls.rectOver) {
    print("controls button clicked\n");
  }

  //============= Character Selection ==============
  else if(gameMenu.red.rectOver){
    println("red character selected - player " + player);
    characterSelection(red);
    gameMenu.red.rectOver = false;
  }
  else if(gameMenu.blue.rectOver){
    println("blue character selected - player " + player);
    characterSelection(blue);
    gameMenu.blue.rectOver = false;
  }
  else if(gameMenu.green.rectOver){
    println("green character selected - player " + player);
    characterSelection(green);
    gameMenu.green.rectOver = false;
  }
  else if(gameMenu.yellow.rectOver){
    println("yellow character selected - player " + player);
    characterSelection(yellow);
    gameMenu.yellow.rectOver = false;
  }

  // ============ Level Selection ================
  else if(gameMenu.lvl1.rectOver){
    println("level 1 selected");
    gameMenu.lvl1.rectOver = false;
    levelTesting = true;
    menu = false;
    levels = false;
    world.add(player1);
    world.add(player2);
  }
}

void keyPressed() {
  player1.handleInput(keyCode);
  player2.handleInput(keyCode);
}

// ======= Characters ============

void loadSprites(){
  red = new CharacterSprite("data/dinoRLeft.png",
                           "data/dinoRRight.png",
                           "data/dinoRLI1.png",
                           "data/dinoRRI1.png"
                            );
  blue = new CharacterSprite("data/dinoBLeft.png",
                           "data/dinoBRight.png",
                           "data/dinoBLI1.png",
                           "data/dinoBRI1.png"
                            );
  yellow = new CharacterSprite("data/dinoYLeft.png",
                           "data/dinoYRight.png",
                           "data/dinoYLI1.png",
                           "data/dinoYRI1.png"
                            );
  green = new CharacterSprite("data/dinoGLeft.png",
                           "data/dinoGRight.png",
                           "data/dinoGLI1.png",
                           "data/dinoGRI1.png"
                            );
}

void createCharacters(){
  x = 100;
  y = 600;
  player1  = new Character(this, x+50, y, red);
  player1.setKeys(37,38,39); //arrows
                
  player2  = new Character(this, x-50, y, blue);
  player2.setKeys(65,87,68);// wasd
}

void moveCharacter(Character dino){
  Vector2D target = new Vector2D();
  dino.gravity -= 1;
  if(dino.jumping && dino.gravity > 0){
    target.set(dino.x, dino.y);
    dino.y += 1;
  }
  else if(dino.gravity == 0){
    dino.jumping = false;
    dino.gravity = 100;
  }else{
    target.set(dino.x, height);
    dino.adjustDino = true;
  }

  dino.AP().arriveOn(target).wallAvoidOn();
  float speed = (float) dino.speed();
  float maxSpeed = (float) dino.maxSpeed();    
  if (speed > 1) {
    float newInterval = map(speed, 0, maxSpeed, 0.6, 0.04);
    dino.setAnimation(newInterval, 1);
  }
  else {
      dino.pauseAnimation();
  }
}

void characterSelection(CharacterSprite sprite){
  if(player == 1){
      gameMenu.character1 = sprite.jumpRightView;
      player1.setSprite(sprite);
      player = 2;
    }else{
      gameMenu.character2 = sprite.jumpRightView;
      player2.setSprite(sprite);
      player = 1;
    }
}


// ========= Levels ===========
void createLevels(){
  levelTest = new Level(this,0);
  // level1 = new Level(this,1);
  // level2 = new Level(this,2);
  // level3 = new Level(this,3);
}



