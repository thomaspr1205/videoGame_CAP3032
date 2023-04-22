class CharacterSprite{
  String[] leftView;
  String[] rightView;
  String jumpLeftView;
  String jumpRightView;
  int currentSpriteIndex;
  
  // creates character sprite with the following parameters
  CharacterSprite(String[] leftView, String[] rightView, String jumpLeftView, String jumpRightView){
    this.leftView = leftView;
    this.rightView = rightView;
    this.jumpLeftView = jumpLeftView;
    this.jumpRightView = jumpRightView;
  }
}
