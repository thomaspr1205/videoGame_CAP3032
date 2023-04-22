
class Player {
  float origPx, origPy;
  float px, py;
  float vx, vy;
  float ax, ay;
  boolean moving, grounded, portal, prevPortal, win;
  int keySet;
  int savedTime, totalTime = 1000, timePassed;
  Level level;
  CharacterSprite sprite;
  PImage currentSprite;
  SoundFile sound;

  // player constructor that creates a player with the following parameters
  Player(PApplet parent, int xPos, int yPos, int playerKey) {
    win = false;
    origPx = xPos;
    origPy = yPos;
    px = xPos;
    py = yPos;
    vx = 0;
    vy = 0;
    ax = 0;
    ay = 0;
    keySet = playerKey;
    sound = new SoundFile(parent, "data/jump.wav");
  }
  
  // used to set p1 to the arrow keys and p2 to the wad keys
  int getPlayerKey() {
    return keySet;
  }
  
  // makes the character jump and makes a sound effect when they do
  void jump() {
    vy -=10;
    sound.amp(1.0);
    sound.play();
  }
  
  // simulates all the physics
  boolean simulate(boolean left, boolean right, boolean moving) {
    float prevPx, prevPy;
    prevPx = px;
    prevPy = py;
    
    grounded = false;
    ax = 0;
    if((left == true && right == true) || left == false && right == false) {
      ax += 0;
    }
    else if(left == true) {
      ax -= .2;
    }
    else if(right == true) {
      ax += .2;
    }
    ay = .50;
    vx+=ax;
    vy+=ay;
    px+=vx;
    py+=vy;
    
    // Corner collision for portal
    int xTopLeft, yTopLeft, xTopRight, yTopRight, xBotLeft, yBotLeft, xBotRight, yBotRight;
    xTopLeft = int((px - 20)/25);
    yTopLeft = int((py - 40)/25); 
    xTopRight = int((px + 20)/25);
    yTopRight = int((py - 40)/25);  
    xBotLeft = int((px - 20)/25);
    yBotLeft = int(py/25);  
    xBotRight = int((px + 20)/25);
    yBotRight = int(py/25);  
       
    if(level.map[yTopLeft][xTopLeft] == 7 && level.map[yTopRight][xTopRight] == 8 && level.map[yBotLeft - 1][xBotLeft] == 9 && level.map[yBotRight - 1][xBotRight] == 10) {
      portal = true;
      // timer to check that the character is in the portal for at least 1 second
      if(prevPortal == false) {
        savedTime = millis();
      }
      else if(prevPortal == true) {
        timePassed = millis() - savedTime;
        if(timePassed > totalTime) {
          println("inPortal");
          win = true;
        }
      }
    }   
    else {
      portal = false;
    }
        
    prevPortal = portal;
        
    // Bottom collision
    int xblkBotLoc, yblkBotLoc;
    xblkBotLoc = int((px - 10)/25);
    yblkBotLoc = int(py/25);  
    
    int xblkBotLoc2, yblkBotLoc2;
    xblkBotLoc2 = int((px + 10)/25);
    yblkBotLoc2 = int(py/25);  
    
    if(level.map[yblkBotLoc][xblkBotLoc] == 1 && prevPy < py || level.map[yblkBotLoc2][xblkBotLoc2] == 1 && prevPy < py) {
        py=(yblkBotLoc)*25; 
        vy=0; 
        ay=0;
        grounded = true;
    }
    if(level.map[yblkBotLoc][xblkBotLoc] >= 2 && level.map[yblkBotLoc][xblkBotLoc] < 7 && prevPy < py || 
       level.map[yblkBotLoc2][xblkBotLoc2] >= 2 && level.map[yblkBotLoc2][xblkBotLoc2] < 7 && prevPy < py) {
        px = origPx;
        py = origPy;
    }
    
    // friction
    if(grounded == true && moving == false) {
        vx = 0;
    }
    
    // Top collision
    int xblkTopLoc, yblkTopLoc;
    xblkTopLoc = int((px - 20)/25);
    yblkTopLoc = int((py-40)/25);
    
    int xblkTopLoc2, yblkTopLoc2;
    xblkTopLoc2 = int((px + 20)/25);
    yblkTopLoc2 = int((py-40)/25);
    
    if(level.map[yblkTopLoc][xblkTopLoc] == 1 && prevPy > py || level.map[yblkTopLoc2][xblkTopLoc2] == 1 && prevPy > py) {
        py=((yblkTopLoc + 1)*25)+40; 
        vy=0; 
        ay=0;
    }
    if(level.map[yblkTopLoc][xblkTopLoc] >= 2 && level.map[yblkTopLoc][xblkTopLoc] < 7 && prevPy > py || 
       level.map[yblkTopLoc2][xblkTopLoc2] >= 2 && level.map[yblkTopLoc2][xblkTopLoc2] < 7 && prevPy > py) {
        px = origPx;
        py = origPy;
    }
    
    // Left collision
    int xblkLeftLoc, yblkLeftLoc;
    xblkLeftLoc = int((px-20)/25);
    yblkLeftLoc = int((py-10)/25);
    
    int xblkLeftLoc2, yblkLeftLoc2;
    xblkLeftLoc2 = int((px-20)/25);
    yblkLeftLoc2 = int((py-30)/25);
    
    if(level.map[yblkLeftLoc][xblkLeftLoc] == 1 && prevPx > px || level.map[yblkLeftLoc2][xblkLeftLoc2] == 1 && prevPx > px) {
        px=((xblkLeftLoc + 1)*25)+20; 
        vx=0; 
        ax=0;
    }
    if(level.map[yblkLeftLoc][xblkLeftLoc] >= 2 && level.map[yblkLeftLoc][xblkLeftLoc] < 7 && prevPx > px || 
       level.map[yblkLeftLoc2][xblkLeftLoc2] >= 2 && level.map[yblkLeftLoc2][xblkLeftLoc2] < 7 && prevPx > px) {
        px = origPx;
        py = origPy;
    }
    
    // Right collision
    int xblkRightLoc, yblkRightLoc;
    xblkRightLoc = int((px+20)/25);
    yblkRightLoc = int((py-10)/25);
    
    int xblkRightLoc2, yblkRightLoc2;
    xblkRightLoc2 = int((px+20)/25);
    yblkRightLoc2 = int((py-30)/25);
    
    if(level.map[yblkRightLoc][xblkRightLoc] == 1 && prevPx < px || level.map[yblkRightLoc2][xblkRightLoc2] == 1 && prevPx < px) {
        px=((xblkRightLoc)*25)-20; 
        vx=0; 
        ax=0;
    }
    if(level.map[yblkRightLoc][xblkRightLoc] >= 2 && level.map[yblkRightLoc][xblkRightLoc] < 7 && prevPx < px || 
       level.map[yblkRightLoc2][xblkRightLoc2] >= 2 && level.map[yblkRightLoc2][xblkRightLoc2] < 7 && prevPx < px) {
        px = origPx;
        py = origPy;
    }
    
    render(px, py);
    return grounded;
  }
  

  // shows character
  void render(float px, float py) {
    rectMode(CORNER);
    image(currentSprite, px-20, py-40,40,40);
    rectMode(CENTER);
  }
}
