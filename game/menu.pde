class Menu{
    PImage backgroundImg;
    Button home, play, charSel, controls, credits, lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7, lvl8;
    Button red, blue, green, yellow;
    String title;
    String character1, character2;
    Animation redIdle, blueIdle, greenIdle, yellowIdle;
    
    Menu(PImage image, String name){
        backgroundImg = image;
        title = name;
        // Button("label", xSize, ySize, xPos, yPos, radius) we can also include the color parameters here
        home = new Button("Home", 150, 50, 155, 100, 15, 30);
        play = new Button("Play", 300, 80, 500, 330, 25, 50);
        charSel = new Button("Characters", 300, 80, 500, 420, 25, 50);
        controls = new Button("Controls", 300, 80, 500, 510, 25, 50);
        credits = new Button("Credits", 300, 80, 500, 600, 25, 50);
        lvl1 = new Button("1", 150, 150, 155, 255, 25, 50);
        lvl2 = new Button("2", 150, 150, 385, 255, 25, 50);
        lvl3 = new Button("3", 150, 150, 615, 255, 25, 50);
        lvl4 = new Button("4", 150, 150, 845, 255, 25, 50);
        lvl5 = new Button("5", 150, 150, 155, 485, 25, 50);
        lvl6 = new Button("6", 150, 150, 385, 485, 25, 50);
        lvl7 = new Button("7", 150, 150, 615, 485, 25, 50);
        lvl8 = new Button("8", 150, 150, 845, 485, 25, 50);  

        red = new Button("", 150, 150, 155, 545, 25, 50);
        blue = new Button("", 150, 150, 385, 545 ,25, 50);
        green = new Button("", 150, 150, 615, 545 ,25, 50);
        yellow = new Button("", 150, 150, 845, 545 ,25, 50);
        
        redIdle = new Animation("dinoRRI", 4);
        greenIdle = new Animation("dinoGRI", 4);
        blueIdle = new Animation("dinoBRI", 4);
        yellowIdle = new Animation("dinoYRI", 4);
    }

    void display(){
        image(backgroundImg,0,0);
        fill(0);
        textAlign(CENTER);
        textSize(150);
        text(title.substring(0,10), 500, 180);
        textSize(50);
        text(title.substring(11), 500, 250);
        credits.display();
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
        image(loadImage("data/dinoRR1.png"),155 - 32, 545 - 34);
        blue.display();
        image(loadImage("data/dinoBR1.png"),385 - 32, 545 - 34);
        green.display();
        image(loadImage("data/dinoGR1.png"),615 - 32, 545 - 34);
        //greenIdle.display(590,265,5);
        yellow.display();
        image(loadImage("data/dinoYR1.png"),845 - 32, 545 - 34);

        
        //image(loadImage(character1),350,610);
        fill(255, 100, 100, 200);
        rect(270,300,380,265,25);
        fill(255);
        text("Player 1 ",270,220);
        if(character1 == "data/dinoRRI1.png") {
          redIdle.display(270 -34, 310 - 25, 5);
        }
        else if(character1 == "data/dinoBRI1.png") {
          blueIdle.display(270 - 34, 310 - 25, 5);
        }
        else if(character1 == "data/dinoGRI1.png") {
          greenIdle.display(270 - 34, 310 - 25, 5);
        }
        else if(character1 == "data/dinoYRI1.png") {
          yellowIdle.display(270 - 34, 310 - 25, 5);
        }
        

        fill(255, 100, 100, 200);
        rect(730,300,380,265,25);
        fill(255);
        text("Player 2 ",730,220);
        //image(loadImage(character2),620,310);
        if(character2 == "data/dinoRRI1.png") {
          redIdle.display(730 - 32, 310 - 25, 5);
        }
        else if(character2 == "data/dinoBRI1.png") {
          blueIdle.display(730 - 32, 310 - 25, 5);
        }
        else if(character2 == "data/dinoGRI1.png") {
          greenIdle.display(730 - 32, 310 -25, 5);
        }
        else if(character2 == "data/dinoYRI1.png") {
          yellowIdle.display(730 - 32, 310 - 25, 5);
        }
    }

    void displayControls(){
      image(backgroundImg,0,0);
      image(loadImage("data/instructions.png"),200,140);
      home.display();
    }

}
