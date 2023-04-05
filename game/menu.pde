class Menu{
    PImage backgroundImg;
    Button home, play, charSel, controls, lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7, lvl8;
    Button red, blue, green, yellow;
    String title;
    String character1, character2;
    
    Menu(PImage image, String name){
        backgroundImg = image;
        title = name;
        // Button("label", xSize, ySize, xPos, yPos) we can also include the color parameters here
        home = new Button("Home",150,50,100,100);
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

        red = new Button("", 150, 150, 155, 285);
        blue = new Button("", 150, 150, 385, 285);
        green = new Button("", 150, 150, 615, 285);
        yellow = new Button("", 150, 150, 845, 285);

   
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
    
    void displayLevels() {
        image(backgroundImg,0,0);
        textAlign(CENTER);
        home.display();
        lvl1.display();
        lvl2.display();
        lvl3.display();
        lvl4.display();
        lvl5.display();
        lvl6.display();
        lvl7.display();
        lvl8.display();
    }
    
    void displayCharacters() {
        image(backgroundImg,0,0);
        textAlign(CENTER);
        home.display();
        red.display();
        image(loadImage("data/dinoRR1.png"),130,265);
        blue.display();
        image(loadImage("data/dinoBR1.png"),360,265);
        green.display();
        image(loadImage("data/dinoGR1.png"),590,265);
        yellow.display();
        image(loadImage("data/dinoYR1.png"),820,265);

        text("Player 1 ",400,600);
        image(loadImage(character1),350,610);

       
        text("Player 2 ",650,600);
        image(loadImage(character2),620,610);

    }

}
