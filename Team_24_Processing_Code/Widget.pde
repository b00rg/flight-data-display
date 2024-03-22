class Widget{
  boolean active = false; // Is this button active?)
  int xpos, ypos, wide, high; // position and size of the widget
  String label = "";
  int roundness = WIDGET_ROUNDNESS;
  
  Widget(int x, int y, int w, int h){
    xpos = x;
    ypos = y;
    wide = w;
    high = h;
  }
  Widget(){} // empty widget constructor
  
  boolean isMouseover(){  // checks if the user mouse is hovering over the button
    {
      return (xpos < mouseX && xpos + wide > mouseX) && (ypos < mouseY && ypos + high > mouseY);
    }
  }

  boolean isInputValidtimeRange(String input){ // Checks if the inputed "XX:XX" string is a vald 24 hour clock representation
    try{
      String regex = "^(?:[01]?[0-9]|2[0-3]):[0-5][0-9]$";
      Pattern pattern = Pattern.compile(regex);
      Matcher matcher = pattern.matcher(input);
      return matcher.matches();
    } catch (Exception e)
    {
      return false; //if anytihng goes wrong with this most likely the user's input is bad
    }
  }
}
