
class Player {
  float origPx, origPy;
  float px, py;
  float vx, vy;
  float ax, ay;
  //float xSpeed, gravity;
  //boolean grounded;
  //boolean left = false, right = false;
  boolean moving, grounded, portal, prevPortal, win;
  int keySet;
  int savedTime, totalTime = 1000, timePassed;
  Level level;
  CharacterSprite sprite;
  PImage currentSprite;
  SoundFile sound;

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
  
  int getPlayerKey() {
    return keySet;
  }
  
  void jump() {
    vy -=10;
    sound.amp(1.0);
    sound.play();
  }
  
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
  
  void render(float px, float py) {
    rectMode(CORNER);
    image(currentSprite, px-20, py-40,40,40);
    rectMode(CENTER);
  }
}
// ======== Thomass Code ==============
// class Player {
//   float px, py;
//   float vx, vy;
//   float ax, ay;
//   boolean moving, grounded;
//   int keySet;

//   Player(int xPos, int yPos, int playerKey) {
//     px = xPos;
//     py = yPos;
//     vx = 0;
//     vy = 0;
//     ax = 0;
//     ay = 0;
//     keySet = playerKey;
//   }

//   int getPlayerKey() {
//     return keySet;
//   }

//   void jump() {
//     py -= 10; // move player up by 1 unit after the jump
//     vy -= 10;
//     grounded = false;
//   }

//   void render(float px, float py) {
//     //background(64);
//     strokeWeight(3);
//     stroke(0);
//     line(100, 300, 300, 300);
//     noStroke();
//     fill(0, 255, 0);
//     rect(px, py, 20, 20);
//     // circle(px, py, 5);
//     }

//   boolean collidesWith(float x, float y, float w, float h) {
//     return px + 20 > x && px < x + w && py + 20 > y && py < y + h;
//   }

//   boolean simulate(boolean left, boolean right, boolean moving, int[][] map) {
//     //grounded = false;
//     ax = 0;
//     if ((left == true && right == true) || left == false && right == false) {
//       ax += 0;
//     } else if (left == true) {
//       ax -= .25;
//     } else if (right == true) {
//       ax += .25;
//     }
//     ay = .5;
//     vx += ax;
//     vy += ay;
//     px += vx;
//     py += vy;

//     // Apply friction
//     if (grounded && !moving) {
//       vx = 0;
//       grounded = true;
//     }

//     // Check for collisions with platforms - there is no lateral check
//     //boolean collided = false;
//     for (int i = 0; i < map.length; i++) {
//       for (int j = 0; j < map[0].length; j++) {
//         if (map[i][j] == 1) { // platform
//           float platformX = j * 25;
//           float platformY = i * 25;
//           if (collidesWith(platformX, platformY, 20, 20)) {
//             //collided = true;
//             if (py < platformY) { // player is above platform
//               py = platformY - 3;
//               vy = 0;
//               ay = 0;
//               grounded = true;
//             } else { // player is below platform
//               py += 20;
//               vy = 0;
//             }
//           }
//         }
//       }
//     }

//     // Check for collisions with screen boundaries
//     if (px < 0) {
//       px = 0;
//       vx = 0;
//     } else if (px > width) {
//       px = width - 20;
//       vx = 0;
//     }
//     if (py < 0) {
//       py = 0;
//       vy = 0;
//     } else if (py > height) {
//       py = height;
//       vy = 0;
//       grounded = true;
//     }
//     render(px, py);
//     return grounded;
//   }
// }
