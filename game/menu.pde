class Menu{
    PImage backgroundImg;
    Button play, charSel, controls, lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7, lvl8;
    String title;
    
    Menu(PImage image, String name){
        backgroundImg = image;
        title = name;
        // Button("label", xSize, ySize, xPos, yPos) we can also include the color parameters here
        play = new Button("Play",300,80,500,400);
        charSel = new Button("Characters",300,80,500,500);
        controls = new Button("Controls",300,80,500,600);
        lvl1 = new Button("1", 150, 150, 155, 285);
        lvl2 = new Button("2", 150, 150, 385, 285);
        lvl3 = new Button("3", 150, 150, 615, 285);
        lvl4 = new Button("4", 150, 150, 845, 285);
        lvl5 = new Button("5", 150, 150, 155, 515);
        lvl6 = new Button("6", 150, 150, 385, 515);
        lvl7 = new Button("7", 150, 150, 615, 515);
        lvl8 = new Button("8", 150, 150, 845, 515);        
    }

    void display(){
        image(backgroundImg,0,0);
        fill(0);
        textAlign(CENTER);
        textSize(150);
        text(title.substring(0,10), 500, 250);
        textSize(50);
        text(title.substring(11), 500, 320);
        play.display();
        charSel.display();
        controls.display();
    }
    
    void display2() {
        image(backgroundImg,0,0);
        textAlign(CENTER);
        lvl1.display();
        lvl2.display();
        lvl3.display();
        lvl4.display();
        lvl5.display();
        lvl6.display();
        lvl7.display();
        lvl8.display();
    }

}
