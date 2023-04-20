class Menu{
    PImage backgroundImg;
    Button home, play, charSel, controls, credits, lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7, lvl8;
    Button red, blue, green, yellow;
    Button P1Button, P2Button;
    String title;
    String character1, character2;
    Animation redIdle, blueIdle, greenIdle, yellowIdle;
    
    Menu(PImage image, String name){
        backgroundImg = image;
        title = name;
        // Button("label", xSize, ySize, xPos, yPos, radius, textSize) we can also include the color parameters here
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
        
        P1Button = new Button("", 380, 265, 270, 300, 25, 0);
        P2Button = new Button("", 380, 265, 730, 300, 25, 0);
        
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
        play.display();
        charSel.display();
        controls.display();
        credits.display();
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
        yellow.display();
        image(loadImage("data/dinoYR1.png"),845 - 32, 545 - 34);


        P1Button.display();
        if(P1 == true){
          stroke(255);
          fill(255,0);
          rect(270,300,380,265,25);
        }
        noStroke();
        fill(255);
        text("Player 1 ",270,220);
        if(character1 == "data/dinoRRI1.png") {
          redIdle.display(270 - 64, 310 - 40, 5, 128, 136);
        }
        else if(character1 == "data/dinoBRI1.png") {
          blueIdle.display(270 - 64, 310 - 40, 5, 128, 136);
        }
        else if(character1 == "data/dinoGRI1.png") {
          greenIdle.display(270 - 64, 310 - 40, 5, 128, 136);
        }
        else if(character1 == "data/dinoYRI1.png") {
          yellowIdle.display(270 - 64, 310 - 40, 5, 128, 136);
        }
        
        
        P2Button.display();
        if(P2 == true){
          stroke(255);
          fill(255,0);
          rect(730,300,380,265,25);
        }
        noStroke();
        fill(255);
        text("Player 2 ",730,220);
        //image(loadImage(character2),620,310);
        if(character2 == "data/dinoRRI1.png") {
          redIdle.display(730 - 64, 310 - 40, 5, 128, 136);
        }
        else if(character2 == "data/dinoBRI1.png") {
          blueIdle.display(730 - 64, 310 - 40, 5, 128, 136);
        }
        else if(character2 == "data/dinoGRI1.png") {
          greenIdle.display(730 - 64, 310 - 40, 5, 128, 136);
        }
        else if(character2 == "data/dinoYRI1.png") {
          yellowIdle.display(730 - 64, 310 - 40, 5, 128, 136);
        }
    }   
    void displayControls() {
        image(backgroundImg,0,0);
        textAlign(CENTER);
        home.display();
        fill(255,100,100, 150);
        rect(500,400,840,415, 25);
        image(loadImage("data/upArrow.png"),120,230,100,100);
        image(loadImage("data/leftArrow.png"),120,350,100,100);
        image(loadImage("data/rightArrow.png"),120,470,100,100);
        image(loadImage("data/WKey.png"),530,230,100,100);
        image(loadImage("data/AKey.png"),530,350,100,100);
        image(loadImage("data/DKey.png"),530,470,100,100);
        fill(255);
        textAlign(LEFT);
        text("Player 1 Jump", 260, 280);
        text("Player 1 Left", 260, 400);
        text("Player 1 Right", 260, 520);
        text("Player 2 Jump", 670, 280);
        text("Player 2 Left", 670, 400);
        text("Player 2 Right", 670, 520);
        textAlign(CENTER);
        
    }
    
    void displayCredits() {
        image(backgroundImg,0,0);
        textAlign(CENTER);
        home.display();
        fill(255,100,100, 150);
        rect(500,400,840,415, 25);
        fill(255);
        text("CREATED BY:", 500,230);
        textSize(20);
        text("AARON SONG & THOMAS PENA", 500, 260);
        textSize(30);
        text("MUSIC BY:",500,300);
        textSize(20);
        text("ABSTRACTION @ http://www.abstractionmusic.com/", 500, 330);
        textSize(30);
        text("CHARACTER ART BY:",500,370);
        textSize(20);
        text("ARKS @ arks.digital", 500, 400);
    }
}
