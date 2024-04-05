class WidgetTextBox extends Widget {
  String textValue;
  String normal;
  boolean active = false;
  String num1;
  WIDGET_TEXT_TYPE myType;
  PFont font;

  WidgetTextBox(int x, int y, int w, int h, int R, PFont font, String defaul, WIDGET_TEXT_TYPE type) {
    super(x, y, w, h, R);
    this.font = font;
    normal = defaul;
    textValue = defaul;
    myType = type;
  }

  void render() {
    if (active) {
      fill(255); // Color when active
    } else {
      fill(200);
      //fill(screen.INACTIVE_TEXT_BOX); // Color when inactive
    }
    rect(xpos, ypos, wide, high, roundness);
    fill(screen.TEXT_COLOR);
    textAlign(LEFT, CENTER);
    textFont(font);
    if ((myType == WIDGET_TEXT_TYPE.DATE && active || (textValue != "DD/MM/YYYY")&& myType == WIDGET_TEXT_TYPE.DATE)) {
      text(textValue + "/01/2022", xpos + 5, ypos + high/3);
    } else
    {
      text(textValue, xpos + 5, ypos + high/3);
    }
  }

  void input(char key)
  {
    if (active)
    {
      switch(myType)
      {
      case TIME:
        switch(key)
        {
        case 8:
          backSpacePressed(); // user pressed backspace
          break;
        case 10:
          active = false; // user pressed enter
          break;
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
          textValue += key;
          addColonAndCheckCompletion();
          break;
        default:
          addColonAndCheckCompletion();
          break; // We do not allow the user to input anything but acceptable characters
        }

        break;
      case DATE:
        switch(key)
        {
        case 8:
          backSpacePressed(); // user pressed backspace
          break;
        case 10:
          active = false; // user pressed enter
          if (!isStringValid())
          {
            userInputInvalid();
          }
          addColonAndCheckCompletion();
          break;
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
          //case '/':
          textValue += key;
          if (textValue.length() == 2) {
            active = false;
            if (!isStringValid())
            {
              userInputInvalid();
            }
          }
          break;
        default:
          break;
        }
      }
    }
  }

  // this method is called for all text boxes when the user clickes, this method checks if the text box has been clicked, if yes, it activates
  void isClicked()
  {
    if (isMouseover())
    {
      active = true; // activate text box
      textValue = ""; // reset textValue so user can provide new input as they please
    } else
    {
      active = false;
      if (isStringValid())
      {
      } else
      {
        userInputInvalid();
      }
    }
  }

  // method to be executed if user pressed backspace while typing on the text box
  void backSpacePressed() {
    try
    {
      textValue = textValue.substring(0, textValue.length() - 1); // remove the last character if the user presses backspace
    }
    catch ( Exception e)
    {
      textValue = "";
      // The user used backspace even tho nothing is written, do nothing
    }
  }

  // Search to see if the user input already has the HH of the HH:MM, if so add the semicolon to make the typing easier for the user;
  // In addition the method checks if the user has completed a full input, and automaticall deactivates the button should the user do so
  void addColonAndCheckCompletion() {
    if (textValue.length() == 2)
    {
      textValue += ":";
    }
    if (textValue.length() == 5)
    {
      active = false;
      if (!isStringValid())
      {
        textValue = normal;
      }
    }
  }

  // instructions of what to do if the input the user has entered by either pressing enter or clicking away is not valid
  // This should be called only when the user has given their full input
  void userInputInvalid() {
    active = false;
    textValue = normal;
  }
  // Investigate if textValue, the user input, is actually a valid input for the button type of this object
  boolean isStringValid() {
    if (myType == WIDGET_TEXT_TYPE.TIME)
    {
      if (textValue.length() != 5)
      {
        return false; // takes care of a specific edge case
      }
      String[] parts = textValue.split(":");
      if (parts.length == 2) { // Ensure there are two parts
        try {
          int hours = Integer.parseInt(parts[0]);
          int minutes = Integer.parseInt(parts[1]);

          // Check if hours and minutes are in valid ranges
          if (hours >= 0 && hours <= 23 && minutes >= 0 && minutes <= 59) {
            return true; // Time is valid
          }
        }
        catch (NumberFormatException e) {
          return false;
        }
      } else
      {
        return Integer.parseInt(textValue) >= 0 && Integer.parseInt(textValue) <= 31;
      }
    } else
    {// button type is date
      try {
        return (Integer.parseInt(textValue) <= 31);
      }
      catch (Exception e)
      {
        return false;
      }
    }
    return false; // unreachable code, processing still needs it for some reason though
  }
  // method used in the reload event, it returns a string representation of the button's input
  String giveProcessedUserInput() {
    if (myType == WIDGET_TEXT_TYPE.TIME)
    {
      return textValue.replace(":", "").trim();
    } else
    {
      try {
        if (textValue == "" || textValue == null || textValue == normal) {
          return null;
        }
        println("The textValue is atm = " + textValue);
        String Day = textValue;
        Day = (("2022/01/" + Day));
        Day = Day.replace("/", "-");
        return Day;
      }
      catch (Exception e)
      {
        return null;
      }
    }
  }
}
