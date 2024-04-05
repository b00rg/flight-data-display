class WidgetDropDown extends Widget {
  String[] elements;
  ArrayList<String> validData = new ArrayList<String>();
  String Search = "";
  boolean amIActive = false;
  int numOfDropsToDisplay = 5;
  String selectedValue = "";
  PFont font;
  String defaultText;
  int scrollIndex = 0; // This index tells the programme how far down the user has scrolled
  WidgetDropDown(int x, int y, int wide, int high, PFont myFont, String[] input, String defaul)
  {
    super(x, y, wide, high, 0);
    font = myFont;
    elements = input;
    for (String unit : elements)
    {
      validData.add(unit);
    }
    defaultText = defaul;
  }
  
  // initiates the drop down
  void initiativeDropDown() {
    isDropDownActive = true;
    this.amIActive = true;
  }
  
  // removes the drop down and disables relevant boolean values, setting the dropdown up for future interaction
  void removeDropDown() {
    scrollIndex = 0;
    isDropDownActive = false;
    this.amIActive = false;
    Search = "";
  }
  
  // chenges the scroll index based on how the user scrolled
  void scroll(int i) {
    scrollIndex += i;
    if (scrollIndex < 0) {
      scrollIndex = 0 ;
    }
    if (scrollIndex > - numOfDropsToDisplay + elements.length)
    {
      scrollIndex = elements.length - numOfDropsToDisplay;
    }
  }
  
  // renders the button, if the drop downs are active it calls the renderDrop() method
  void render() {
    fill(screen.SECONDARY_COLOR);
    rect(xpos, ypos, wide, high, 10, 10, 0, 0);
    fill(screen.TEXT_COLOR);
    if (amIActive)
    {
      fill(screen.TEXT_COLOR);
      text(Search, xpos + 5, ypos + high /2);
      renderDrops();
    } else
    {
      fill(screen.TEXT_COLOR);
      textAlign(LEFT, CENTER);
      text(selectedValue, xpos + 5, ypos + high/3);
    }
  }
  
  // renders the drop downs of the drop down menu
  void renderDrops()
  {
    for (int i = 0; i < numOfDropsToDisplay; i++)
    {
      try {
        fill(screen.TEXT_COLOR);
        textAlign(LEFT, CENTER);
        text(validData.get(i + scrollIndex), xpos + 5, ypos + high/3 + high * (i + 1)); // we try to render the text to see if we are out of bounds so we don't render an empty box
        fill(screen.TERTIARY_COLOR);
        textFont(TextBoxFont);
        rect(xpos, ypos + high * (i + 1), wide, high);
        fill(screen.TEXT_COLOR);
        text(validData.get(i + scrollIndex), xpos + 5, ypos + high/3 + high * (i + 1)); // now we render the text again over the box
      }
      catch (Exception e)
      {
        println("error reach " + e);
        break; // we reached the end and have no more elements to display
      }
    }
  }
  void isClicked() {
    if (isMouseover() && !amIActive)
    {
      initiativeDropDown();
    } else if (amIActive && isMouseover()) // if the user clicked the original button, (which is empty)
    {
      selectedValue = defaultText; // We reset the value selected to be nothing
      removeDropDown();
    } else if (amIActive)
    {
      for (int i = 0; i < numOfDropsToDisplay; i++)
      {
        if ((xpos < mouseX && xpos + wide > mouseX) && (ypos + (high * (i + 1)) < mouseY && ((ypos + (high * (i + 1))) + high > mouseY))) // We go through every element in the drop box
        {
          try {
            selectedValue = validData.get(i + scrollIndex);
            removeDropDown();
            break;
          }
          catch (Exception e) {
            selectedValue = defaultText;
            removeDropDown();
            break;
          }
        }
      }
      removeDropDown();
    }
  }

  // Method called if dropdown is active, allows the drop down to accept text input and avoid displaying datapoints that do not match what the user is typing
  void searchBarinput(char input) {
    try
    {
      if ((int)input == 8)
      { // the user pressed backspace
        backSpacePressed();
        searchBarUpdated();
      } else {
        input =  Character.toUpperCase(input);
        Search += input;
        searchBarUpdated();
      }
      scrollIndex = 0;
    }
    catch (Exception e)
    {
      // do nothing if we could not process the user input
      // most likely the user pressed an input that we did not expect, and failed at the Character.toUpperCase line, in which case we don't care
    }
  }

  // Method called  when user changes anything in the search bar, it filters the elements array to the arraylist of topDisplay when called.
  void searchBarUpdated() {
    validData.clear();
    for (String element : elements) {
      if (element.startsWith(Search)) {
        validData.add(element);
      }
    }
  }
  // method to be executed if user pressed backspace while typing on the drop down search bar
  void backSpacePressed() {
    try
    {
      Search = Search.substring(0, Search.length() - 1); // remove the last character if the user presses backspace
    }
    catch ( Exception e)
    {
      Search = "";
      // The user used backspace even tho nothing is written, do nothing
    }
  }
}
