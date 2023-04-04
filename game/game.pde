Menu gameMenu;
void setup() {
  size(1000, 800);
  PImage menuImg = loadImage("data/menuBackground.jpg");
  gameMenu = new Menu(menuImg, "Dino Dash: Escape from Extinction");
}

void draw() {
  gameMenu.display(); 
  //gameMenu.display2();
}

void mouseClicked() {
  // navigation should happen here
  if (gameMenu.play.rectOver) {
    print("play button clicked\n");
    
  }
  if (gameMenu.charSel.rectOver) {
    print("characters button clicked\n");
  }
  if (gameMenu.controls.rectOver) {
    print("controls button clicked\n");
  }
}
