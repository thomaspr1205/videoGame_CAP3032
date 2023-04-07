class Button {
  /**
   * Button.
   * https://processing.org/examples/button.html
   */

  int rectX, rectY;
  int rectSizeX, rectSizeY;
  int rectRadius;
  int rectTextSz;
  color rectColor, rectHighlight;
  boolean rectOver = false;
  String content;

  Button(String input, int sizeX, int sizeY, int posX, int posY, int radius, int textSz) {
    content = input;
    rectColor = color(255,100,100, 200);
    rectSizeX = sizeX;
    rectSizeY = sizeY;
    rectHighlight = color(255,200,100);
    rectX = posX;
    rectY = posY;
    rectRadius = radius;
    rectTextSz = textSz;
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
    rect(rectX, rectY, rectSizeX, rectSizeY, rectRadius);

    if (rectOver) {
      fill(rectColor);
    } else {
      fill(rectHighlight);
    }
    fill(255);
    textSize(rectTextSz);
    text(content, rectX, rectY +(rectTextSz*2)/6); // Font is around a 30 to 50 ratio pixels to font size
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
