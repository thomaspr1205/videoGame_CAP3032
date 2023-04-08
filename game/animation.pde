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

  void display(float xPos, float yPos, int lag) {
    prevFrame+=1;
    if(prevFrame == imageCount * lag) {
      prevFrame = 0;
    }
    frame = prevFrame / lag;
    image(images[frame], xPos, yPos, 128, 136); // add the two end numbers to parameters to scale image
    
  }
  
  int getWidth() {
    return images[0].width;
  }
}
