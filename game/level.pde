class Level{
    Map map;
    String mapFile;
    PApplet parent;
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
    }
    public void display(){
        map.createBuildings();
    }
}