import game2dai.entities.*;
import game2dai.entityshapes.ps.*;
import game2dai.maths.*;
import game2dai.*;
import game2dai.entityshapes.*;
import game2dai.fsm.*;
import game2dai.steering.*;
import game2dai.utils.*;
import game2dai.graph.*;

import java.awt.event.KeyEvent;

public class Character extends Vehicle {

  float x, y, w, h;
  float dx, dy;
  float jumpSpeed;
  boolean isJumping;
  boolean isOnGround;

  private BitmapPic view;
  private PApplet parent;
  String imagePathRight, imagePathleft, imagePathJumpLeft, imagePathJumpRight;
  int up, left, right;
  CharacterSprite sprite;
  int prevKey = -1;
  
  public Character(PApplet parent, float x, float y, float w, float h,  float jumpSpeed, CharacterSprite sprite) {
    super(new Vector2D(x, y), // position
          30, // collision radius
          new Vector2D(100, 0), // velocity
          200, // maximum speed
          new Vector2D(1, 1), // heading
          1, // mass
          10.5f, // turning rate
          800 // max force
          );
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.jumpSpeed = jumpSpeed;
    this.dy = 0;
    this.dx = 0;
    this.isOnGround = true;
    this.isJumping = false; 
 
    this.parent = parent;
    this.sprite = sprite;
    view = new BitmapPic(parent, sprite.rightView, 6, 1);    
    view.showHints(Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY | Hints.HINT_WHISKERS);
    renderer(view);
  }

  void display() {
    fill(0, 255, 0);
    rect(x, y, w, h);
  }

  public void setSprite(CharacterSprite charSprites){
    sprite = charSprites;
    view = new BitmapPic(parent, sprite.rightView, 6, 1);    
    view.showHints(Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY | Hints.HINT_WHISKERS);
    renderer(view);
  }

  public void setKeys(int left, int up, int right){
    this.up = up;
    this.left = left;
    this.right = right;
  }

  public void setAnimation(float interval, int repetitions) {
    view.setAnimation(interval, repetitions);
  }

  public void pauseAnimation() {
    view.pauseAnimation();
  }

  public void handleInput(int keyCode) {
    if (keyCode == up && isOnGround) {
      jump();
      if(prevKey == right || prevKey == -1){
        view = new BitmapPic(parent, sprite.jumpRightView, 1, 1); 
      }else if(prevKey == left){
        view = new BitmapPic(parent, sprite.jumpLeftView, 1, 1); 
      }
      view.showHints(Hints.HINT_WHISKERS| Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
      renderer(view);
    } if (keyCode == left) {
      if(isOnGround){
        view = new BitmapPic(parent, sprite.leftView, 6, 1); 
        view.showHints(Hints.HINT_WHISKERS | Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
        renderer(view);
      }
      if(x < 0){
        dx = 0;
      }else{
        dx -= 0.15;
      }
    } if (keyCode == right) {
      if(isOnGround){
        view = new BitmapPic(parent, sprite.rightView, 6, 1);
        view.showHints(Hints.HINT_WHISKERS | Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
        renderer(view);
        }
      if(dx > width){
        dx = width;
      }else{
        dx += 0.15;
      }
    }
    prevKey = keyCode;
  }

  void move(Building[] bs) {
    // Move character horizontally
    x += dx;
    
    // Apply gravity
    dy += 0.5;
    y += dy;

    if (x < 0) {
      x = 0;
    } else if (x + w > width) {
      x = width - w;
    }
    
    // Check for collisions with buildings
    for (Building b : bs) {
      if (collidesWith(b)) {
        resolveCollision(b);
      }
    }
    
    // // Check if character is on the ground
    // if (y + h >= height) {
    //   dy = 0;
    //   y = height - h;
    //   isOnGround = true;
    //   isJumping = false;
    // } else {
    //   isOnGround = false;
    // }
  }
  
  boolean collidesWith(Building b) {
    Vector2D[] contour = b.contour();
    Vector2D prevPoint = contour[contour.length - 1];

    for (int i = 0; i < contour.length; i++) {
      Vector2D curPoint = contour[i];

      // Check for intersection between the character's bounding box and the current edge
      if (lineRect((float)prevPoint.x, (float)prevPoint.y, (float)curPoint.x, (float)curPoint.y, x, y, w, h)) {
        return true;
      }

      prevPoint = curPoint;
    }

    return false;
  }

  // Helper function to check for intersection between a line segment and a rectangle
  boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) {
    // Check if either endpoint of the line segment is inside the rectangle
    if (pointRect(x1, y1, rx, ry, rw, rh) || pointRect(x2, y2, rx, ry, rw, rh)) {
      return true;
    }

    // Check if the line segment intersects any of the four edges of the rectangle
    if (lineLine(x1, y1, x2, y2, rx, ry, rx, ry + rh) ||
        lineLine(x1, y1, x2, y2, rx + rw, ry, rx + rw, ry + rh) ||
        lineLine(x1, y1, x2, y2, rx, ry, rx + rw, ry) ||
        lineLine(x1, y1, x2, y2, rx, ry + rh, rx + rw, ry + rh)) {
      return true;
    }

    return false;
  }

  // Helper function to check for intersection between two line segments
  boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));
    float ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));

    return (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1);
  }

// Helper function to check if a point is inside a rectangle
  boolean pointRect(float px, float py, float rx, float ry, float rw, float rh) {
    return (px >= rx && px <= rx + rw && py >= ry && py <= ry + rh);
  }

  void resolveCollision(Building b) {
    Vector2D[] contour = b.contour();
    Vector2D minX = contour[0];
    Vector2D minY = contour[0]; // Initialize minY to the first point
    Vector2D maxX = contour[0];
    Vector2D maxY = contour[0]; // Initialize maxY to the first point

    // Find the actual minimum and maximum Y values in the contour array
    for (int i = 0; i < contour.length; i++) {
      if (contour[i].y < minY.y) {
        minY = contour[i];
      }
      if (contour[i].y > maxY.y) {
        maxY = contour[i];
      }
      if (contour[i].x < minX.x) {
        minX = contour[i];
      }
      if (contour[i].x > maxX.x) {
        maxX = contour[i];
      }
    }

    if (y + h > minY.y && y < minY.y + h/2) {
      // Collision from top
      dy = 0;
      y = (float)minY.y - h;
      isOnGround = true;
      isJumping = false;
    } else if (y < maxY.y && y + h/2 > maxY.y) {
      // Collision from bottom
      dy = 0;
      y = (float)minY.y;
    } else if (x + w > minX.x && x < minX.x + w/2) {
      // Collision from left
      dx = 0;
      x = (float)minX.x - w;
    } else if (x < maxX.x && x + w/2 > maxX.x) {
      // Collision from right
      dx = 0;
      x = (float)maxX.x;
    }
  }

  void jump() {
    if (isOnGround) {
      dy = -jumpSpeed;
      isJumping = true;
      isOnGround = false;
    }
  }

  boolean isOnGround() {
    print(isOnGround);
    return isOnGround;
  }
}


// class Character {
//   float x, y, w, h;
//   float dx, dy;
//   float jumpSpeed;
//   boolean isJumping;
//   boolean isOnGround;
  
//   Character(float x, float y, float w, float h, float jumpSpeed, float groundHeight, float domainHeight) {
//     this.x = x;
//     this.y = y;
//     this.w = w;
//     this.h = h;
//     this.jumpSpeed = jumpSpeed;
//     this.dy = 0;
//     this.isOnGround = true;
//     this.isJumping = false;
//   }
  
//   void display() {
//     fill(0, 255, 0);
//     rect(x, y, w, h);
//   }
  
//   void move(Building[] bs) {
//     // Move character horizontally
//     x += dx;
    
//     // Apply gravity
//     dy += 0.5;
//     y += dy;

//     if (x < 0) {
//       x = 0;
//     } else if (x + w > width) {
//       x = width - w;
//     }
    
//     // Check for collisions with buildings
//     for (Building b : bs) {
//       if (collidesWith(b)) {
//         resolveCollision(b);
//       }
//     }
    
//     // // Check if character is on the ground
//     // if (y + h >= height) {
//     //   dy = 0;
//     //   y = height - h;
//     //   isOnGround = true;
//     //   isJumping = false;
//     // } else {
//     //   isOnGround = false;
//     // }
//   }
  
//  boolean collidesWith(Building b) {
//   Vector2D[] contour = b.contour();
//   Vector2D prevPoint = contour[contour.length - 1];

//   for (int i = 0; i < contour.length; i++) {
//     Vector2D curPoint = contour[i];

//     // Check for intersection between the character's bounding box and the current edge
//     if (lineRect((float)prevPoint.x, (float)prevPoint.y, (float)curPoint.x, (float)curPoint.y, x, y, w, h)) {
//       return true;
//     }

//     prevPoint = curPoint;
//   }

//   return false;
// }

// // Helper function to check for intersection between a line segment and a rectangle
// boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) {
//   // Check if either endpoint of the line segment is inside the rectangle
//   if (pointRect(x1, y1, rx, ry, rw, rh) || pointRect(x2, y2, rx, ry, rw, rh)) {
//     return true;
//   }

//   // Check if the line segment intersects any of the four edges of the rectangle
//   if (lineLine(x1, y1, x2, y2, rx, ry, rx, ry + rh) ||
//       lineLine(x1, y1, x2, y2, rx + rw, ry, rx + rw, ry + rh) ||
//       lineLine(x1, y1, x2, y2, rx, ry, rx + rw, ry) ||
//       lineLine(x1, y1, x2, y2, rx, ry + rh, rx + rw, ry + rh)) {
//     return true;
//   }

//   return false;
// }

// // Helper function to check for intersection between two line segments
// boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
//   float ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));
//   float ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));

//   return (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1);
// }

// // Helper function to check if a point is inside a rectangle
// boolean pointRect(float px, float py, float rx, float ry, float rw, float rh) {
//   return (px >= rx && px <= rx + rw && py >= ry && py <= ry + rh);
// }
//  void resolveCollision(Building b) {
//   Vector2D[] contour = b.contour();
//   Vector2D minX = contour[0];
//   Vector2D minY = contour[0]; // Initialize minY to the first point
//   Vector2D maxX = contour[0];
//   Vector2D maxY = contour[0]; // Initialize maxY to the first point

//   // Find the actual minimum and maximum Y values in the contour array
//   for (int i = 0; i < contour.length; i++) {
//     if (contour[i].y < minY.y) {
//       minY = contour[i];
//     }
//     if (contour[i].y > maxY.y) {
//       maxY = contour[i];
//     }
//     if (contour[i].x < minX.x) {
//       minX = contour[i];
//     }
//     if (contour[i].x > maxX.x) {
//       maxX = contour[i];
//     }
//   }

//   if (y + h > minY.y && y < minY.y + h/2) {
//     // Collision from top
//     dy = 0;
//     y = (float)minY.y - h;
//     isOnGround = true;
//     isJumping = false;
//   } else if (y < maxY.y && y + h/2 > maxY.y) {
//     // Collision from bottom
//     dy = 0;
//     y = (float)maxY.y;
//   } else if (x + w > minX.x && x < minX.x + w/2) {
//     // Collision from left
//     dx = 0;
//     x = (float)minX.x - w;
//   } else if (x < maxX.x && x + w/2 > maxX.x) {
//     // Collision from right
//     dx = 0;
//     x = (float)maxX.x;
//   }
// }

  
//   void jump() {
//     if (isOnGround) {
//       dy = -jumpSpeed;
//       isJumping = true;
//       isOnGround = false;
//     }
//   }
  
//   boolean isOnGround() {
//     print(isOnGround);
//     return isOnGround;
//   }
// }