
import processing.sound.*;

Menu gameMenu;

boolean menu, levels, characters, controls, credits, P1, P2;
boolean lvl1Selected,lvl2Selected,lvl3Selected,lvl4Selected;

Player player1, player2;
CharacterSprite blue, green, red, yellow;

Level lvl1,lvl2,lvl3,lvl4;
float px = 200;
float py = 300;
float vx = 0;
float vy = 0;
float ax = 0;
float ay = 0;
int player = 0;

boolean[] keys = {false, false, false, false, false, false};
boolean moving1 = false, moving2 = false;
boolean loadlvl1 = false;
boolean loadlvl2 = false;
boolean loadlvl3 = false;
boolean loadlvl4 = false;

boolean jumping1 = false, jumping2 = false;
boolean grounded1 = false, grounded2 = false;

// Sound
SoundFile file, levelSelection;

void setup() {
  size(1000, 700);

  // Menu setup
  PImage menuImg = loadImage("data/menuBackground.jpg");
  gameMenu = new Menu(menuImg, "Dino Dash: Escape from Extinction");
  menu = true;
  
  // Sound
  loadSounds();

  // Load Charcter Sprites
  loadSprites();

  // Default Characters
  gameMenu.character1 = red.jumpRightView;
  gameMenu.character2 = blue.jumpRightView;

  // Level setup
  createLevels();

  // Charcters setup
  createCharacters();

}

public void draw() {

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
    else if(controls) {
      gameMenu.displayControls();
    }
    else if(credits) {
      gameMenu.displayCredits();
    }
    else if(lvl1Selected){
      if(loadlvl1 == false) {
        println("loading map 1");
        levelSetUp(50,680,70,680, lvl1,color(233,121,123),0,0,16,16);
        save("lvl1.jpg");
        loadlvl1 = true;
      }

      image(loadImage("lvl1.jpg"),0,0);
      showCharacters(); 
      checkLevelSuccess(lvl1);

      if(player1.win == true && player2.win == true) {
        gameMenu.displayPopUp(1,2);
      }
    }
     else if(lvl2Selected){
      if(loadlvl2 == false) {
        print("loading map 2");
        levelSetUp(50,680,620,680, lvl2,color(123),16,16,32,32);
        save("lvl2.jpg");
        loadlvl2 = true;      
      }
      image(loadImage("lvl2.jpg"),0,0);
      showCharacters(); 
      checkLevelSuccess(lvl2);

      if(player1.win == true && player2.win == true) {
        
      }
    }
     else if(lvl3Selected){
      if(loadlvl3 == false) {
        print("loading map 3");
        levelSetUp(50,680,70,680, lvl3,color(233,255,123),32,32,64,64);
        save("lvl3.jpg");
        loadlvl3 = true;
      }
     
      image(loadImage("lvl3.jpg"),0,0);
      showCharacters(); 
      checkLevelSuccess(lvl3);
      if(player1.win == true && player2.win == true) {
        
      }
    }
     else if(lvl4Selected){
      if(loadlvl4 == false) {
        print("loading map 4");
        levelSetUp(50,680,70,680, lvl4,color(123,123,123),32,32,32,32);
        save("lvl4.jpg");
        loadlvl4 = true;
      }
      image(loadImage("lvl4.jpg"),0,0);
      showCharacters(); 
      checkLevelSuccess(lvl4);
      if(player1.win == true && player2.win == true) {
        
      }
    }
  }
  
}

// Loads level and position characters
void levelSetUp(int px1,
                int py1,
                int px2,
                int py2,
                Level lvl,
                color lvlColor,
                int textureX1,
                int textureY1,
                int textureX2,
                int textureY2){

  lvl.loadLevel(textureX1,textureY1,textureX2,textureY2,lvlColor);

  player1.level = lvl;
  player2.level = lvl;

  player1.px = px1;
  player1.py = py1;
  player2.px = px2;
  player2.py = py2;

  lvl.timer.start();

  file.play();
}

// display the two characters
void showCharacters(){
  grounded1 = player1.simulate(keys[0], keys[1], moving1);
  grounded2 = player2.simulate(keys[3], keys[4], moving2);

  if(grounded1) {
    jumping1 = false;
  }
  if(grounded2) {
    jumping2 = false;
  } 
}

// determine if both players have passed the level
void checkLevelSuccess(Level level){
  if(player1.portal && player2.portal){
    level.timer.stop();
    print("Minutes: " + level.timer.minutes() + " Seconds: " + level.timer.seconds());
    backToLevels();
  }
}

// ===== Exit Level =======
// returns to menu screen
void backToMenu(){
  levels = false;
  characters = false;
  menu = true;
  controls = false;
  credits = false;
  player = 0;
  P1 = false;
  P2 = false;
  gameMenu.home.rectOver = false;
  lvl1Selected = false;
  lvl2Selected = false;
  lvl3Selected = false;
  lvl4Selected = false;
  loadlvl1 = false;
  loadlvl2 = false;
  loadlvl3 = false;
  loadlvl4 = false;
}

// returns to levels screen
void backToLevels(){
  levels = true;
  menu = false;
  gameMenu.play.rectOver = false;
  lvl1Selected = false;
  lvl2Selected = false;
  lvl3Selected = false;
  lvl4Selected = false;
}

// ===== I/O controllers =======
void mouseClicked() {

  // ========== navigation controller =============
  if(gameMenu.home.rectOver){
    print("home button selected\n");
    backToMenu();
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
    controls = true;
    menu = false;
    gameMenu.controls.rectOver = false;
  }
  else if (gameMenu.credits.rectOver) {
    print("credits button clicked\n");
    credits = true;
    menu = false;
    gameMenu.controls.rectOver = false;
  }

  //============= Character Selection ==============
  else if(gameMenu.P1Button.rectOver) {
    P1 = true;
    P2 = false;
    player = 1;
  }
  else if(gameMenu.P2Button.rectOver) {
    P1 = false;
    P2 = true;
    player = 2;
  }
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
    file.pause();
    levelSelection.play();
    println("level 1 selected");
    gameMenu.lvl1.rectOver = false;
    lvl1Selected = true;
    menu = false;
    levels = false;
  }
  else if(gameMenu.lvl2.rectOver){
    file.pause();
    levelSelection.play();
    println("level 2 selected");
    gameMenu.lvl2.rectOver = false;
    lvl2Selected = true;
    menu = false;
    levels = false;
  }
  else if(gameMenu.lvl3.rectOver){
    file.pause();
    levelSelection.play();
    println("level 3 selected");
    gameMenu.lvl3.rectOver = false;
    lvl3Selected = true;
    menu = false;
    levels = false;
  }
  else if(gameMenu.lvl4.rectOver){
    file.pause();
    levelSelection.play();
    println("level 4 selected");
    gameMenu.lvl4.rectOver = false;
    lvl4Selected = true;
    menu = false;
    levels = false;
  }
}

// manage player movement, update sprites and exit level
void keyPressed(){
  if( keyCode == LEFT ){
    keys[0] = true;
    player1.sprite.currentSpriteIndex = (player1.sprite.currentSpriteIndex - 1 + player1.sprite.leftView.length) % player1.sprite.leftView.length;
    player1.currentSprite = loadImage(player1.sprite.leftView[player1.sprite.currentSpriteIndex]);
  }
  if( keyCode == RIGHT ){
    keys[1] = true;
    player1.sprite.currentSpriteIndex = (player1.sprite.currentSpriteIndex + 1) % player1.sprite.rightView.length;
    player1.currentSprite = loadImage(player1.sprite.rightView[player1.sprite.currentSpriteIndex]);
  }
  if( keyCode == UP ){
    keys[2] = true;    
    if(!jumping1) {
      player1.jump();
      jumping1 = true;
    }
  }
  if(keyCode == LEFT || keyCode == RIGHT || keyCode == LEFT) {
    moving1 = true;
  }
  if( keyCode == 'A' ){
    keys[3] = true;
    player2.sprite.currentSpriteIndex = (player2.sprite.currentSpriteIndex - 1 + player2.sprite.leftView.length) % player2.sprite.leftView.length;
    player2.currentSprite = loadImage(player2.sprite.leftView[player2.sprite.currentSpriteIndex]);
  }
  if( keyCode == 'D' ){
    keys[4] = true;
    player2.sprite.currentSpriteIndex = (player2.sprite.currentSpriteIndex + 1) % player2.sprite.rightView.length;
    player2.currentSprite = loadImage(player2.sprite.rightView[player2.sprite.currentSpriteIndex]);
  }
  if( keyCode == 'W' ){
    keys[5] = true;
    if(!jumping2) {
      player2.jump();
      jumping2 = true;
    }
  }
  if(keyCode == 'A' || keyCode == 'D' || keyCode == 'W') {
    moving2 = true;
  }
  if(keyCode == 'P'){
    backToMenu();
  }
}

// manage player movement
void keyReleased(){
  if( keyCode == LEFT ){
    keys[0] = false;
  }
  if( keyCode == RIGHT ){
    keys[1] = false;
  }
  if(keys[0] == false && keys[1] == false) {
    moving1 = false;
  }
  if( keyCode == 'A' ){
    keys[3] = false;
  }
  if( keyCode == 'D' ){
    keys[4] = false;
  }
  if(keys[3] == false && keys[4] == false) {
    moving2 = false;
  }
}

// ======= Characters ============

// lods files needed for sprite changing
void loadSprites(){

 red = new CharacterSprite(new String[]{"data/dinoRL1.png",
                                        "data/dinoRL2.png",
                                        "data/dinoRL3.png",
                                        "data/dinoRL4.png",
                                        "data/dinoRL5.png",
                                        "data/dinoRL6.png"},
                          new String[]{"data/dinoRR1.png",
                                        "data/dinoRR2.png",
                                        "data/dinoRR3.png",
                                        "data/dinoRR4.png",
                                        "data/dinoRR5.png",
                                        "data/dinoRR6.png"},
                          "data/dinoRLI1.png",
                          "data/dinoRRI1.png"
                          );

   blue = new CharacterSprite(new String[]{"data/dinoBL1.png",
                                        "data/dinoBL2.png",
                                        "data/dinoBL3.png",
                                        "data/dinoBL4.png",
                                        "data/dinoBL5.png",
                                        "data/dinoBL6.png"},
                          new String[]{"data/dinoBR1.png",
                                        "data/dinoBR2.png",
                                        "data/dinoBR3.png",
                                        "data/dinoBR4.png",
                                        "data/dinoBR5.png",
                                        "data/dinoBR6.png"},
                          "data/dinoBLI1.png",
                          "data/dinoBRI1.png"
                          );

   yellow = new CharacterSprite(new String[]{"data/dinoYL1.png",
                                        "data/dinoYL2.png",
                                        "data/dinoYL3.png",
                                        "data/dinoYL4.png",
                                        "data/dinoYL5.png",
                                        "data/dinoYL6.png"},
                          new String[]{"data/dinoYR1.png",
                                        "data/dinoYR2.png",
                                        "data/dinoYR3.png",
                                        "data/dinoYR4.png",
                                        "data/dinoYR5.png",
                                        "data/dinoYR6.png"},
                          "data/dinoYLI1.png",
                          "data/dinoYRI1.png"
                          );

  green = new CharacterSprite(new String[]{"data/dinoGL1.png",
                                          "data/dinoGL2.png",
                                          "data/dinoGL3.png",
                                          "data/dinoGL4.png",
                                          "data/dinoGL5.png",
                                          "data/dinoGL6.png"},
                            new String[]{"data/dinoGR1.png",
                                          "data/dinoGR2.png",
                                          "data/dinoGR3.png",
                                          "data/dinoGR4.png",
                                          "data/dinoGR5.png",
                                          "data/dinoGR6.png"},
                            "data/dinoGLI1.png",
                            "data/dinoGRI1.png"
                            );
}

// initialize players objects
void createCharacters(){
  player1 = new Player(this,50,680,1);
  player2 = new Player(this,50,680,2);
  player1.sprite = red;
  player2.sprite = blue;
  player1.currentSprite = loadImage(player1.sprite.rightView[0]);
  player2.currentSprite = loadImage(player2.sprite.rightView[0]);
}

// udpate players sprites
void characterSelection(CharacterSprite sprite){
  if(player == 1){
      gameMenu.character1 = sprite.jumpRightView;
      player1.sprite = sprite;
      player1.currentSprite = loadImage(sprite.rightView[0]);
  }
  else if (player == 2){
      gameMenu.character2 = sprite.jumpRightView;
      player2.sprite = sprite;
      player2.currentSprite = loadImage(sprite.rightView[0]);
  }
}


// ========= Levels ===========
void createLevels(){
  lvl1 = new Level(1);
  lvl2 = new Level(2);
  lvl3 = new Level(3);
  lvl4 = new Level(4);
}

// =========  Sounds =========
void loadSounds(){
  file = new SoundFile(this, "data/Abstraction - Three Red Hearts - Box Jump.wav");
  levelSelection = new SoundFile(this, "data/roar_level-selection.wav");
  file.amp(0.1);
  file.loop();
}
