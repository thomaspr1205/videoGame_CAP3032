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

  // button constructor creates a button with the following parameters
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

  // displays the button; highlights and outlines when mouse over
  void display() {
    update();

    if (rectOver) {
      stroke(255);
      strokeWeight(5);
      fill(rectHighlight);
    } else {
      noStroke();
      fill(rectColor);
    }
    rect(rectX, rectY, rectSizeX, rectSizeY, rectRadius);

    if (rectOver) {
      fill(rectColor);
    } else {
      fill(rectHighlight);
    }
    noStroke();
    fill(255);
    textSize(rectTextSz);
    text(content, rectX, rectY +(rectTextSz*2)/6); // Font is around a 30 to 50 ratio pixels to font size
  }

  // changes rectOver variable to true if mouse is over button
  void update() {
    if ( overRect(rectX, rectY, rectSizeX, rectSizeY) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }
  
  // checks if mouse is over
  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x - width/2 && mouseX <= x + width/2 &&
      mouseY >= y - height/2 && mouseY <= y + height/2) {
      return true;
    } else {
      return false;
    }
  }
}
