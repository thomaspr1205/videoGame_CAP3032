// class Map{
//     Building[] bs;
//     BuildingPic bpic;
//     PApplet parent;
    
//     Map(String mapFile, PApplet parent, color fillColor, color borderColor, int stroke){
//         this.parent = parent;
//         bs = Building.makeFromXML(parent, mapFile);
//         bpic = new BuildingPic(parent, fillColor, borderColor, stroke);
//     }

//     public void createBuildings(){
//         for (int i = 0; i < bs.length; i++) {
//             bs[i].renderer(bpic);
//             world.add(bs[i]);
//         }
//     }

// }