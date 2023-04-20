class CharacterSprite{
  String[] leftView;
  String[] rightView;
  String jumpLeftView;
  String jumpRightView;
  int currentSpriteIndex; // Add a variable to keep track of the current sprite index
  
  CharacterSprite(String[] leftView, String[] rightView, String jumpLeftView, String jumpRightView){
    this.leftView = leftView;
    this.rightView = rightView;
    this.jumpLeftView = jumpLeftView;
    this.jumpRightView = jumpRightView;
  }
  
  String getCurrentSprite() {
    // Check if the character is jumping
    if (jumping1 || jumping2) {
      // Return the correct jump sprite based on the current direction
      if (keys[0] || keys[3]) { // Left
        return jumpLeftView;
      } else if (keys[1] || keys[4]) { // Right
        return jumpRightView;
      }
    } else {
      // Return the correct walking sprite based on the current direction and sprite index
      if (keys[0] || keys[3]) { // Left
        return leftView[currentSpriteIndex];
      } else if (keys[1] || keys[4]) { // Right
        return rightView[currentSpriteIndex];
      }
    }
    
    // If no sprite is returned yet, return the default sprite
    return rightView[0];
  }
}