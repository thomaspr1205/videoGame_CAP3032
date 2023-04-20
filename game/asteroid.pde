// class Asteroid extends Vehicle{

//   float x, y, w, h;
//   boolean isOnGround;
//   String baseSprite = "AsteroidBase.png";
//   String movingSprite = "AsteroidMoving.png";
//   private PApplet parent;

//       public Asteroid(PApplet parent, float x, float y, float w, float h) {
//     super(new Vector2D(x, y), // position
//           30, // collision radius
//           new Vector2D(90, -10), // velocity
//           200, // maximum speed
//           new Vector2D(1, 1), // heading
//           1, // mass
//           1.5f, // turning rate
//           800 // max force
//           );
//     this.x = x;
//     this.y = y;
//     this.w = w;
//     this.h = h;
//     // this.jumpSpeed = jumpSpeed;
//     // this.dy = 0;
//     // this.dx = 0;
//     this.isOnGround = true;
//     // this.isJumping = false; 
 
//     this.parent = parent;
// view = new BitmapPic(parent, movingSprite, 12, 1);    
//     view.showHints(Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY | Hints.HINT_WHISKERS);
//   }

//   public void setAnimation(float interval, int repetitions) {
//     view.setAnimation(interval, repetitions);
//     renderer(view);

//   }

//   // void display(){
    
//   // }
// }