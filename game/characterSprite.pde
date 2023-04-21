class CharacterSprite{
  String[] leftView;
  String[] rightView;
  String jumpLeftView;
  String jumpRightView;
  int currentSpriteIndex;
  
  CharacterSprite(String[] leftView, String[] rightView, String jumpLeftView, String jumpRightView){
    this.leftView = leftView;
    this.rightView = rightView;
    this.jumpLeftView = jumpLeftView;
    this.jumpRightView = jumpRightView;
  }
}