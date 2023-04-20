Menu gameMenu;

boolean menu, levels, characters, controls, credits, levelTesting, P1, P2;

Player player1, player2;
CharacterSprite blue, green, red, yellow;

Level lvl1;
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
boolean jumping1 = false, jumping2 = false;
boolean grounded1 = false, grounded2 = false;

void setup() {
  size(1000, 700);

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
    else if(levelTesting){
      if(loadlvl1 == false) {
        print("loading map 1");
        lvl1.loadLevel();
        save("lvl1.jpg");
        loadlvl1 = true;
        player1.level = lvl1;
        player2.level = lvl1;
      }
      image(loadImage("lvl1.jpg"),0,0);
      
      grounded1 = player1.simulate(keys[0], keys[1], moving1);
      grounded2 = player2.simulate(keys[3], keys[4], moving2);

      if(grounded1) {
        jumping1 = false;
      }
      if(grounded2) {
        jumping2 = false;
      } 
    }
  }
}

// ===== I/O controllers =======
void mouseClicked() {

  // ========== navigation controller =============
  if(gameMenu.home.rectOver){
    print("home button selected\n");
    levels = false;
    characters = false;
    menu = true;
    controls = false;
    credits = false;
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
    println("level 1 selected");
    gameMenu.lvl1.rectOver = false;
    levelTesting = true;
    menu = false;
    levels = false;
  }
}

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
}

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

void createCharacters(){
  player1 = new Player(30,680,1);
  player2 = new Player(50,680,2);
  player1.sprite = red;
  player2.sprite = blue;
  player1.currentSprite = loadImage(player1.sprite.rightView[0]);
  player2.currentSprite = loadImage(player2.sprite.rightView[0]);
}

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
  lvl1 = new Level(4);

}
