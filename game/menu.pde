class Menu{
    PImage backgroundImg;
    Button easy, medium, hard;
    String title;
    Menu(PImage image, String name){
        backgroundImg = image;
        title = name;
        // Button("label", xSize, ySize, xPos, yPos) we can also include the color parameters here
        easy = new Button("Easy",120,80,350,500);
        medium = new Button("Medium",200,80,600,500);
        hard = new Button("Hard",120,80,770,500);

    }

    void display(){
        image(backgroundImg,0,0);
        fill(0);
        textSize(100);
        text(title, 300, 300);
        easy.display();
        medium.display();
        hard.display();
    }

}