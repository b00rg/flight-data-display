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
    if (active)
      fill(255); // Color when active
    else
      fill(screen.INACTIVE_TEXT_BOX); // Color when inactive

    rect(xpos, ypos, wide, high, roundness);
    fill(screen.TEXT_COLOR);
    textAlign(LEFT, CENTER);
    textFont(font);
    text(textValue, xpos + 5, ypos + high/3);
  }

  boolean isNumber(char testChar)
  {
    if (testChar >= '0' && testChar <= '9')
      return true;
    return false;
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
          break;
        default:
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
        case '/':
          textValue += key;
          break;
        default:
          break;
        }
      }
    }
    addColon();
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
        prepareUserInput();
      } else
      {
        textValue = normal;
      }
    }
  }

  boolean isStringValid()
  {
    if (myType == WIDGET_TEXT_TYPE.TIME)
    {
      try {
        return true;
      }
      catch (Exception e)
      {
        return false;
      }
    } else // myType == DATE
    {
      try {
        String dateString = textValue;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        sdf.setLenient(false);
        Date date = sdf.parse(dateString);
        return true;
      }
      catch (Exception e)
      {
        return false;
      }
    }
  }
  void prepareUserInput() {
    if (myType == WIDGET_TEXT_TYPE.TIME)
    {
      num1 = textValue.replace(":", "");// we remove the colon to have the user input in pure integer format

      boolean temp = false;
      for (int i = 0; i < textBoxList.size(); i++)
      {
        if (textBoxList.get(i).textValue == normal)
        {
          temp = true;
        }
      }
      if (!temp)
      {
        this.textValue = "??:??";
        this.num1 ="error";
        //this.num2 ="error";
      }
    } else
    {
      // User is already prepared in format dd/mm/yyyy
    }
  }

  boolean isInputValidtimeRange(String input) { // Checks if the inputed "XX:XX" string is a vald 24 hour clock representation

    if (input.length() == 5)
    {
      println(input.charAt(0) + input.charAt(1));
      int num1 = (int(input.charAt(0)) * 10) + int(input.charAt(1));
      int num2 = (int(input.charAt(3)) * 10) + int(input.charAt(4));
      if ((num1 >= 0 && num1 <= 23) || (num2 >= 0 && num2 <= 59))
        return true;
    }
    try {
      String regex = "^(?:[01]?[0-9]|2[0-3]):[0-5][0-9]$";
      Pattern pattern = Pattern.compile(regex);
      Matcher matcher = pattern.matcher(input);
      return matcher.matches();
    }
    catch (Exception e)
    {
      println("Input error");
      return false; //if anything goes wrong with this most likely the user's input is bad
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
  void addColon() {
    if (textValue.length() == 2)
    {
      textValue += ":";
    }
  }
}

/*
    if ((textValue.length() == 4) && isNumber(key))
 {
 active = false;
 if (isInputValidtimeRange(textValue))
 {
 prepareUserInput();
 }
 else
 {
 textValue = normal;
 }
 }
 else if (key == 10)
 {
 active = false;
 if (isInputValidtimeRange(textValue))
 {
 prepareUserInput();
 } else
 {
 textValue = normal;
 }
 
 }
 else if (key == 65535)
 {
 // do nothing if the user presses shift
 }
 else if (key == 8)
 {
 
 
 }
 else if (key >= '0' && key <= '9')
 {
 textValue += key;
 }
 */
