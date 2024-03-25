class WidgetDropDown extends Widget{
  String[] elements;
  boolean amIActive = false;
  int numOfDropsToDisplay = 5;
  int currentlySelectedElement = 0;
  PFont font;
  int scrollIndex = 0; // This index tells the programme how far down the user has scrolled
  WidgetDropDown(int x, int y, int wide, int high ,PFont myFont, String[] input)
  {
    super(x,y,wide,high, 0);
    font = myFont;
    elements = input;
  }
  void initiativeDropDown(){
    isDropDownActive = true; 
    amIActive = true;
  }
  void removeDropDown(){
    isDropDownActive = false;
    amIActive = false;
  }
  void scroll(int i){
    println(i + " is the value of the scroll");
  }
  void render(){
    rect(xpos, ypos, wide, high);
    if(amIActive)
    {
      renderDrops();
    } else 
    {
      fill(0);
      textAlign(LEFT, CENTER);
      text(elements[currentlySelectedElement], xpos + 5, ypos + high/3);
    }
  }
  void renderDrops()
  {
    textFont(font);
    for(int i = 0; i < numOfDropsToDisplay; i++)
    {
      rect(xpos, ypos + high * (i + 1), wide, high);
      fill(0);
      textAlign(LEFT, CENTER);
      text(elements[i], xpos + 5, ypos + high/3);
    }
  }
  void isClicked(){
    if(isMouseover() && !amIActive)
    {
      initiativeDropDown();
    }
    if(amIActive)
    {
      for(int i = 0; i < numOfDropsToDisplay; i++)
      {
        if((xpos < mouseX && xpos + wide > mouseX) && (ypos + (high * (i + 1)) < mouseY && (ypos + (high * (i + 1)) + high > mouseY))) // We go through every element in the drop box
        {
          currentlySelectedElement = i + scrollIndex;
          break;
        }
      }
    }
  }
}
