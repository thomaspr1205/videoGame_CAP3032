class Button {
  /**
   * Button.
   * https://processing.org/examples/button.html
   */

  int rectX, rectY;
  int rectSizeX, rectSizeY;
  color rectColor, rectHighlight;
  boolean rectOver = false;
  String content;

  Button(String input, int sizeX, int sizeY, int posX, int posY) {
    content = input;
    rectColor = color(255,100,100, 200);
    rectSizeX = sizeX;
    rectSizeY = sizeY;
    rectHighlight = color(255,200,100);
    rectX = posX;
    rectY = posY;
    rectMode(CENTER);
  }

  void display() {
    update();

    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    noStroke();
    rect(rectX, rectY, rectSizeX, rectSizeY, 25);

    if (rectOver) {
      fill(rectColor);
    } else {
      fill(rectHighlight);
    }
    fill(255);
    textSize(50);
    text(content, rectX, rectY + 15);
  }

  void update() {
    if ( overRect(rectX, rectY, rectSizeX, rectSizeY) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }
  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x - width/2 && mouseX <= x + width/2 &&
      mouseY >= y - height/2 && mouseY <= y + height/2) {
      return true;
    } else {
      return false;
    }
  }
}
