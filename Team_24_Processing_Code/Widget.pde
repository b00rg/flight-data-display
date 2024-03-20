class Widget{
  boolean active = false; // Is this button active?)
  int xpos, ypos, wide, heigh; // position and size of the widget
  String label = "";
  
  Widget(int x, int y, int w, int h){
    xpos = x;
    ypos = y;
    wide = w;
    heigh = h;
  }
  
  boolean isMouseover(){
    return (xpos < mouseX && xpos > mouseX + wide) && (ypos < mouseY && ypos > mouseY + heigh);
  }
  void printLabel(){
    
  }
  boolean isInputValidtimeRange(String input){
    String regex = "^(?:[01]?[0-9]|2[0-3]):[0-5][0-9]$";
    Pattern pattern = Pattern.compile(regex);
    Matcher matcher = pattern.matcher(input);
    return matcher.matches();
  }
}
