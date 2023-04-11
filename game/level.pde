class Level{
    Map map;
    String mapFile;
    PApplet parent;
    Asteroid asteroid;
    Building[] bs;
    boolean alive = false;
    Level(PApplet parent, int levelNum){
        if(levelNum == 0){
            mapFile = "maps/mapTest.xml";
        }
        if(levelNum == 1){
            mapFile = "maps/easy.xml";
        }
        else if(levelNum == 2){
            mapFile = "maps/medium.xml";
        }
        else if(levelNum == 3){
            mapFile = "maps/hard.xml";
        }
        map = new Map(mapFile,parent,color(299,174,33),color(81,133,32),2);
        this.parent = parent;
        this.bs = map.bs;

    }

    public void display(){
        map.createBuildings();
    }

    public void createAsteroid(){
        if(!alive){
            float xPos = random(100, width-100);
            asteroid = new Asteroid(parent, xPos,30,50,50);
            asteroid.AP().pathFactors(10, 1).pathOn();
            world.add(asteroid);
            Vector2D wp = new Vector2D(xPos+random(-50,50), height);
            asteroid.AP().pathAddToRoute(wp);
            float newInterval = map((float)asteroid.speed(), 0, (float)asteroid.maxSpeed(), 0.6, 0.04);
            asteroid.setAnimation(newInterval, 1);
            alive = true;
        }
        for (Building b : bs) {
            Collision collision = new Collision((float)asteroid.pos().x,
                                                (float)asteroid.pos().y,
                                                asteroid.h,
                                                asteroid.w,
                                                0,0);
            if (collision.collidesWith(b)) {
                world.death(asteroid,0);
                alive = false;
            }
        }
    }

}