class TimeTextbox {
  String textValue = "??:?? - ??:??";
  boolean active = false;
  int xpos, ypos, wide, heigh;
  TimeTextbox(int x, int y, int w, int h){
    xpos = x;
    ypos = y;
    wide = w;
    heigh = h;
  }
  
  void render() {
    if (active) {
      fill(255); // Color when active
    } else {
      fill(200); // Color when inactive
    }
    rect(xpos, ypos, wide, heigh);
    fill(0);
    textAlign(LEFT, CENTER);
    text(textValue, xpos + 5, ypos + heigh/2);
  }
  
  void input(char key) {
    if (active) {
      if (key == 10)
      {
        active = false;
        if (isStringValind())
        {
        
        } else 
        {
          textValue = "invalid, input ??:?? - ??:??";
        }
        } else 
        {
          textValue += key;
      }
    }
  }
  void isClicked()
  {
    if((mouseX > xpos && mouseX < xpos + wide) && (mouseY > ypos && mouseY < heigh + ypos))
    {
      active = true; 
      textValue = "";
    } else 
    {
      active = false;
      if (isStringValind())
      {
        
      } else 
      {
        textValue = "invalid, input ??:?? - ??:??";
      }
      
    }
  }
  boolean isStringValind() // By far the dumbest and most awefull code I ever wrote, if you wanna improve this please do - Angelos
  {
    if(textValue.charAt(0) < '0' && textValue.charAt(0) > '9')
    {
       return false;
    }
    if(textValue.charAt(1) < '0' && textValue.charAt(1) > '9')
    {
       return false;
    }
    if(textValue.charAt(2) != ':')
    {
       return false;
    }
    if(textValue.charAt(3) < '0' && textValue.charAt(3) > '9')
    {
       return false;
    }
    if(textValue.charAt(4) < '0' && textValue.charAt(4) > '9')
    {
       return false;
    }
    if(textValue.charAt(5) != ' ')
    {
       return false;
    }
    if(textValue.charAt(6) != '-')
    {
       return false;
    }
    if(textValue.charAt(7) != ' ')
    {
       return false;
    }
    if(textValue.charAt(8) < '0' && textValue.charAt(8) > '9')
    {
       return false;
    }
    if(textValue.charAt(9) < '0' && textValue.charAt(9) > '9')
    {
       return false;
    }
    if(textValue.charAt(10) != ':')
    {
       return false;
    }
    if(textValue.charAt(11) < '0' && textValue.charAt(11) > '9')
    {
       return false;
    }
    if(textValue.charAt(12) < '0' && textValue.charAt(12) > '9')
    {
       return false;
    }
    return true;
  }
}
