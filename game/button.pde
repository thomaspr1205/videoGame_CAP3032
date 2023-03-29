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
    rectColor = color(255,100,100);
    rectSizeX = sizeX;
    rectSizeY = sizeY;
    rectHighlight = color(255,200,100);
    rectX = posX-rectSizeX-10;
    rectY = posY-rectSizeY/2;
  }

  void display() {
    update();

    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    noStroke();
    rect(rectX, rectY, rectSizeX, rectSizeY);

    if (rectOver) {
      fill(rectColor);
    } else {
      fill(rectHighlight);
    }
    textSize(45);
    text(content, rectX + 10, rectY + 50);
  }

  void update() {
    if ( overRect(rectX, rectY, rectSizeX, rectSizeY) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }
  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}
