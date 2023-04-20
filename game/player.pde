
class Player {
  float px, py;
  float vx, vy;
  float ax, ay;
  //float xSpeed, gravity;
  //boolean grounded;
  //boolean left = false, right = false;
  boolean moving, grounded;
  int keySet;
  Level level;
  CharacterSprite sprite;
  PImage currentSprite;

  
  Player(int xPos, int yPos, int playerKey) {
    px = xPos;
    py = yPos;
    vx = 0;
    vy = 0;
    ax = 0;
    ay = 0;
    keySet = playerKey;
    //xSpeed = 9;
    //gravity = 0.75;
    //grounded = false;
  }
  
  int getPlayerKey() {
    return keySet;
  }
  
  void jump() {
    vy -=10;
  }
  
  boolean simulate(boolean left, boolean right, boolean moving) {
    //if(up == true) {
    //  vy -=10;
    //  up = false;
    //}
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
        
    // Bottom collision
    int xblkBotLoc, yblkBotLoc;
    xblkBotLoc = int(px/25);
    yblkBotLoc = int(py/25);  
    
    if(level.map[yblkBotLoc][xblkBotLoc] == 1 && prevPy < py) {
        py=(yblkBotLoc)*25; 
        vy=0; 
        ay=0;
        grounded = true;
    }
    
    // friction
    if(grounded == true && moving == false) {
        vx = 0;
    }
    
    // Top collision
    int xblkTopLoc, yblkTopLoc;
    xblkTopLoc = int(px/25);
    yblkTopLoc = int((py-20)/25);
    // println(xblkTopLoc + " " + yblkTopLoc);
    
    if(level.map[yblkTopLoc][xblkTopLoc] == 1 && prevPy > py) {
        py=((yblkTopLoc + 1)*25)+20; 
        vy=0; 
        ay=0;
    }
    
    // Left collision
    int xblkLeftLoc, yblkLeftLoc;
    xblkLeftLoc = int((px-10)/25);
    yblkLeftLoc = int((py-10)/25);
    // println(xblkLeftLoc + " " + yblkLeftLoc);
    
    if(level.map[yblkLeftLoc][xblkLeftLoc] == 1 && prevPx > px) {
        px=((xblkLeftLoc + 1)*25)+10; 
        vx=0; 
        ax=0;
    }
    
    // Right collision
    int xblkRightLoc, yblkRightLoc;
    xblkRightLoc = int((px+10)/25);
    yblkRightLoc = int((py-10)/25);
    // println(xblkLeftLoc + " " + yblkLeftLoc);
    
    if(level.map[yblkRightLoc][xblkRightLoc] == 1 && prevPx < px) {
        px=((xblkRightLoc)*25)-10; 
        vx=0; 
        ax=0;
    }
    render(px, py);
    return grounded;
  }
  
  void render(float px, float py) {
    //background(64);
    rectMode(CORNER);
    strokeWeight(3);
    stroke(0);
    line(100, 300, 300, 300);
    noStroke();
    fill(0, 255, 0);
    rect(px-10, py-20, 20, 20);
    circle(px, py, 5);
    image(currentSprite, px-15, py-25,40,40);
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
