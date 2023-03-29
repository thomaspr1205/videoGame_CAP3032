Menu gameMenu;
void setup() {
  size(1000, 800);
  PImage menuImg = loadImage("data/menuBackground.jpg");
  gameMenu = new Menu(menuImg, "game title");
}

void draw() {
  gameMenu.display();
}

void mouseClicked() {
  // navigation should happen here
  if (gameMenu.easy.rectOver) {
    print("easy button clicked\n");
  }
  if (gameMenu.medium.rectOver) {
    print("medium button clicked\n");
  }
  if (gameMenu.hard.rectOver) {
    print("hard button clicked\n");
  }
}
