class WidgetDropDown extends Widget{
  String[] elements;
  boolean amIActive = false;
  int numOfDropsToDisplay = 5;
  int currentlySelectedElement = -1;
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
    this.amIActive = true;
  }
  void removeDropDown(){
    scrollIndex = 0;
    isDropDownActive = false;
    this.amIActive = false;
  }
  void scroll(int i){
    scrollIndex += i;
    if(scrollIndex < 0) { scrollIndex = 0 ;}
    if(scrollIndex > - numOfDropsToDisplay + elements.length)
    {
      scrollIndex = elements.length - numOfDropsToDisplay;
    }
  }
  void render(){
    fill(255);
    rect(xpos, ypos, wide, high,10,10,0,0);
    if(amIActive)
    {
      renderDrops();
    } else 
    {
      fill(0);
      textAlign(LEFT, CENTER);
      if(currentlySelectedElement != -1)
      {
        text(elements[currentlySelectedElement], xpos + 5, ypos + high/3);
      }
    }
  }
  void renderDrops()
  {
    textFont(font);
    for(int i = 0; i < numOfDropsToDisplay; i++)
    {
      fill(245 - i * 10);
      rect(xpos, ypos + high * (i + 1), wide, high);
      fill(0);
      textAlign(LEFT, CENTER);
      text(elements[i + scrollIndex], xpos + 5, ypos + high/3 + high * (i + 1));
    }
  }
  void isClicked(){
    if(isMouseover() && !amIActive)
    {
      initiativeDropDown();
    } else if(amIActive && isMouseover()) // if the user clicked the original button, (which is empty)
    {
      currentlySelectedElement = -1; // We reset the value selected to be nothing
      removeDropDown();
    }
    else if(amIActive)
    {
      for(int i = 0; i < numOfDropsToDisplay; i++)
      {
        if((xpos < mouseX && xpos + wide > mouseX) && (ypos + (high * (i + 1)) < mouseY && ((ypos + (high * (i + 1))) + high > mouseY))) // We go through every element in the drop box
        {
          currentlySelectedElement = i + scrollIndex;
          removeDropDown();
          break;
        }
      }
      removeDropDown();
    }
  }
}
