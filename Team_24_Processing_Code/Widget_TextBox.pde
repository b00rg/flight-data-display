class WidgetTextBox extends Widget{
  String textValue;
  String normal;
  boolean active = false;
  String num1;
  String num2;
  WIDGET_TEXT_TYPE myType;
  //int xpos, ypos, wide, heigh;
  PFont font;
  WidgetTextBox(int x, int y, int w, int h, int R, PFont font, String defaul, WIDGET_TEXT_TYPE type){
    super(x,y,w,h,R);
    this.font = font;
    normal = defaul;
    textValue = defaul;
    myType = type;
  }
  
  void render() {
    if (active) {
      fill(255); // Color when active
    } else {
      fill(200); // Color when inactive
    }
    rect(xpos, ypos, wide, high, roundness);
    fill(0);
    textAlign(LEFT, CENTER);
    textFont(font);
    text(textValue, xpos + 5, ypos + high/3);
  }
  
  void input(char key) {
    if (active) {
      if (key == 10)
      {
        active = false;
        if (isStringValind())
        {
          prepareUserInput();
        } else 
        {
          textValue = normal;
        }
        
      } else if (key == 65535)
      {
        // do nothing if the user presses shift
      } else if (key == 8)
      {
        try
        {
          textValue = textValue.substring(0,textValue.length() - 1); // remove the last character if the user presses backspace
        } catch ( Exception e)
        {
          textValue = "";
          // The user used backspace even tho nothing is written, do nothing
        }
      } else
      {
          textValue += key;
      }
    }
  }
  void isClicked()
  {
    if(isMouseover())
    {
      active = true; 
      textValue = "";
    } else 
    {
      active = false;
      if(isStringValind())
      {
        prepareUserInput();
      } else 
      {
        textValue = normal;
      }
    }
  }
  boolean isStringValind() 
  {
    if(myType == WIDGET_TEXT_TYPE.TIME)
    {
      try{
        String[] uservalues = textValue.split("-");
        uservalues[0] = uservalues[0].trim();
        uservalues[1] = uservalues[1].trim();
        return(isInputValidtimeRange(uservalues[0]) && isInputValidtimeRange(uservalues[1]));
      } catch (Exception e)
      {
        return false;
      }
    } else // myType == DATE
    {
      try{
        String dateString = textValue;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        sdf.setLenient(false);
        Date date = sdf.parse(dateString);
        return true;
      } catch (Exception e)
      {
        return false;
      }
    }
  }
  void prepareUserInput(){ 
    if(myType == WIDGET_TEXT_TYPE.TIME)
    {
      String[] uservalues = textValue.split("-");
      num1 = uservalues[0].trim();// we trim the whitespaces from the values
      num2 = uservalues[1].trim();
      num1 = uservalues[0].replace(":","");// we remove the colon to have the user input in pure integer format
      num2 = uservalues[1].replace(":","");
      boolean temp = false;
      for(int i = 0; i < textBoxList.size(); i++)
      {
        if(textBoxList.get(i).textValue == normal)
        {
          temp = true;
        }
      }
      if(!temp)
      {
        this.textValue = "??:?? - ??:??";
        this.num1 ="error";
        this.num2 ="error";
      }
    } else 
    {
      // User is already prepared in format dd/mm/yyyy
      
    }
  }
}
