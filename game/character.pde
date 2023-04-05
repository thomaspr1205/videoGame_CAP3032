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

  private double x;
  private double y;
  private BitmapPic view;
  private PApplet parent;
  String imagePathRight, imagePathleft, imagePathJumpLeft, imagePathJumpRight;
  int up, left, right;
  boolean jumping = false;
  CharacterSprite sprite;
  int prevKey = -1;
  int gravity = 100;
  boolean adjustDino = true;
  
  public Character(PApplet parent, double x, double y, CharacterSprite sprite) {
    super(new Vector2D(x, y), // position
          30, // collision radius
          new Vector2D(30, 0), // velocity
          60, // maximum speed
          new Vector2D(1, 1), // heading
          1, // mass
          10.5f, // turning rate
          800 // max force
          ); 
    this.x = x;
    this.y = y;
    this.parent = parent;
    this.sprite = sprite;
    view = new BitmapPic(parent, sprite.rightView, 6, 1);    
    view.showHints(Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY | Hints.HINT_WHISKERS);
    renderer(view);
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
    if (keyCode == up && !jumping) {
      jumping = true;
      if(prevKey == right || prevKey == -1){
        view = new BitmapPic(parent, sprite.jumpRightView, 1, 1); 
      }else if(prevKey == left){
        view = new BitmapPic(parent, sprite.jumpLeftView, 1, 1); 
      }
      view.showHints(Hints.HINT_WHISKERS| Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
      renderer(view);
      y -= 100;
    } if (keyCode == left) {
      if(!jumping){
        view = new BitmapPic(parent, sprite.leftView, 6, 1); 
        view.showHints(Hints.HINT_WHISKERS | Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
        renderer(view);
      }
      x -= 10;
    } if (keyCode == right) {
      if(!jumping){
        view = new BitmapPic(parent, sprite.rightView, 6, 1);
        view.showHints(Hints.HINT_WHISKERS | Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
        renderer(view);
        }
        x += 10;
    }
    prevKey = keyCode;
    }
}