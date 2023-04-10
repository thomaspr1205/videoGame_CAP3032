// Credit to processing https://processing.org/examples/animatedsprite.html
class Animation {
  PImage[] images;
  int imageCount;
  int frame, prevFrame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + (i+1) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(float xPos, float yPos, int lag, int newX, int newY) {
    prevFrame+=1;
    if(prevFrame == imageCount * lag) {
      prevFrame = 0;
    }
    frame = prevFrame / lag;
    image(images[frame], xPos, yPos, newX, newY); // add the two end numbers to parameters to scale image
    
  }
  
  int getWidth() {
    return images[0].width;
  }
}
